import '../exports.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
  }) : super(key: key);

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 500.0;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 500.0 &&
      MediaQuery.of(context).size.width < 1200.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 500) {
          return mobile;
        } else {
          return tablet;
        }
      },
    );
  }
}
