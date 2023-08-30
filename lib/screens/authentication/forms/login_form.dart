import '../../../exports.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: Responsive.screenHeight(context) * 0.8,
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Responsive.screenHeight(context) * 0.04,
                        horizontal: Responsive.screenWidth(context) * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Welcome',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.005),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Login to your account',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.02),
                        CustomizedTextField(
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Email can\'t be blank';
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'Invalid Email';
                            }
                            return null;
                          }),
                          controller: _emailController,
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.015),
                        CustomizedTextField(
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return 'Password can\'t be blank';
                            }
                            if (value.length < 8 || value.length > 15) {
                              return 'Invalid Password';
                            }
                            return null;
                          }),
                          controller: _passwordController,
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: isPasswordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () => setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            }),
                          ),
                          obscureText: !isPasswordVisible,
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.008),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            CustomModelSheets.bottomSheet(
                              context: context,
                              child: const PasswordResetForm(),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Forgot password? ',
                              style: Theme.of(context).textTheme.bodySmall,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Click here',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.03),
                        CustomButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await context
                                  .read<AuthProvider>()
                                  .login(_emailController.text,
                                      _passwordController.text)
                                  .whenComplete(() {
                                Navigator.pop(context);
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
                            }
                          },
                          label: 'Login',
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          isLoading: auth.isLoading,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        CustomModelSheets.bottomSheet(
                            context: context, child: const RegistrationForm());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don’t have an account? ',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w400),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign up',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
