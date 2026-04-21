import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../product/add_product_screen.dart';
import '../product/product_list_screen.dart';
import '../orders/order_list_screen.dart';
import '../orders/order_details_screen.dart';
import '../services/service_list_screen.dart';
import '../analysis/analysis_screen.dart';
import '../notifications/notification_screen.dart';
import '../profile/profile_settings_screen.dart';
import '../profile/settings_screen.dart';
import '../financial/financial_overview_screen.dart';
import '../reviews/review_trust_screen.dart';

class VendorDashboardScreen extends StatefulWidget {
  const VendorDashboardScreen({super.key});

  @override
  State<VendorDashboardScreen> createState() => _VendorDashboardScreenState();
}

class _VendorDashboardScreenState extends State<VendorDashboardScreen> {
  bool _isStoreOpen = true;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildStatsSection(),
                  const SizedBox(height: 32),
                  _buildQuickActions(),
                  const SizedBox(height: 32),
                  _buildOngoingOrders(),
                  const SizedBox(height: 32),
                  _buildPerformanceSection(),
                  const SizedBox(height: 32),
                  _buildAlertsSection(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
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
          _buildNavItem(1, Icons.account_balance_wallet, Icons.account_balance_wallet_outlined, 'Earnings'),
          _buildNavItem(2, Icons.person, Icons.person_outline, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        setState(() => _selectedIndex = index);
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FinancialOverviewScreen()));
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
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileSettingsScreen()),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Hello! Ramesh',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Green Heaven Nursery',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationScreen()),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.notifications_outlined, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.settings_outlined, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.storefront, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                const Text(
                  'Store is Open',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Switch(
                  value: _isStoreOpen,
                  onChanged: (val) => setState(() => _isStoreOpen = val),
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF1B4332),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Row(
      children: [
        _buildStatCard('₹4,520', 'Today\'s Earnings', '+12%', Icons.currency_rupee, Colors.green.shade100, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FinancialOverviewScreen()));
        }),
        const SizedBox(width: 12),
        _buildStatCard('₹28,350', 'Weekly Earnings', '+3', Icons.trending_up, Colors.orange.shade100, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FinancialOverviewScreen()));
        }),
        const SizedBox(width: 12),
        _buildStatCard('18', 'Orders Today', '+8%', Icons.shopping_bag_outlined, Colors.blue.shade100, () {}),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, String trend, IconData icon, Color iconBg, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, size: 16, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              const SizedBox(height: 4),
              Text(trend, style: const TextStyle(fontSize: 10, color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildActionItem('Add Product', Icons.add, Colors.green.shade50, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductListScreen()),
              );
            }),
            _buildActionItem('Add Service', Icons.cleaning_services_outlined, Colors.orange.shade50, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ServiceListScreen()),
              );
            }),
            _buildActionItem('Manage Orders', Icons.assignment_outlined, Colors.blue.shade50, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderListScreen()),
              );
            }),
            _buildActionItem('View Analytics', Icons.bar_chart, Colors.yellow.shade50, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AnalysisScreen()),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildActionItem(String label, IconData icon, Color bg, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildOngoingOrders() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ongoing Orders', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text('View All >', style: TextStyle(color: AppColors.primaryGreen, fontSize: 12))),
          ],
        ),
        const SizedBox(height: 8),
        _buildOrderCard('Priya Sharma', '3 plants, 1 pot', '#NW1042', 'Packed', Colors.green),
        const SizedBox(height: 12),
        _buildOrderCard('Amit Verma', '5 seeds, fertilizer', '#NW1041', 'Out for Delivery', Colors.orange),
        const SizedBox(height: 12),
        _buildOrderCard('Sunita Devi', '2 plants', '#NW1040', 'Scheduled', Colors.blue),
      ],
    );
  }

  Widget _buildOrderCard(String name, String items, String id, String status, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.inventory_2_outlined, color: statusColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(items, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(id, style: const TextStyle(color: AppColors.textHint, fontSize: 10)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(8)),
                child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Performance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ReviewTrustScreen()));
              },
              child: const Text('This week', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 200,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            children: [
              Expanded(
                child: CustomPaint(
                  size: Size.infinite,
                  painter: LineChartPainter(),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Mon', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                  Text('Tue', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                  Text('Wed', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                  Text('Thu', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                  Text('Fri', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                  Text('Sat', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                  Text('Sun', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAlertsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Alerts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text('View All >', style: TextStyle(color: AppColors.primaryGreen, fontSize: 12))),
          ],
        ),
        const SizedBox(height: 8),
        _buildAlertCard(
          'New Order Received',
          'Priya Sharma placed an order for 3 plants',
          '3 min ago',
          Icons.shopping_cart_outlined,
          Colors.green,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrderDetailsScreen()),
            );
          },
        ),
        const SizedBox(height: 12),
        _buildAlertCard('Low Stock Alert', 'Money Plant is running low (3 left)', '15 min ago', Icons.warning_amber_rounded, Colors.orange, () {}),
      ],
    );
  }

  Widget _buildAlertCard(String title, String desc, String time, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(time, style: const TextStyle(color: AppColors.textHint, fontSize: 10)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(desc, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryGreen
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.primaryGreen.withOpacity(0.3), AppColors.primaryGreen.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.15, size.height * 0.72),
      Offset(size.width * 0.3, size.height * 0.55),
      Offset(size.width * 0.45, size.height * 0.75),
      Offset(size.width * 0.6, size.height * 0.65),
      Offset(size.width * 0.8, size.height * 0.3),
      Offset(size.width, size.height * 0.45),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (var i = 1; i < points.length; i++) {
      final xc = (points[i].dx + points[i - 1].dx) / 2;
      final yc = (points[i].dy + points[i - 1].dy) / 2;
      path.quadraticBezierTo(points[i - 1].dx, points[i - 1].dy, xc, yc);
    }
    path.lineTo(points.last.dx, points.last.dy);

    canvas.drawPath(path, paint);

    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
