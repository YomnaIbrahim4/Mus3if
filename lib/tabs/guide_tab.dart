import 'package:flutter/material.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/custom_container_widget.dart';
import '../widgets/video_list_widget.dart';
import '../widgets/quiz_banner_widget.dart';
class GuideTab extends StatelessWidget {
  const GuideTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBarWidget(title: 'Guides',),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16,),
            CustomContainerWidget(),
            SizedBox(height: 30),
            QuizBannerWidget(),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(height: 15,),
                Text(
                  'Try to Watch ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            VideoListWidget(),

          ],
        ),
      ),
    );
  }
}

