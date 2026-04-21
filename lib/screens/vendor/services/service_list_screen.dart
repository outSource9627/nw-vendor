import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import 'add_service_screen.dart';

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Garden Setup',
      'price': '₹499 Onwards',
      'duration': '45 mins',
      'isActive': true,
    },
    {
      'name': 'Garden Maintenance',
      'price': '₹499 Onwards',
      'duration': '1 hours',
      'isActive': true,
    },
    {
      'name': 'Plant Doctor',
      'price': '₹499 Onwards',
      'duration': '1.5 hours',
      'isActive': true,
    },
    {
      'name': 'Repotting & Soil Change',
      'price': '₹499 Onwards',
      'duration': '1.5 hours',
      'isActive': true,
    },
    {
      'name': 'Pest Control',
      'price': '₹499 Onwards',
      'duration': '1.5 hours',
      'isActive': false,
    },
    {
      'name': 'Repotting & Soil Change',
      'price': '₹499 Onwards',
      'duration': '1.5 hours',
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                return _buildServiceCard(_services[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddServiceScreen()),
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
                'Services',
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
              '6 services · 5 active',
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

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                service['name'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: service['isActive'] ? Colors.green.shade50 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      service['isActive'] ? 'Active' : 'Inactive',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: service['isActive'] ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 24,
                    width: 40,
                    child: Switch(
                      value: service['isActive'],
                      onChanged: (val) {},
                      activeColor: const Color(0xFF1B4332),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                service['price'],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                service['duration'],
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              const Icon(Icons.edit_note, size: 20, color: Colors.black),
              const SizedBox(width: 8),
              const Icon(Icons.delete_outline, size: 20, color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }
}
