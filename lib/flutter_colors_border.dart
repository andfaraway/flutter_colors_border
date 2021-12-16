import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

class FlutterColorsBorder extends StatefulWidget {
  final Widget child;
  final Size size;
  final bool animation;
  final int animationDuration;
  final double boardRadius;

  final List<Color> colors;
  final double borderWidth;
  final bool available;

  const FlutterColorsBorder(
      {Key? key,
        required this.child,
        required this.size,
        this.colors = const [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.indigo,
          Colors.purple,
          Colors.black
        ],
        this.borderWidth = 2,
        this.animation = true,
        this.animationDuration = 5,
        this.boardRadius = 5,
        this.available = true})
      : super(key: key);

  @override
  _FlutterColorsBorderState createState() => _FlutterColorsBorderState();
}

class _FlutterColorsBorderState extends State<FlutterColorsBorder>
    with SingleTickerProviderStateMixin {
  AnimationController? _ctl;

  late List<Color> colors;

  @override
  void initState() {
    super.initState();
    if (widget.animation) {
      _ctl = AnimationController(
          vsync: this, duration: Duration(seconds: widget.animationDuration))
        ..forward()
        ..repeat();
    } else {
      _ctl = AnimationController(vsync: this);
    }

    colors = widget.colors;
  }

  @override
  void dispose() {
    _ctl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.available) return widget.child;
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(widget.boardRadius),
              child: widget.child),
          CustomPaint(
            size: widget.size,
            painter: _BorderPainter(_ctl!, colors, widget.borderWidth,
                boardRadius: widget.boardRadius),
          )
        ],
      ),
    );
  }
}

class _BorderPainter extends CustomPainter {
  final List<Color> colors;
  final double boardRadius;

  final AnimationController ctl;

  final double strokeWidth;

  _BorderPainter(this.ctl, this.colors, this.strokeWidth,
      {this.boardRadius = 5})
      : super(repaint: ctl);

  final Paint _paint = Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.clipRect(Offset.zero & size);
    var stops = colors
        .asMap()
        .map((key, value) => MapEntry(key, key / colors.length))
        .values
        .toList();

    Offset centerPos = Offset(size.width / 2, size.height / 2);

    _paint
      ..strokeWidth = strokeWidth
      ..strokeJoin = StrokeJoin.miter
      ..shader = ui.Gradient.sweep(centerPos, colors, stops, TileMode.repeated,
          pi * 2 * ctl.value, pi * 2 * (1 + ctl.value));

    canvas.drawDRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: centerPos, width: size.width, height: size.height),
            Radius.circular(boardRadius)),
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: centerPos,
                width: size.width - 2,
                height: size.height - 2),
            Radius.circular(boardRadius)),
        _paint);
  }

  @override
  bool shouldRepaint(covariant _BorderPainter oldDelegate) {
    return oldDelegate.ctl != ctl;
  }
}
