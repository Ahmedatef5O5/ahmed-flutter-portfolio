import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';

enum DeviceType { mobile, tablet, desktop }

class Responsive {
  final BuildContext _context;
  const Responsive._(this._context);

  factory Responsive.of(BuildContext context) => Responsive._(context);

  double get width => MediaQuery.sizeOf(_context).width;

  bool get isMobile => width < AppSizes.mobile;
  bool get isTablet => width >= AppSizes.mobile && width < AppSizes.tablet;
  bool get isDesktop => width >= AppSizes.tablet;

  DeviceType get device {
    if (isDesktop) return DeviceType.desktop;
    if (isTablet) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  T value<T>({required T mobile, T? tablet, required T desktop}) {
    if (isDesktop) return desktop;
    if (isTablet) return tablet ?? desktop;
    return mobile;
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext, Responsive) builder;
  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context, Responsive.of(context));
  }
}
