import 'package:flutter/widgets.dart';

extension ResponsiveExtension on BuildContext {
  Responsive get responsive => Responsive(this);
}

extension ResponsiveSizedBoxOnNum on num {
  Widget vs(BuildContext context) =>
      SizedBox(height: context.responsive.scaleHeight(toDouble()));
  Widget hs(BuildContext context) =>
      SizedBox(width: context.responsive.scaleWidth(toDouble()));
}

class Responsive {
  final BuildContext context;
  late double width;
  late double height;

  Responsive(this.context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  double scaleWidth(double value) {
    if (width <= 600) {
      // Mobile
      return value * (width / 375);
    } else if (width <= 1200) {
      // Tablet
      return value * (width / 768);
    } else {
      // Web/Desktop
      return value * (width / 1024);
    }
  }

  double scaleHeight(double value) {
    if (width <= 600) {
      // Mobile
      return value * (height / 667);
    } else if (width <= 1200) {
      // Tablet
      return value * (height / 800);
    } else {
      // Web/Desktop
      return value * (height / 900);
    }
  }

  double fontSize(double value) {
    if (width <= 600) {
      return value * (width / 375);
    } else if (width <= 1200) {
      return value * (width / 768);
    } else {
      return value * (width / 1024);
    }
  }

  EdgeInsets padding({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }) {
    return EdgeInsets.only(
      top: scaleHeight(top),
      bottom: scaleHeight(bottom),
      left: scaleWidth(left),
      right: scaleWidth(right),
    );
  }

  EdgeInsets allPadding(double value) {
    return EdgeInsets.all(scaleHeight(value));
  }

  EdgeInsets symmetricPadding({double vertical = 0, double horizontal = 0}) {
    return EdgeInsets.symmetric(
      vertical: scaleHeight(vertical),
      horizontal: scaleWidth(horizontal),
    );
  }

  double imageSize(double value) {
    if (width <= 600) {
      // Mobile
      return value * (width / 375);
    } else if (width <= 1200) {
      // Tablet
      return value * (width / 768);
    } else {
      // Web/Desktop
      return value * (width / 1024);
    }
  }

  int get gridCrossAxisCount {
    if (width <= 600) return 2;
    if (width <= 1200) return 3;
    return 4;
  }
}
