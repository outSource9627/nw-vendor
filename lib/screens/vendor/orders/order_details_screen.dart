import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailsScreen({super.key, this.orderId = 'ORD- NW1024'});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String _selectedStatus = 'Packed';
  final List<String> _statusOptions = ['Pending', 'Packed', 'Shipped', 'Delivered'];
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildActionsSection(),
                  const SizedBox(height: 16),
                  _buildOrderStatusSection(),
                  const SizedBox(height: 16),
                  _buildCustomerDetailsSection(),
                  const SizedBox(height: 16),
                  _buildOrderItemsSection(),
                  const SizedBox(height: 16),
                  _buildPaymentSection(),
                  const SizedBox(height: 16),
                  _buildVendorNotesSection(),
                  const SizedBox(height: 24),
                ],
              ),
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
              Text(
                widget.orderId,
                style: const TextStyle(
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
              'April 1, 2025 — 10:32 AM',
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

  Widget _buildActionsSection() {
    return _buildSectionCard(
      title: 'Actions',
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FBF9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedStatus,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                items: _statusOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() => _selectedStatus = newValue!);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF212121),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Accept', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusSection() {
    return _buildSectionCard(
      title: 'Order Status',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatusStep(Icons.access_time, true),
          _buildStatusLine(false),
          _buildStatusStep(Icons.inventory_2_outlined, false),
          _buildStatusLine(false),
          _buildStatusStep(Icons.local_shipping_outlined, false),
          _buildStatusLine(false),
          _buildStatusStep(Icons.check_circle_outline, false),
        ],
      ),
    );
  }

  Widget _buildStatusStep(IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF1B4332) : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Icon(
        icon,
        size: 20,
        color: isActive ? Colors.white : AppColors.textSecondary,
      ),
    );
  }

  Widget _buildStatusLine(bool isActive) {
    return Expanded(
      child: CustomPaint(
        size: const Size(double.infinity, 1),
        painter: DashedLinePainter(color: const Color(0xFFE0E0E0)),
      ),
    );
  }

  Widget _buildCustomerDetailsSection() {
    return _buildSectionCard(
      title: 'Customer Details',
      child: Column(
        children: [
          _buildDetailRow(Icons.person_outline, 'Sarah Mitchell', 'sarah.mitchell@email.com'),
          const SizedBox(height: 16),
          _buildDetailRow(Icons.location_on_outlined, '42 Elm Street, Apt 7B, Brooklyn, NY 11201', null),
          const SizedBox(height: 16),
          _buildDetailRow(Icons.phone_outlined, '+91 98765 43210', null),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String? subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              if (subtitle != null)
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItemsSection() {
    return _buildSectionCard(
      title: 'Order Items',
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(flex: 3, child: Text('Product', style: TextStyle(fontSize: 12, color: AppColors.textHint, fontWeight: FontWeight.bold))),
              Expanded(child: Text('Qty', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: AppColors.textHint, fontWeight: FontWeight.bold))),
              Expanded(child: Text('Unit Price', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: AppColors.textHint, fontWeight: FontWeight.bold))),
              Expanded(child: Text('Total Price', textAlign: TextAlign.right, style: TextStyle(fontSize: 12, color: AppColors.textHint, fontWeight: FontWeight.bold))),
            ],
          ),
          const SizedBox(height: 12),
          _buildItemRow('Monstera Deliciosa', '2', '399', '₹ 798'),
          _buildItemRow('Bonsai Tree', '1', '399', '₹ 399'),
          _buildItemRow('Garden Setup', '1', '699', '₹ 699'),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('₹ 1,896', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(String name, String qty, String price, String total) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
          Expanded(child: Text(qty, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14))),
          Expanded(child: Text(price, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary))),
          Expanded(child: Text(total, textAlign: TextAlign.right, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return _buildSectionCard(
      title: 'Payment',
      child: Column(
        children: [
          Row(
            children: [
              Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/UPI-Logo-vector.svg/1200px-UPI-Logo-vector.svg.png', height: 12),
              const SizedBox(width: 12),
              const Text('UPI ID: suha***********@oksbi', style: TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Status', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Paid', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Amount', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
              Text('₹ 1,896', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVendorNotesSection() {
    return _buildSectionCard(
      title: 'Vendor Notes',
      child: Column(
        children: [
          TextField(
            controller: _notesController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Add internal notes about this order...',
              hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 13),
              filled: true,
              fillColor: const Color(0xFFF9FBF9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF94A89A), // Muted green/grey from image
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save Notes', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
