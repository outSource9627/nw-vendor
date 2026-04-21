import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import 'order_details_screen.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildSearchBar(),
          const SizedBox(height: 16),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList('All'),
                _buildOrderList('Ongoing'),
                _buildOrderList('Completed'),
                _buildOrderList('Cancelled'),
              ],
            ),
          ),
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
                'Order List',
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
              '7 total orders',
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search Nursery',
          hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: AppColors.textHint, size: 20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColors.primaryGreen, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: AppColors.textPrimary,
      unselectedLabelColor: AppColors.textSecondary,
      indicatorColor: AppColors.primaryGreen,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      tabs: const [
        Tab(text: 'All'),
        Tab(text: 'Ongoing'),
        Tab(text: 'Completed'),
        Tab(text: 'Cancelled'),
      ],
    );
  }

  Widget _buildOrderList(String status) {
    // Dummy data for display based on image
    final List<Map<String, dynamic>> orders = [
      {
        'id': '#NW1042',
        'status': 'Pending',
        'title': 'Garden Setup',
        'customer': 'Priya Sharma',
        'price': '₹ 4,520',
        'date': '29 Mar 2026',
        'icon': Icons.home_repair_service_outlined,
      },
      {
        'id': '#NW1041',
        'status': 'Ongoing',
        'title': 'Lawn Mowing Service',
        'customer': 'Rajesh Kumar',
        'price': '₹ 1,200',
        'date': '28 Mar 2026',
        'icon': Icons.grass,
      },
      {
        'id': '#NW1040',
        'status': 'Completed',
        'title': 'Tulsi Plant (Pack of 3)',
        'customer': 'Anita Desai',
        'price': '₹ 850',
        'date': '28 Mar 2026',
        'icon': Icons.local_florist_outlined,
      },
      {
        'id': '#NW1039',
        'status': 'Cancelled',
        'title': 'Bonsai Tree - Ficus',
        'customer': 'Vikram Mehta',
        'price': '₹ 3,200',
        'date': '25 Mar 2026',
        'icon': Icons.park_outlined,
      },
      {
        'id': '#NW1038',
        'status': 'Pending',
        'title': 'Organic Fertilizer 5kg',
        'customer': 'Sunita Devi',
        'price': '₹ 650',
        'date': '24 Mar 2026',
        'icon': Icons.eco_outlined,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    Color statusColor;
    Color statusBg;
    switch (order['status']) {
      case 'Pending':
        statusColor = Colors.blue;
        statusBg = Colors.blue.shade50;
        break;
      case 'Ongoing':
        statusColor = Colors.orange;
        statusBg = Colors.orange.shade50;
        break;
      case 'Completed':
        statusColor = Colors.green;
        statusBg = Colors.green.shade50;
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        statusBg = Colors.red.shade50;
        break;
      default:
        statusColor = Colors.grey;
        statusBg = Colors.grey.shade50;
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(orderId: order['id']),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: const Color(0xFFF0F0F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order['id'],
                  style: const TextStyle(color: AppColors.textHint, fontSize: 12),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(order['icon'], color: AppColors.textPrimary, size: 20),
                const SizedBox(width: 12),
                Text(
                  order['title'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person_outline, color: AppColors.textSecondary, size: 16),
                const SizedBox(width: 12),
                Text(
                  order['customer'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order['price'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  order['date'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
            if (order['status'] == 'Pending' || order['status'] == 'Ongoing') ...[
              const SizedBox(height: 16),
              if (order['status'] == 'Pending')
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF212121),
                          side: BorderSide.none,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Reject', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B4332),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Accept', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              if (order['status'] == 'Ongoing')
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B4332),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Update', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
