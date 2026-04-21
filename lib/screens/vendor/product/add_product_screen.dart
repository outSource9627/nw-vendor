import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagSearchController = TextEditingController();

  String? _selectedCategory;
  final List<String> _categories = ['Plants', 'Seeds', 'Pots', 'Tools', 'Fertilizers'];
  final List<String> _tags = [
    'Indoor', 'Outdoor', 'Seasonal', 'Sale', 'New Arrival', 'Best Seller', 'Eco-friendly', 'Handmade'
  ];
  final List<String> _selectedTags = [];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    _tagSearchController.dispose();
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
                        _buildLabel('Product Name'),
                        _buildTextField(_nameController, 'e.g. Handcrafted Ceramic Vase'),
                        const SizedBox(height: 16),
                        _buildLabel('Price'),
                        _buildTextField(_priceController, 'e.g. ₹ 000', keyboardType: TextInputType.number),
                        const SizedBox(height: 16),
                        _buildLabel('Stock Quantity'),
                        _buildTextField(_stockController, 'Enter number', keyboardType: TextInputType.number),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    title: 'Category',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDropdown(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    title: 'Product Images',
                    child: _buildImageUploadArea(),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    title: 'Description',
                    child: _buildTextField(
                      _descriptionController,
                      'Describe your product in detail...',
                      maxLines: 4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionCard(
                    title: 'Tags',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTagSearchField(),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _tags.map((tag) => _buildTagChip(tag)).toList(),
                        ),
                      ],
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
                'Add Product',
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
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
          fontSize: 14,
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
      style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14, fontWeight: FontWeight.normal),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        filled: true,
        fillColor: const Color(0xFFF9FBF9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBF9),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
          hint: const Text('Select a category', style: TextStyle(color: AppColors.textHint, fontSize: 14)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
          items: _categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedCategory = newValue;
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
              painter: DashRectPainter(
                color: const Color(0xFFE0E0E0),
                strokeWidth: 1.5,
                gap: 4.0,
              ),
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
                  child: const Icon(
                    Icons.add_a_photo_outlined,
                    color: AppColors.textSecondary,
                    size: 28,
                  ),
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

  Widget _buildTagSearchField() {
    return TextField(
      controller: _tagSearchController,
      decoration: InputDecoration(
        hintText: 'Search Nursery',
        hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
        prefixIcon: const Icon(Icons.search, color: AppColors.textHint, size: 20),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildTagChip(String tag) {
    final isSelected = _selectedTags.contains(tag);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedTags.remove(tag);
          } else {
            _selectedTags.add(tag);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGreen : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Text(
          tag,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement save logic
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B4332), // Dark green from image
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
              'Save Product',
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
