import 'package:flutter/material.dart';
import 'package:mus3if/data/dummy_data.dart';
import 'package:mus3if/widgets/guide_card.dart';
import '../screens/guide_detail_screen.dart';

class GuideTab extends StatelessWidget {
  const GuideTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              "Emergency Guides",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Learn how to handle emergency situations",
              style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: guides.length,
                itemBuilder: (context, index) {
                  final guide = guides[index];
                  return GuideCard(
                    guide: guide,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GuideDetailScreen(guide: guide),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
