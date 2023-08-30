import '../../exports.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        // auth.logout();
        if (auth.currentUser != null) {
          if (auth.isNewUser) {
            return CreateUserScreen();
          } else {
            return const TenantHomeScreen();
          }
        } else {
          return const AuthenticationScreen();
        }
      },
    );
  }
}
