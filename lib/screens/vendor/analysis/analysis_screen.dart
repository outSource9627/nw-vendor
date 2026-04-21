import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  bool _isWeekly = true;

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
                  _buildDateSelector(),
                  const SizedBox(height: 24),
                  _buildSummaryCard('Total Revenue', '₹ 46,500', '+14.2% from last month', Icons.currency_rupee, Colors.green.shade50, Colors.green),
                  const SizedBox(height: 12),
                  _buildSummaryCard('Total Orders', '3,842', '+8.1% from last month', Icons.shopping_cart_outlined, Colors.green.shade50, Colors.green),
                  const SizedBox(height: 12),
                  _buildSummaryCard('New Customers', '1,205', '+22% from last month', Icons.people_outline, Colors.green.shade50, Colors.green),
                  const SizedBox(height: 12),
                  _buildSummaryCard('Growth Rate', '18.3%', '+3.2% from last month', Icons.trending_up, Colors.green.shade50, Colors.green),
                  const SizedBox(height: 24),
                  _buildRevenueChart(),
                  const SizedBox(height: 24),
                  _buildConversionInsights(),
                  const SizedBox(height: 40),
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
              const Text(
                'Analysis',
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
              'Track your store performance and insights',
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

  Widget _buildDateSelector() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Row(
              children: const [
                Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black),
                SizedBox(width: 8),
                Text('Mar 1, 2026', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('-', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Row(
              children: const [
                Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black),
                SizedBox(width: 8),
                Text('Apr 1, 2026', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, String trend, IconData icon, Color bg, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(trend, style: const TextStyle(fontSize: 11, color: AppColors.primaryGreen, fontWeight: FontWeight.w500)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Revenue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildToggleItem('Weekly', _isWeekly, () => setState(() => _isWeekly = true)),
                    _buildToggleItem('Monthly', !_isWeekly, () => setState(() => _isWeekly = false)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('50k', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                    Text('40k', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                    Text('30k', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                    Text('20k', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                    Text('10k', style: TextStyle(fontSize: 10, color: AppColors.textHint)),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: RevenueChartPainter(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
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
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)] : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Colors.black : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildConversionInsights() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Conversion Insights', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CustomPaint(
                  painter: DonutChartPainter(),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: [
                    _buildLegendItem('Completed 62%', AppColors.primaryGreen),
                    const SizedBox(height: 12),
                    _buildLegendItem('Abandoned Cart 23%', Colors.orange),
                    const SizedBox(height: 12),
                    _buildLegendItem('Browsing Only 15%', Colors.grey.shade300),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 40),
          Row(
            children: [
              _buildInsightStat('3.2%', 'Conversion Rate', '+0.4% vs last period', AppColors.primaryGreen),
              _buildInsightStat('₹ 249', 'Avg. Order Value', '+\$3.20 vs last period', AppColors.primaryGreen),
              _buildInsightStat('23%', 'Cart Abandonment', '-2% vs last period', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildInsightStat(String value, String label, String trend, Color trendColor) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text(trend, textAlign: TextAlign.center, style: TextStyle(fontSize: 9, color: trendColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class RevenueChartPainter extends CustomPainter {
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
      Offset(size.width * 0.16, size.height * 0.65),
      Offset(size.width * 0.33, size.height * 0.75),
      Offset(size.width * 0.5, size.height * 0.85),
      Offset(size.width * 0.66, size.height * 0.6),
      Offset(size.width * 0.83, size.height * 0.2),
      Offset(size.width, size.height * 0.35),
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

    // Draw grid lines
    final gridPaint = Paint()..color = Colors.grey.withOpacity(0.1)..strokeWidth = 1;
    for (var i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 15.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Completed 62%
    paint.color = AppColors.primaryGreen;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -math.pi / 2,
      2 * math.pi * 0.62,
      false,
      paint,
    );

    // Abandoned Cart 23%
    paint.color = Colors.orange;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -math.pi / 2 + 2 * math.pi * 0.62 + 0.1,
      2 * math.pi * 0.23,
      false,
      paint,
    );

    // Browsing Only 15%
    paint.color = Colors.grey.shade300;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -math.pi / 2 + 2 * math.pi * 0.85 + 0.2,
      2 * math.pi * 0.15 - 0.2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
