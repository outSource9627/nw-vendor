import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import 'add_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _selectedStock = 'All Stock';
  bool _isGridView = true;

  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Monstera Deli..',
      'price': '₹449',
      'image': 'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?w=500&q=80',
      'isActive': true,
    },
    {
      'name': 'Plant Cutter',
      'price': '₹449',
      'image': 'https://images.unsplash.com/photo-1589923188900-85dae523342b?w=500&q=80',
      'isActive': true,
    },
    {
      'name': 'Phosphatic',
      'price': '₹449',
      'image': 'https://images.unsplash.com/photo-1628352081506-83c43123ed6d?w=500&q=80',
      'isActive': true,
    },
    {
      'name': 'Snakeplant',
      'price': '₹449',
      'image': 'https://images.unsplash.com/photo-1593482892290-f54927ae1bf7?w=500&q=80',
      'isActive': true,
    },
    {
      'name': 'Peace Lily',
      'price': '₹449',
      'image': 'https://images.unsplash.com/photo-1597055148762-6f2964977461?w=500&q=80',
      'isActive': true,
    },
    {
      'name': 'Jade Succulent',
      'price': '₹449',
      'image': 'https://images.unsplash.com/photo-1509423350716-97f9360b4e59?w=500&q=80',
      'isActive': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildSearchBar(),
          const SizedBox(height: 12),
          _buildFilters(),
          Expanded(
            child: _buildProductGrid(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          );
        },
        backgroundColor: const Color(0xFF1B4332),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
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
                'Products',
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
              '6 items · 5 active',
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
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryGreen, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildDropdownFilter(_selectedCategory, (val) => setState(() => _selectedCategory = val!)),
          const SizedBox(width: 8),
          _buildDropdownFilter(_selectedStock, (val) => setState(() => _selectedStock = val!)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Row(
              children: [
                _buildViewToggle(Icons.grid_view, _isGridView, () => setState(() => _isGridView = true)),
                _buildViewToggle(Icons.list, !_isGridView, () => setState(() => _isGridView = false)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownFilter(String value, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: [value].map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item, style: const TextStyle(fontSize: 12)));
          }).toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
        ),
      ),
    );
  }

  Widget _buildViewToggle(IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1B4332).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 20, color: isActive ? const Color(0xFF1B4332) : Colors.grey),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(_products[index]);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                product['image'],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text(product['price'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Active', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    const Spacer(),
                    SizedBox(
                      height: 20,
                      width: 36,
                      child: Switch(
                        value: product['isActive'],
                        onChanged: (val) {},
                        activeColor: const Color(0xFF1B4332),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 32),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          side: const BorderSide(color: Color(0xFFE0E0E0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.edit_note, size: 16, color: Colors.black),
                            SizedBox(width: 4),
                            Text('Edit', style: TextStyle(color: Colors.black, fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
