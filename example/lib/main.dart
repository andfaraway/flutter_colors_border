import 'package:flutter/material.dart';

import 'package:flutter_colors_border/flutter_colors_border.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterColorsBorder(
          size: Size(100,100),
          child: Center(
            child: Text('hello'),
          ),
        ),
      ),
    );
  }
}
