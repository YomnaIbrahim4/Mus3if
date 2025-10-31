import 'package:flutter/material.dart';
import 'package:mus3if/model/guides.dart';

class GuideDetailScreen extends StatelessWidget {
  final Guide guide;

  GuideDetailScreen({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(guide.title),
        backgroundColor: Color(0xFFDC2626),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Icon(
                    _getCategoryIcon(guide.category),
                    color: Color(0xFFDC2626),
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          guide.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          guide.category,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              guide.description,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Color(0xFF1E293B),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Steps to Follow:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            SizedBox(height: 16),
            ...guide.steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              return _buildStepItem(index + 1, step);
            }).toList(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(int stepNumber, String step) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFFDC2626),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                stepNumber.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(step, style: TextStyle(fontSize: 14, height: 1.4)),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Cardiac Emergency":
        return Icons.favorite;
      case "Bleeding Emergency":
        return Icons.bloodtype;
      case "Burn Injury":
        return Icons.fireplace;
      case "Bone Injury":
        return Icons.accessible;
      case "Life Saving":
        return Icons.medical_services;
      case "Airway Emergency":
        return Icons.air;
      default:
        return Icons.medical_services;
    }
  }
}
