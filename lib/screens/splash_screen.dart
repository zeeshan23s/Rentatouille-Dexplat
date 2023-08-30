import '../exports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: AppAssets.appLogo,
        nextScreen: const AuthWrapper(),
        splashTransition: SplashTransition.scaleTransition,
        splashIconSize: Responsive.screenWidth(context) * 0.325,
        backgroundColor: Colors.white);
  }
}
