import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constants/app_colors.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  int _resendSeconds = 25;
  Timer? _timer;

  final List<String> _plantImages = [
    'https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?w=200&q=70',
    'https://images.unsplash.com/photo-1509423350716-97f9360b4e09?w=200&q=70',
    'https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=200&q=70',
    'https://images.unsplash.com/photo-1463936575829-25148e1db1b8?w=200&q=70',
    'https://images.unsplash.com/photo-1501004318855-dc52a386169c?w=200&q=70',
    'https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?w=200&q=70',
    'https://images.unsplash.com/photo-1509423350716-97f9360b4e09?w=200&q=70',
    'https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=200&q=70',
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Plant images grid
              SizedBox(
                height: 220,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        _plantImages[index],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.priceBg,
                          child: const Icon(Icons.eco, color: AppColors.primaryGreen),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Back button + OTP form
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // Back button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          children: const [
                            Icon(Icons.arrow_back_ios, size: 18, color: AppColors.textPrimary),
                            SizedBox(width: 4),
                            Text(
                              'OTP Verification',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'We have sent a verification code to',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '+91 98765XXXXX',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // OTP Boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Container(
                          width: 56,
                          height: 56,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: AppColors.divider),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.primaryGreen,
                                  width: 2,
                                ),
                              ),
                            ),
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 3) {
                                _focusNodes[index + 1].requestFocus();
                              }
                              if (value.isEmpty && index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    // Resend timer
                    _resendSeconds > 0
                        ? Text(
                            'Resend OTP in $_resendSeconds sec',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() => _resendSeconds = 25);
                              _startTimer();
                            },
                            child: const Text(
                              'Resend OTP',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.primaryGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                    const SizedBox(height: 40),
                    // Continue button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/language');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

