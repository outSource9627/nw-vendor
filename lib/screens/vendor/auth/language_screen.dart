import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int _selectedIndex = 0;

  final List<Map<String, String>> _languages = [
    {'name': 'English', 'subtitle': 'English'},
    {'name': 'हिंदी', 'subtitle': 'Hindi'},
    {'name': 'ગુજરાતી', 'subtitle': 'Gujarati'},
    {'name': 'मैथिली', 'subtitle': 'Maithili'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Green header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.language, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Language Preference',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          // Choose Language text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose Your Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Language options
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _languages.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final lang = _languages[index];
                final isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.priceBg : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected ? AppColors.primaryGreen : AppColors.divider,
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Radio indicator
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryGreen
                                  : AppColors.textHint,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryGreen,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lang['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    isSelected ? FontWeight.w600 : FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              lang['subtitle']!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Continue button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registration');
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
            ),
          ),
        ],
      ),
    );
  }
}
