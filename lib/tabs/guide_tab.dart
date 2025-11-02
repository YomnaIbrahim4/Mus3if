import 'package:flutter/material.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/custom_container_widget.dart';

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
          ],
        ),
      ),
    );
  }
}

