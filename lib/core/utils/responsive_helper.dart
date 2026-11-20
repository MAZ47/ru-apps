/// Lightweight helper for layout decisions that need the device size or
/// orientation without rebuilding the entire widget tree with MediaQuery.
library;

import 'package:flutter/widgets.dart';

enum DeviceClass { compact, medium, expanded }

class ResponsiveHelper {
  ResponsiveHelper._();

  static const double compactBreakpoint = 600;
  static const double expandedBreakpoint = 840;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static DeviceClass deviceClass(BuildContext context) {
    final w = screenWidth(context);
    if (w < compactBreakpoint) return DeviceClass.compact;
    if (w < expandedBreakpoint) return DeviceClass.medium;
    return DeviceClass.expanded;
  }

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  /// Drawer width as a percentage of the screen — kept consistent across
  /// the app's compact layouts.
  static double drawerWidth(BuildContext context) =>
      screenWidth(context) * 0.8;
}




