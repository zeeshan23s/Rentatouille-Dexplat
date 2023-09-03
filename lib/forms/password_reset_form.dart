import '../exports.dart';

class PasswordResetForm extends StatefulWidget {
  const PasswordResetForm({super.key});

  @override
  State<PasswordResetForm> createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends State<PasswordResetForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          'Forgot Password',
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
                          'Reset your account password',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: Responsive.screenHeight(context) * 0.02),
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
                      SizedBox(height: Responsive.screenHeight(context) * 0.03),
                      Consumer<AuthProvider>(builder: (context, auth, child) {
                        return CustomButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              auth
                                  .forgotPassword(_emailController.text)
                                  .whenComplete(() {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      auth.status['message']!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: AppColors
                                                  .lightThemePrimaryColor),
                                    ),
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
                          label: 'Reset Password',
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          isLoading: auth.isLoading,
                        );
                      })
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
                        context: context,
                        child: const LoginForm(),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Remember your password? ',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w400),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
