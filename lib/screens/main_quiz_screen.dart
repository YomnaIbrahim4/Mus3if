import 'package:flutter/material.dart';

import '../widgets/appbar_widget.dart';

class MainQuizScreen extends StatefulWidget {
  const MainQuizScreen({super.key});

  @override
  State<MainQuizScreen> createState() => _MainQuizScreenState();
}

class _MainQuizScreenState extends State<MainQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Test Your Knoledge'),
    );
  }
}