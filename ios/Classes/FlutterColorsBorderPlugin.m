#import "FlutterColorsBorderPlugin.h"
#if __has_include(<flutter_colors_border/flutter_colors_border-Swift.h>)
#import <flutter_colors_border/flutter_colors_border-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_colors_border-Swift.h"
#endif

@implementation FlutterColorsBorderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterColorsBorderPlugin registerWithRegistrar:registrar];
}
@end
