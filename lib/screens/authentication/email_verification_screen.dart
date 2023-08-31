import '../../exports.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Responsive.screenWidth(context) * 0.02,
                vertical: Responsive.screenHeight(context) * 0.05),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text('Almost there!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w900)),
                ),
                SizedBox(height: Responsive.screenHeight(context) * 0.12),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                      'Just follow the link we sent to: ${auth.currentUser!.email}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: Responsive.screenHeight(context) * 0.12),
                Icon(Icons.mail_outlined,
                    size: Responsive.screenHeight(context) * 0.1),
                SizedBox(height: Responsive.screenHeight(context) * 0.08),
                CustomButton(
                  onPressed: () async {
                    await OpenMailApp.openMailApp().then((result) => {
                          if (!result.didOpen && !result.canOpen)
                            {showNoMailAppsDialog(context)}
                          else if (!result.didOpen && result.canOpen)
                            {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return MailAppPickerDialog(
                                    mailApps: result.options,
                                  );
                                },
                              )
                            }
                        });
                  },
                  label: 'Open my email app',
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                SizedBox(height: Responsive.screenHeight(context) * 0.025),
                CustomButton(
                  onPressed: () => context.read<AuthProvider>().logout(),
                  label: 'Logout',
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                SizedBox(height: Responsive.screenHeight(context) * 0.025),
                GestureDetector(
                  onTap: () {
                    auth.sendEmailVerification().whenComplete(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(auth.status['message']!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: AppColors.lightThemePrimaryColor)),
                          backgroundColor: auth.status['status'] == 'success'
                              ? Colors.green
                              : Colors.red,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    });
                  },
                  child: Text(
                    'I did not receive an email',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: Responsive.screenHeight(context) * 0.091),
                Text(
                  'Note: After Verifying your email. Logout to re-authenticate!',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: Responsive.screenHeight(context) * 0.012),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
