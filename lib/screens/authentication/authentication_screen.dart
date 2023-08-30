import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../exports.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.authScreenImage),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Responsive.screenHeight(context) * 0.5,
              width: Responsive.screenWidth(context),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.circular(Responsive.screenWidth(context) * 0.1),
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
                    SizedBox(height: Responsive.screenHeight(context) * 0.015),
                    Text(
                      ConstantText.authScreenDescription,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.030),
                    CustomButton(
                      label: 'Register',
                      onPressed: () => CustomModelSheets.bottomSheet(
                        context: context,
                        child: const RegistrationForm(),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.020),
                    GestureDetector(
                      onTap: () => CustomModelSheets.bottomSheet(
                          context: context, child: const LoginForm()),
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
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
                    SizedBox(height: Responsive.screenHeight(context) * 0.015),
                    Row(
                      children: [
                        Flexible(
                          child: Divider(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                        ),
                        SizedBox(
                          width: Responsive.screenWidth(context) * 0.1,
                          child: Text(
                            'Or',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.5),
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Flexible(
                          child: Divider(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.015),
                    Text(
                      'Continue with Social Media',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Responsive.screenHeight(context) * 0.015),
                    Container(
                      height: Responsive.screenHeight(context) * 0.065,
                      width: Responsive.screenHeight(context) * 0.065,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(
                            Responsive.screenHeight(context) * 0.05),
                      ),
                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.google,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        onPressed: () async {
                          await context
                              .read<AuthProvider>()
                              .googleLogin()
                              .whenComplete(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    auth.status['message'] ??
                                        'Login Unsuccessful!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: AppColors
                                                .lightThemePrimaryColor)),
                                backgroundColor:
                                    auth.status['status'] == 'success'
                                        ? Colors.green
                                        : Colors.red,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
