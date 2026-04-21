import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _durationController = TextEditingController(text: '60');
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedType;
  final List<String> _serviceTypes = ['Gardening', 'Maintenance', 'Consultation', 'Repotting', 'Pest Control'];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionCard(
                    title: 'Basic Information',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Service Name'),
                        _buildTextField(_nameController, 'e.g. Lawn Gardening'),
                        const SizedBox(height: 16),
                        _buildLabel('Price'),
                        _buildTextField(_priceController, 'e.g. ₹ 000', keyboardType: TextInputType.number),
                        const SizedBox(height: 16),
                        _buildLabel('Duration (minutes)'),
                        _buildTextField(_durationController, '60', keyboardType: TextInputType.number),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    title: 'Service type',
                    child: _buildDropdown(),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    title: 'Images',
                    child: _buildImageUploadArea(),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    title: 'Description',
                    child: _buildTextField(
                      _descriptionController,
                      'Describe your service in detail...',
                      maxLines: 4,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          _buildSaveButton(),
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
                'Add Service',
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
              'Fill in the details below',
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

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {TextInputType? keyboardType, int maxLines = 1}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        filled: true,
        fillColor: const Color(0xFFF9FBF9),
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
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBF9),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedType,
          hint: const Text('Select a category', style: TextStyle(color: AppColors.textHint, fontSize: 14)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
          items: _serviceTypes.map((String type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedType = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildImageUploadArea() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBF9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: DashRectPainter(color: const Color(0xFFE0E0E0), strokeWidth: 1.5, gap: 4.0),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add_a_photo_outlined, color: AppColors.textSecondary, size: 28),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Add Photos',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B4332),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.save_outlined, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Save Service',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashRectPainter({this.color = Colors.black, this.strokeWidth = 1.0, this.gap = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(16),
    ));

    final dashPath = _dashPath(path, gap);
    canvas.drawPath(dashPath, paint);
  }

  Path _dashPath(Path source, double dashWidth) {
    final path = Path();
    for (final metric in source.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        path.addPath(
          metric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth * 2;
      }
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
