import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class BusinessRegistrationScreen extends StatefulWidget {
  const BusinessRegistrationScreen({super.key});

  @override
  State<BusinessRegistrationScreen> createState() =>
      _BusinessRegistrationScreenState();
}

class _BusinessRegistrationScreenState extends State<BusinessRegistrationScreen> {
  int _currentStep = 0;
  final int _totalSteps = 7; 
  bool _isSubmitted = false;

  // Step titles for the Success screen steps
  final List<String> _stepTitles = [
    'Business Details',
    'Your Location',
    'What do you offer?',
    'Upload Photos',
    'KYC Verification',
    'Bank Details',
    'Service Area',
  ];

  // Icons for the stepper
  final List<IconData> _stepIcons = [
    Icons.person_outline,
    Icons.location_on_outlined,
    Icons.eco_outlined,
    Icons.category_outlined,
    Icons.camera_alt_outlined,
    Icons.account_balance_outlined,
    Icons.more_time_outlined,
  ];

  // Form controllers for Step 1
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  // Form controllers for Step 2
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  // Form controllers for Step 6 (Bank)
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _upiIdController = TextEditingController();

  // Offerings for Step 3
  final List<Map<String, dynamic>> _offerings = [
    {'name': 'Plants', 'icon': 'assets/images/Frame8.png'},
    {'name': 'Pots', 'icon': 'assets/images/Frame9.png'},
    {'name': 'Seeds', 'icon': 'assets/images/Frame10.png'},
    {'name': 'Fertilizers', 'icon': 'assets/images/Frame11.png'},
    {'name': 'Services', 'icon': 'assets/images/Frame4.png'},
  ];
  final Set<int> _selectedOfferings = {};

  // Service Area Step 7 state
  int _selectedRadiusIndex = 1; // Default 10km
  final List<String> _radiusOptions = ['5 km', '10 km', '15 km', '20 km'];
  bool _homeDeliveryEnabled = true;
  final Set<int> _selectedTimeSlots = {0, 1}; // Default Morning & Afternoon

