import 'exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, child) {
          return MaterialApp(
            title: 'Rentatouille',
            debugShowCheckedModeBanner: false,
            themeMode: theme.themeMode,
            theme: ThemeData(
              textTheme: TextTheme(
                headlineLarge: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.screenHeight(context) * 0.001 * 26,
                    height: Responsive.screenHeight(context) * 0.0018,
                    color: AppColors.lightThemeSecondaryColor),
                headlineMedium: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.screenHeight(context) * 0.001 * 22,
                    height: Responsive.screenHeight(context) * 0.0018,
                    color: AppColors.lightThemeSecondaryColor),
                headlineSmall: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.screenHeight(context) * 0.001 * 20,
                    height: Responsive.screenHeight(context) * 0.0018,
                    color: AppColors.lightThemeSecondaryColor),
                bodyLarge: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.screenHeight(context) * 0.001 * 18,
                    height: Responsive.screenHeight(context) * 0.0018,
                    color: AppColors.lightThemeSecondaryColor),
                bodyMedium: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.screenHeight(context) * 0.001 * 16,
                    height: Responsive.screenHeight(context) * 0.0018,
                    color: AppColors.lightThemeSecondaryColor),
                bodySmall: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.screenHeight(context) * 0.001 * 14,
                    height: Responsive.screenHeight(context) * 0.0018,
                    color: AppColors.lightThemeSecondaryColor),
              ),
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.lightThemePrimaryColor,
              primaryColor: AppColors.lightThemeSecondaryColor,
            ),
            darkTheme: ThemeData(
              textTheme: TextTheme(
                headlineLarge: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.screenHeight(context) * 0.001 * 26,
                    height: Responsive.screenHeight(context) * 0.0018,
                    color: AppColors.darkThemeSecondaryColor),
                headlineMedium: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.screenHeight(context) * 0.001 * 22,
                    height: Responsive.screenHeight(context) * 0.0018,
                    color: AppColors.darkThemeSecondaryColor),
                headlineSmall: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.screenHeight(context) * 0.001 * 20,
                    height: Responsive.screenHeight(context) * 0.0018,
                    color: AppColors.darkThemeSecondaryColor),
                bodyLarge: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.screenHeight(context) * 0.001 * 18,
                    height: Responsive.screenHeight(context) * 0.0018,
                    color: AppColors.darkThemeSecondaryColor),
                bodyMedium: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.screenHeight(context) * 0.001 * 16,
                    height: Responsive.screenHeight(context) * 0.0018,
                    color: AppColors.darkThemeSecondaryColor),
                bodySmall: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: Responsive.screenHeight(context) * 0.001 * 14,
                    height: Responsive.screenHeight(context) * 0.0018,
                    color: AppColors.darkThemeSecondaryColor),
              ),
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.darkThemePrimaryColor,
              primaryColor: AppColors.darkThemeSecondaryColor,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
