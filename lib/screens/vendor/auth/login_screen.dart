// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';

// class UserLoginScreen extends StatefulWidget {
//   const UserLoginScreen({super.key});

//   @override
//   State<UserLoginScreen> createState() => _UserLoginScreenState();
// }

// class _UserLoginScreenState extends State<UserLoginScreen>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController _phoneController = TextEditingController();
//   late AnimationController _animController;
//   late Animation<double> _fadeIn;

//   @override
//   void initState() {
//     super.initState();
//     _animController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _fadeIn = CurvedAnimation(
//       parent: _animController,
//       curve: Curves.easeIn,
//     );
//     _animController.forward();
//   }

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _animController.dispose();
//     super.dispose();
//   }

//   /// 🔥 IMAGE BOX
//   Widget buildGridImage(String path) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(16),
//       child: SizedBox(
//         height: 100,
//         width: 100,
//         child: Image.asset(
//           path,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   /// 🔥 CUSTOM TOP DESIGN (IMPORTANT)
//   Widget buildTopLayout() {
//     return Column(
//       children: [
//         const SizedBox(height: 40),

//         /// 🔥 ROW 1 (3 images)
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             children: [
//               Expanded(child: buildGridImage('assets/images/Frame1.png')),
//               const SizedBox(width: 10),
//               Expanded(child: buildGridImage('assets/images/Frame 2.png')),
//               const SizedBox(width: 10),
//               Expanded(child: buildGridImage('assets/images/Frame3.png')),
//             ],
//           ),
//         ),

//         const SizedBox(height: 10),

//         /// 🔥 ROW 2 (4 images with side cut)
//         SizedBox(
//           height: 100,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             physics: const NeverScrollableScrollPhysics(),
//             children: [
//               Transform.translate(
//                 offset: const Offset(-30, 0), // LEFT CUT
//                 child: buildGridImage('assets/images/Frame4.png'),
//               ),
//               const SizedBox(width: 10),
//               buildGridImage('assets/images/Frame5.png'),
//               const SizedBox(width: 10),
//               buildGridImage('assets/images/Frame6.png'),
//               const SizedBox(width: 10),
//               Transform.translate(
//                 offset: const Offset(30, 0), // RIGHT CUT
//                 child: buildGridImage('assets/images/Frame7.png'),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 10),

//         /// 🔥 ROW 3 (3 images)
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             children: [
//               Expanded(child: buildGridImage('assets/images/Frame8.png')),
//               const SizedBox(width: 10),
//               Expanded(child: buildGridImage('assets/images/Frame9.png')),
//               const SizedBox(width: 10),
//               Expanded(child: buildGridImage('assets/images/Frame10.png')),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final gridHeight = size.height * 0.55;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           /// 🔥 TOP DESIGN
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             height: gridHeight,
//             child: buildTopLayout(),
//           ),

//           /// 🔥 BIG IMAGE (Frame11)
//           Positioned(
//             top: gridHeight - 80,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//                 height:120,
//               'assets/images/Frame11.png',
//                fit: BoxFit.fitWidth, // 👈 KEY CHANGE
//                alignment: Alignment.center,
//             ),
//           ),

//           /// 🔥 GRADIENT
//           Positioned(
//             top: gridHeight * 0.5,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.white.withOpacity(0.0),
//                     Colors.white.withOpacity(0.6),
//                     Colors.white.withOpacity(0.9),
//                     Colors.white,
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           /// 🔥 MAIN UI
//           SafeArea(
//             child: FadeTransition(
//               opacity: _fadeIn,
//               child: Column(
//                 children: [
//                   const Expanded(child: SizedBox()),

//                   /// LOGO
//                   Container(
//                     height: 80,
//                     width: 80,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.black87, width: 1.5),
//                     ),
//                     child: ClipOval(
//                       child: Image.asset(
//                         'assets/images/logo.jpeg',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   const Text(
//                     'Log in or Sign up',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   /// INPUT
//                   Container(
//                     height: 55,
//                     margin: const EdgeInsets.symmetric(horizontal: 24),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey.shade300),
//                     ),
//                     child: Row(
//                       children: [
//                         const Padding(
//                           padding: EdgeInsets.only(left: 16, right: 12),
//                           child: Text('+91'),
//                         ),
//                         Container(
//                           width: 1,
//                           height: 24,
//                           color: Colors.grey.shade300,
//                         ),
//                         Expanded(
//                           child: TextField(
//                             controller: _phoneController,
//                             keyboardType: TextInputType.phone,
//                             maxLength: 10,
//                             decoration: const InputDecoration(
//                               hintText: 'Enter your number',
//                               border: InputBorder.none,
//                               counterText: '',
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 16, vertical: 15),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   /// BUTTON
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 24),
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 52,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/otp');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF1B5E20),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text('Continue'),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   /// TERMS
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: RichText(
//                       textAlign: TextAlign.center,
//                       text: TextSpan(
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey.shade600,
//                         ),
//                         children: [
//                           const TextSpan(
//                               text: 'By continuing, you agree to our '),
//                           TextSpan(
//                             text: 'Terms of Service',
//                             style: const TextStyle(
//                                 decoration: TextDecoration.underline),
//                             recognizer: TapGestureRecognizer()..onTap = () {},
//                           ),
//                           const TextSpan(text: ' & '),
//                           TextSpan(
//                             text: 'Privacy Policy',
//                             style: const TextStyle(
//                                 decoration: TextDecoration.underline),
//                             recognizer: TapGestureRecognizer()..onTap = () {},
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 32),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();

  late AnimationController _animController;
  late Animation<double> _fadeIn;
  late AnimationController _scrollController;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.forward();

    _scrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _animController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _tile(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        path,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _animatedRow(List<String> images, {required bool goLeft}) {
    const double itemW = 110.0; // 100 image + 10 gap
    final double loopWidth = images.length * itemW;
    final List<String> doubled = [...images, ...images];

    return SizedBox(
      height: 100,
      child: ClipRect(
        child: OverflowBox(
          maxWidth: double.infinity,
          alignment: Alignment.centerLeft,
          child: AnimatedBuilder(
            animation: _scrollController,
            builder: (context, child) {
              final double offset =
                  (_scrollController.value * loopWidth) % loopWidth;
              final double shift = goLeft ? -offset : offset - loopWidth;
              return Transform.translate(
                offset: Offset(shift, 0),
                child: child,
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: doubled.map((p) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _tile(p),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20), // ← 40 se 20 kiya — bottom overflow band
        _animatedRow([
          'assets/images/Frame1.png',
          'assets/images/Frame 2.png',
          'assets/images/Frame3.png',
        ], goLeft: true),
        const SizedBox(height: 10),
        _animatedRow([
          'assets/images/Frame4.png',
          'assets/images/Frame5.png',
          'assets/images/Frame6.png',
          'assets/images/Frame7.png',
        ], goLeft: false),
        const SizedBox(height: 10),
        _animatedRow([
          'assets/images/Frame8.png',
          'assets/images/Frame9.png',
          'assets/images/Frame10.png',
        ], goLeft: true),
        const SizedBox(height: 10),
        _animatedRow([
          'assets/images/Frame3.png',
          'assets/images/Frame6.png',
          'assets/images/Frame9.png',
        ], goLeft: false),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final gridHeight = size.height * 0.55;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.hardEdge, // ← Stack se bhi kuch bahar na jaaye
        children: [
          // ── Animated image grid ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: gridHeight,
            child: ClipRect( // ← hard clip — grid kabhi gridHeight se bahar nahi jaayega
              child: _buildGrid(),
            ),
          ),

          // ── White gradient fade ──
          Positioned(
            top: gridHeight * 0.5,
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.0),
                      Colors.white.withOpacity(0.6),
                      Colors.white.withOpacity(0.9),
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Login form ──
          SafeArea(
            child: FadeTransition(
              opacity: _fadeIn,
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),

                  // Logo
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black87, width: 1.5),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Log in or Sign up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Phone input
                  Container(
                    height: 55,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16, right: 12),
                          child: Text('+91'),
                        ),
                        Container(
                          width: 1,
                          height: 24,
                          color: Colors.grey.shade300,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            decoration: const InputDecoration(
                              hintText: 'Enter your number',
                              border: InputBorder.none,
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Continue button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/otp'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Terms & Privacy
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                        children: [
                          const TextSpan(
                              text: 'By continuing, you agree to our '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: const TextStyle(
                                decoration: TextDecoration.underline),
                            recognizer:
                                TapGestureRecognizer()..onTap = () {},
                          ),
                          const TextSpan(text: ' & '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                                decoration: TextDecoration.underline),
                            recognizer:
                                TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
