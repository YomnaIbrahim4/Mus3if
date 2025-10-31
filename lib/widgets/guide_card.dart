import 'package:flutter/material.dart';
import 'package:mus3if/model/guides.dart';

class GuideCard extends StatelessWidget {
  final Guide guide;
  final VoidCallback onTap;

  GuideCard({super.key, required this.guide, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getCategoryColor(guide.category).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getCategoryIcon(guide.category),
                  color: _getCategoryColor(guide.category),
                  size: 30,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guide.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      guide.description,
                      style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(guide.category),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        guide.category,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF64748B)),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Cardiac Emergency":
        return const Color(0xFFDC2626);
      case "Bleeding Emergency":
        return Colors.deepOrange;
      case "Burn Injury":
        return Colors.orange;
      case "Bone Injury":
        return Colors.brown;
      case "Life Saving":
        return const Color(0xFF16A34A);
      case "Airway Emergency":
        return const Color(0xFF2563EB);
      default:
        return const Color(0xFFDC2626);
    }
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