  @override
  void dispose() {
    _businessNameController.dispose();
    _ownerNameController.dispose();
    _businessTypeController.dispose();
    _experienceController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    _accountNumberController.dispose();
    _ifscController.dispose();
    _upiIdController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
    } else {
      setState(() => _isSubmitted = true);
      // Automatically redirect to Dashboard after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/vendor-dashboard',
            (route) => false,
          );
        }
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
      return _buildSuccessScreen();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(),
          _buildStepper(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFF0F0F0)),
                    ),
                    child: _buildStepContent(),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        left: 20,
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
          GestureDetector(
            onTap: _previousStep,
            child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.storefront_outlined, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          const Text(
            'Register Business',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_totalSteps, (index) {
          bool isActive = index <= _currentStep;
          bool isCurrent = index == _currentStep;
          return Expanded(
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCurrent
                        ? const Color(0xFF1B4332)
                        : isActive
                            ? const Color(0xFF1B4332).withOpacity(0.1)
                            : Colors.white,
                    border: Border.all(
                      color: isCurrent
                          ? const Color(0xFF1B4332)
                          : isActive
                              ? const Color(0xFF1B4332).withOpacity(0.2)
                              : AppColors.divider,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      _stepIcons[index],
                      size: 14,
                      color: isCurrent
                          ? Colors.white
                          : isActive
                              ? const Color(0xFF1B4332)
                              : AppColors.textHint,
                    ),
                  ),
                ),
                if (index < _totalSteps - 1)
                  Expanded(
                    child: Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: CustomPaint(
                        painter: DashedLinePainter(
                          color: index < _currentStep
                              ? const Color(0xFF1B4332).withOpacity(0.3)
                              : AppColors.divider,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildBusinessDetails();
      case 1:
        return _buildYourLocation();
      case 2:
        return _buildOfferings();
      case 3:
        return _buildUploadPhotos();
      case 4:
        return _buildKYC();
      case 5:
        return _buildBankDetails();
      case 6:
        return _buildServiceArea();
      default:
        return Container();
    }
  }

  Widget _buildBusinessDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Business Details',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'Tell us about your business',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 24),
        _buildTextField('Business Name', 'Enter business name', _businessNameController),
        _buildTextField('Owner Name', 'Enter owner name', _ownerNameController),
        _buildTextField('Business Type', 'Select business type', _businessTypeController, isDropdown: true),
        _buildTextField('Year of Experience', 'Enter year of experience', _experienceController),
      ],
    );
  }

  Widget _buildYourLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Location',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'Where is your nursery or service area?',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 24),
        CustomPaint(
          painter: DashedRectPainter(color: AppColors.divider, gap: 4),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FBF9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Icon(Icons.location_on_outlined, color: AppColors.textSecondary, size: 32),
                const SizedBox(height: 8),
                const Text(
                  'Auto-detect my location',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              'or enter manually',
              style: TextStyle(color: AppColors.textHint, fontSize: 12),
            ),
          ),
        ),
        _buildTextField('Address', 'Enter address', _addressController),
        _buildTextField('City', 'Enter city name', _cityController),
        _buildTextField('State', 'Select state', _stateController, isDropdown: true),
        _buildTextField('Pincode', 'Enter your pincode', _pincodeController),
      ],
    );
  }

  Widget _buildOfferings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What do you offer?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'Select all that apply',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: _offerings.length,
          itemBuilder: (context, index) {
            bool isSelected = _selectedOfferings.contains(index);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedOfferings.remove(index);
                  } else {
                    _selectedOfferings.add(index);
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.priceBg : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryGreen : AppColors.divider,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _offerings[index]['icon'],
                      height: 80,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.eco, size: 60, color: AppColors.primaryGreen),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _offerings[index]['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildUploadPhotos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Photos',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'Show off your nursery and products',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 32),
        const Text(
          'Nursery / Shop Photos',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        const SizedBox(height: 12),
        CustomPaint(
          painter: DashedRectPainter(color: AppColors.divider, gap: 4),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FBF9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.add_photo_alternate_outlined, size: 36, color: AppColors.textHint),
                SizedBox(height: 8),
                Text(
                  'Add Photos',
                  style: TextStyle(color: AppColors.textHint, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKYC() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'KYC Verification',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'Upload your identity documents',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F8E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.verified_user_outlined, size: 16, color: AppColors.primaryGreen),
              SizedBox(width: 8),
              Text(
                'Your data is secure',
                style: TextStyle(color: AppColors.primaryGreen, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _buildKYCCard('Aadhaar Card', 'Front & back'),
        const SizedBox(height: 16),
        _buildKYCCard('PAN Card', 'Clear photo'),
      ],
    );
  }

  Widget _buildKYCCard(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
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
            child: const Icon(Icons.file_upload_outlined, color: Color(0xFF1B4332), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bank Details',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'For receiving payments securely',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F8E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.verified_user_outlined, size: 16, color: AppColors.primaryGreen),
              SizedBox(width: 8),
              Text(
                'Bank-grade encryption 🔐',
                style: TextStyle(color: AppColors.primaryGreen, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _buildTextField('Account Number', 'Enter account number', _accountNumberController),
        _buildTextField('IFSC Code', 'Enter ifsc code', _ifscController),
        _buildTextField('UPI ID (Optional)', 'Enter upi id', _upiIdController),
      ],
    );
  }

  Widget _buildServiceArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Service Area & Availability',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'Set your coverage and hours',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        const SizedBox(height: 24),
        const Text(
          'Service Radius',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_radiusOptions.length, (index) {
            bool isSelected = _selectedRadiusIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedRadiusIndex = index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryGreen : AppColors.divider,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  _radiusOptions[index],
                  style: TextStyle(
                    color: isSelected ? AppColors.primaryGreen : AppColors.textHint,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              const Icon(Icons.delivery_dining_outlined, color: AppColors.textPrimary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Home Delivery',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'Deliver to customers',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _homeDeliveryEnabled,
                onChanged: (value) => setState(() => _homeDeliveryEnabled = value),
                activeColor: AppColors.primaryGreen,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Available Time Slots',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        const SizedBox(height: 12),
        _buildTimeSlot(0, 'Morning', '6 AM - 12 PM', 'assets/images/Frame1.png'),
        const SizedBox(height: 12),
        _buildTimeSlot(1, 'Afternoon', '12 PM - 5 PM', 'assets/images/Frame 2.png'),
        const SizedBox(height: 12),
        _buildTimeSlot(2, 'Evening', '5 PM - 9 PM', 'assets/images/Frame3.png'),
      ],
    );
  }

  Widget _buildTimeSlot(int index, String title, String time, String asset) {
    bool isSelected = _selectedTimeSlots.contains(index);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedTimeSlots.remove(index);
          } else {
            _selectedTimeSlots.add(index);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : AppColors.divider,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(asset, width: 44, height: 44, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => const Icon(Icons.access_time)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    time,
                    style: const TextStyle(color: AppColors.textHint, fontSize: 11),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primaryGreen, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      'assets/images/rb.png',
                      height: 200,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.check_circle_outline, size: 100, color: AppColors.primaryGreen),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F8E9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.access_time, size: 14, color: AppColors.primaryGreen),
                        SizedBox(width: 6),
                        Text(
                          'Under Review',
                          style: TextStyle(color: AppColors.primaryGreen, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Profile Submitted! 🎉',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Your vendor profile is under review. We\'ll notify you once approved. This usually takes 24-48 hours.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'What happens next?',
                            style: TextStyle(color: AppColors.textHint, fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildSuccessStep('1', 'Our team reviews your profile'),
                        const SizedBox(height: 16),
                        _buildSuccessStep('2', 'You receive approval notification'),
                        const SizedBox(height: 16),
                        _buildSuccessStep('3', 'Start listing your products!'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8BA89B),
                        disabledBackgroundColor: const Color(0xFFD1D1D1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Go to Dashboard',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Dashboard will be available once approved ⏳',
                    style: TextStyle(color: AppColors.textHint, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessStep(String number, String text) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFF1B4332),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, {bool isDropdown = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            readOnly: isDropdown,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
              filled: true,
              fillColor: const Color(0xFFF9FBF9),
              suffixIcon: isDropdown ? const Icon(Icons.keyboard_arrow_down, color: AppColors.textHint) : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.primaryGreen, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _nextStep,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B4332), // Dark green from image
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              _currentStep == _totalSteps - 1 ? 'Submit for Approval' : 'Continue',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(16),
    ));

    double dashWidth = 5.0;
    double dashSpace = gap;
    double distance = 0.0;

    for (PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        canvas.drawPath(
          measurePath.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
      distance = 0;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
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
