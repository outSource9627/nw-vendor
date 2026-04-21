import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Today',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildNotificationCard(
                    icon: Icons.inventory_2_outlined,
                    iconColor: Colors.green,
                    title: 'Order Confirmation',
                    subtitle: 'Your Monstera Deliciosa order has been confirmed 🌿.',
                    time: 'now',
                  ),
                  const SizedBox(height: 12),
                  _buildNotificationCard(
                    icon: Icons.local_florist_outlined,
                    iconColor: Colors.green,
                    title: 'Out for Delivery',
                    subtitle: 'Your plants are on the way 🚚 Track your order now!',
                    time: '3h ago',
                  ),
                  const SizedBox(height: 12),
                  _buildNotificationCard(
                    icon: Icons.percent_outlined,
                    iconColor: Colors.green,
                    title: 'Nearby Nursery Alert',
                    subtitle: 'A top-rated nursery just opened 2.3 km from you 📍.',
                    time: '5h ago',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Yesterday',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildNotificationCard(
                    icon: Icons.inventory_2_outlined,
                    iconColor: Colors.green,
                    title: 'Plant Care Reminder',
                    subtitle: 'Time to water your Monstera 💧 Keep it fresh and happy!',
                    time: 'now',
                  ),
                  const SizedBox(height: 12),
                  _buildNotificationCard(
                    icon: Icons.local_florist_outlined,
                    iconColor: Colors.green,
                    title: 'Fertilizer Reminder',
                    subtitle: 'Your plant needs nutrients this week 🌿 Add fertilizer for better growth.',
                    time: '3h ago',
                  ),
                  const SizedBox(height: 12),
                  _buildNotificationCard(
                    icon: Icons.percent_outlined,
                    iconColor: Colors.green,
                    title: 'Offer / Promotion',
                    subtitle: 'Flat 20% OFF on indoor plants today only 🌿 Shop now!',
                    time: '5h ago',
                  ),
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
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          ),
          const Text(
            'Notifications',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0F0F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
