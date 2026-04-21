import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../home/vendor_dashboard_screen.dart';
import '../profile/profile_settings_screen.dart';

class FinancialOverviewScreen extends StatefulWidget {
  const FinancialOverviewScreen({super.key});

  @override
  State<FinancialOverviewScreen> createState() => _FinancialOverviewScreenState();
}

class _FinancialOverviewScreenState extends State<FinancialOverviewScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF9FBF9),
        backgroundColor: const Color(0xFFFAFBF5),

      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBalanceCard(),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Transaction History',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View all', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ),
                    ],
                  ),
                  _buildTabBar(),
                  const SizedBox(height: 16),
                  _buildTransactionList(),
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
          _buildNavItem(1, Icons.account_balance_wallet, Icons.account_balance_wallet_outlined, 'Wallet'),
          _buildNavItem(2, Icons.person, Icons.person_outline, 'Profile'),
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
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileSettingsScreen()));
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

  Widget _buildHeader() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              ),
              const Text(
                'Financial Overview',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 48, top: 0),
            child: Text(
              'Real time assets & performance',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8F0E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AVAILABLE BALANCE',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textHint, letterSpacing: 0.5),
          ),
          const SizedBox(height: 8),
          const Text(
            '₹ 12,450',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'TOTAL EARNINGS',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textHint),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹ 46,500',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B4332),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Row(
                  children: const [
                    Text('Withdraw', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.north_east, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: AppColors.textPrimary,
      unselectedLabelColor: AppColors.textSecondary,
      indicatorColor: AppColors.primaryGreen,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
      tabs: const [
        Tab(text: 'All'),
        Tab(text: 'Cashback'),
        Tab(text: 'Refunds'),
        Tab(text: 'Used'),
      ],
    );
  }

  Widget _buildTransactionList() {
    final List<Map<String, dynamic>> transactions = [
      {
        'title': 'Order Cashback',
        'orderId': '#NW1024',
        'type': 'Cashback',
        'date': 'Dec 18, 2024 • 2:30 PM',
        'amount': '+ ₹ 12',
        'icon': Icons.calendar_today_outlined,
        'color': Colors.green,
      },
      {
        'title': 'Refund from Order',
        'orderId': '#NW1021',
        'type': 'Refund',
        'date': 'Dec 17, 2024 • 11:45 AM',
        'amount': '+ ₹ 450',
        'icon': Icons.history,
        'color': Colors.green,
      },
      {
        'title': 'Wallet Used in Order',
        'orderId': '#NW1018',
        'type': 'Used',
        'date': 'Dec 16, 2024 • 6:20 PM',
        'amount': '- ₹ 450',
        'icon': Icons.history,
        'color': Colors.red,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return _buildTransactionCard(tx);
      },
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> tx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FBF9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Icon(tx['icon'], size: 20, color: const Color(0xFF1B4332)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx['title'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text('Order ${tx['orderId']}', style: const TextStyle(fontSize: 12, color: AppColors.textHint)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: tx['type'] == 'Cashback' ? Colors.green.shade50 : (tx['type'] == 'Refund' ? Colors.green.shade50 : Colors.grey.shade100),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tx['type'],
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: tx['type'] == 'Used' ? Colors.black : Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(tx['date'], style: const TextStyle(fontSize: 10, color: AppColors.textHint)),
                  ],
                ),
              ],
            ),
          ),
          Text(
            tx['amount'],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: tx['color'],
            ),
          ),
        ],
      ),
    );
  }
}
