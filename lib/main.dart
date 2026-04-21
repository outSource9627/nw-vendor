import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Auth screens
import 'screens/vendor/auth/splash_screen.dart';
import 'screens/vendor/auth/login_screen.dart';
import 'screens/vendor/auth/otp_screen.dart';
import 'screens/vendor/auth/language_screen.dart';
import 'screens/vendor/registration/business_registration_screen.dart';
import 'screens/vendor/home/vendor_dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const NurseryWallahApp());
}

class NurseryWallahApp extends StatelessWidget {
  const NurseryWallahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NurseryWallah',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xFF2E7D32),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          primary: const Color(0xFF2E7D32),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFF2E7D32),
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const UserLoginScreen(),
        '/otp': (context) => const OtpScreen(),
        '/language': (context) => const LanguageScreen(),
        '/registration': (context) => const BusinessRegistrationScreen(),
        '/vendor-dashboard': (context) => const VendorDashboardScreen(),
      },
    );
  }
}
