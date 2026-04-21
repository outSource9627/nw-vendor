import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../reviews/review_trust_screen.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileImage(),
                  const SizedBox(height: 24),
                  _buildProfileTitle(),
                  const SizedBox(height: 8),
                  const Text(
                    'Premium landscaping and garden design services for residential and commercial properties.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRatingSection(context),
                  const SizedBox(height: 24),
                  _buildSectionCard(
                    title: 'Address',
                    child: const Text(
                      '142 Oak Street\nPortland, OR 97201',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionCard(
                    title: 'Contact Details',
                    child: Column(
                      children: [
                        _buildContactRow(Icons.phone_outlined, '+91 98765 43210'),
                        const SizedBox(height: 12),
                        _buildContactRow(Icons.mail_outline, 'greenheavennursery@gmail.com'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionCard(
                    title: 'Service Area',
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9FBF9),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: const Icon(Icons.search, size: 20, color: AppColors.textPrimary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '15 km',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Service radius from business address',
                                style: TextStyle(fontSize: 12, color: AppColors.textHint),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionCard(
                    title: 'Working Hours',
                    child: Column(
                      children: [
                        _buildWorkingHourRow('Monday', '08:00 - 17:00'),
                        _buildWorkingHourRow('Tuesday', '08:00 - 17:00'),
                        _buildWorkingHourRow('Wednesday', '08:00 - 17:00'),
                        _buildWorkingHourRow('Thursday', '08:00 - 17:00'),
                        _buildWorkingHourRow('Friday', '08:00 - 17:00'),
                        _buildWorkingHourRow('Saturday', '08:00 - 17:00'),
                        _buildWorkingHourRow('Sunday', 'Closed', isClosed: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 10,
        right: 20,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              ),
              const Text(
                'Profile Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_note_outlined, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?w=800&q=80'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Green Heaven Nursery',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Verified',
            style: TextStyle(
              color: Colors.green,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.orange, size: 20),
        const SizedBox(width: 4),
        const Text(
          '4.9',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 4),
        const Text(
          '(1284)',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textHint,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReviewTrustScreen()),
            );
          },
          child: const Text(
            'View all',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Text(
          value,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildWorkingHourRow(String day, String time, {bool isClosed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 13,
              color: isClosed ? Colors.red.shade300 : AppColors.textSecondary,
              fontWeight: isClosed ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
