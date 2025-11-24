import 'package:flutter/material.dart';
import '../screens/main_quiz_screen.dart';

class QuizBannerWidget extends StatelessWidget {
  const QuizBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF6B6B), // Soft Red
            Color(0xFFE63946), // Deeper Red
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Ready to test your knowledge?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(width: 10),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFDFDFD), 
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            onPressed: () {
              Navigator.push(
                context,
              MaterialPageRoute(
                builder: (context) => MainQuizScreen(),
              ),
            );
            },
            child: Row(
              children: [
                Text(
                  "Start Quiz",
                  style: TextStyle(
                    color: Color(0xFFE63946),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.quiz_rounded,
                  color: Color(0xFFE63946),
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
