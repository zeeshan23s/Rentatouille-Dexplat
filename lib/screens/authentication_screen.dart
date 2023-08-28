import '../exports.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.authScreenImage),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Responsive.screenHeight(context) * 0.45,
            width: Responsive.screenWidth(context),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Responsive.screenWidth(context) * 0.1),
                topRight:
                    Radius.circular(Responsive.screenWidth(context) * 0.1),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.screenWidth(context) * 0.14,
                  vertical: Responsive.screenHeight(context) * 0.04),
              child: Column(
                children: [
                  Text(
                    ConstantText.authScreenTitle,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Responsive.screenHeight(context) * 0.025),
                  Text(
                    ConstantText.authScreenDescription,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Responsive.screenHeight(context) * 0.05),
                  CustomButton(label: 'Register', onPressed: () {}),
                  SizedBox(height: Responsive.screenHeight(context) * 0.025),
                  GestureDetector(
                    onTap: () {},
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                            text: 'Log in',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
