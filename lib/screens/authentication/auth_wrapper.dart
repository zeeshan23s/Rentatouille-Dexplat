import '../../exports.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        if (auth.currentUser != null) {
          if (auth.currentUser!.emailVerified) {
            if (auth.isNewUser) {
              return CreateUserScreen();
            } else {
              return const HomeScreen();
            }
          } else {
            return const EmailVerificationScreen();
          }
        } else {
          return const AuthenticationScreen();
        }
      },
    );
  }
}
