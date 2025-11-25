import 'package:flutter/material.dart';
import 'package:mus3if/screens/medical_chat_screen.dart';

class FloatingChatButton extends StatefulWidget {
  const FloatingChatButton({Key? key}) : super(key: key);

  @override
  FloatingChatButtonState createState() => FloatingChatButtonState();
}

class FloatingChatButtonState extends State<FloatingChatButton> {
  Offset _position = Offset(300, 300); // default position

  void _openChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MedicalChatScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _position += details.delta;

            if (_position.dx < 0) _position = Offset(0, _position.dy);
            if (_position.dx > screenWidth - 80)
              _position = Offset(screenWidth - 80, _position.dy);
            if (_position.dy < 0) _position = Offset(_position.dx, 0);
            if (_position.dy > screenHeight - 80)
              _position = Offset(_position.dx, screenHeight - 80);
          });
        },
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () => _openChat(context),
            backgroundColor: Colors.red[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.smart_toy, size: 24, color: Colors.white),
                SizedBox(height: 2),
                Text(
                  'AI',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            elevation: 8,
          ),
        ),
      ),
    );
  }
}
