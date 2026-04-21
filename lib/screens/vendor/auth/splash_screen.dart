import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Login after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: const Color(0xFF2E7D32)); // Fallback green
            },
          ),
          // Dark overlay for better logo visibility (optional, but good practice)
          Container(
            color: Colors.black.withOpacity(0.1),
          ),
          // Centered Logo
          Center(
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.jpeg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.white,
                      child: const Icon(
                        Icons.eco,
                        size: 100,
                        color: Color(0xFF2E7D32),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
