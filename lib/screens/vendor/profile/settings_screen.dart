import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../home/vendor_dashboard_screen.dart';
import '../orders/order_list_screen.dart';
import '../financial/financial_overview_screen.dart';
import 'profile_settings_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 3;

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
                  _buildSettingCard(
                    icon: Icons.local_florist_outlined,
                    title: 'Profile Settings',
                    subtitle: '',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileSettingsScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  _buildSectionLabel('BANK DETAILS'),
                  _buildSettingCard(
                    icon: Icons.account_balance_outlined,
                    title: 'Bank Account',
                    subtitle: 'HDFC **** 4829',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  _buildSectionLabel('KYC DOCUMENTS'),
                  _buildSettingCard(
                    icon: Icons.account_balance_outlined,
                    title: 'Identity Proof',
                    subtitle: 'Aadhaar - Verified',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildSettingCard(
                    icon: Icons.account_balance_outlined,
                    title: 'Address Proof',
                    subtitle: 'PAN Card - Pending',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  _buildSectionLabel('NOTIFICATIONS'),
                  _buildSettingCard(
                    icon: Icons.account_balance_outlined,
                    title: 'Push Notifications',
                    subtitle: 'Enable',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildSettingCard(
                    icon: Icons.account_balance_outlined,
                    title: 'Email Notifications',
                    subtitle: 'Weekly digest',
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _buildSettingCard(
                    icon: Icons.account_balance_outlined,
                    title: 'SMS Updates',
                    subtitle: 'Enable',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  _buildSectionLabel('ACCOUNT'),
                  _buildLogoutCard(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_filled, Icons.home_outlined, 'Home'),
          _buildNavItem(1, Icons.inventory_2, Icons.inventory_2_outlined, 'Orders'),
          _buildNavItem(2, Icons.account_balance_wallet, Icons.account_balance_wallet_outlined, 'Wallet'),
          _buildNavItem(3, Icons.person, Icons.person_outline, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        if (index == _selectedIndex) return;
        setState(() => _selectedIndex = index);
        if (index == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const VendorDashboardScreen()));
        } else if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderListScreen()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FinancialOverviewScreen()));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? activeIcon : inactiveIcon,
            color: isSelected ? AppColors.primaryGreen : AppColors.textPrimary,
            size: 24,
          ),
          if (isSelected) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.primaryGreen,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
            'Settings',
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

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: AppColors.textHint,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FBF9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Icon(icon, size: 20, color: AppColors.textPrimary),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textHint),
      ),
    );
  }

  Widget _buildLogoutCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: ListTile(
        onTap: () {
          // TODO: Implement logout logic
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: const Icon(Icons.logout_outlined, size: 22, color: Colors.red),
        title: const Text(
          'Logout',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
