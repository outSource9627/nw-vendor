import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class ReviewTrustScreen extends StatelessWidget {
  const ReviewTrustScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSatisfactionCard(),
                  const SizedBox(height: 32),
                  const Text(
                    'Recent feedback',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 16),
                  _buildFeedbackList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          ),
          const Text(
            'Review & Trust',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSatisfactionCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TOTAL SATISFACTION',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textHint),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: const [
                        Text('4.9', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        Text(' / 5.0', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(Icons.star, color: Colors.orange, size: 18),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Based on 1,284 verified\ncustomer experiences.',
                      style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    _buildRatingRow('5 star', 1023, 0.8),
                    _buildRatingRow('4 star', 192, 0.4),
                    _buildRatingRow('3 star', 45, 0.2),
                    _buildRatingRow('2 star', 18, 0.1),
                    _buildRatingRow('1 star', 6, 0.05),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow(String label, int count, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 35, child: Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textHint))),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: const Color(0xFFF0F0F0),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1B4332)),
                minHeight: 4,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(width: 30, child: Text(count.toString(), textAlign: TextAlign.right, style: const TextStyle(fontSize: 10, color: AppColors.textHint))),
        ],
      ),
    );
  }

  Widget _buildFeedbackList() {
    final List<Map<String, dynamic>> feedbacks = [
      {
        'name': 'Marcus Thornton',
        'time': '2 days ago',
        'rating': 5,
        'comment': 'Got really healthy plants from this nursery 🌿 Packaging was neat and delivery was on time. Highly recommend!',
      },
      {
        'name': 'Elena Laurent',
        'time': '1 week ago',
        'rating': 5,
        'comment': 'The gardener was very professional and knew exactly what my plants needed 👨‍🌾 My balcony looks fresh again!',
      },
      {
        'name': 'Sarah Jenkins',
        'time': '2 weeks ago',
        'rating': 4,
        'comment': 'Plants are good but delivery was a bit delayed 🚚 Otherwise satisfied with the quality.',
      },
      {
        'name': 'Damon Gilbert',
        'time': '2 weeks ago',
        'rating': 5,
        'comment': 'The gardener was very professional and knew exactly what my plants needed 👨‍🌾 My balcony looks...',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: feedbacks.length,
      itemBuilder: (context, index) {
        final feedback = feedbacks[index];
        return _buildFeedbackCard(feedback);
      },
    );
  }

  Widget _buildFeedbackCard(Map<String, dynamic> feedback) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(feedback['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 2),
                  Text(feedback['time'], style: const TextStyle(fontSize: 11, color: AppColors.textHint)),
                ],
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    color: index < feedback['rating'] ? Colors.orange : Colors.grey.shade300,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            feedback['comment'],
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4),
          ),
        ],
      ),
    );
  }
}
