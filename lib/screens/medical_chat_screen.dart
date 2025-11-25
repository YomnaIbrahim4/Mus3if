import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:mus3if/config/keys.dart';


class MedicalChatScreen extends StatefulWidget {
  const MedicalChatScreen({Key? key}) : super(key: key);

  @override
  MedicalChatScreenState createState() => MedicalChatScreenState();
}

class MedicalChatScreenState extends State<MedicalChatScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize Gemini
    Gemini.init(apiKey: GEMINI_API_KEY);

    // Welcome message
    _messages.add({
      'text': 'Hello! I am your medical assistant. Ask me anything about first aid!',
      'isUser': false,
    });
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    String userMessage = _controller.text;
    _controller.clear();

    setState(() {
      _messages.add({'text': userMessage, 'isUser': true});
      _isLoading = true;
    });

    try {
      final gemini = Gemini.instance;

      // System prompt
      const systemPrompt = '''
You are a medical assistant specialized in first aid and general medical information.

**STRICT RULES:**
1. ONLY provide first aid instructions and general health information
2. NEVER diagnose medical conditions
3. NEVER prescribe medications or treatments
4. ALWAYS direct emergencies to professional medical help
5. Keep responses concise and to the point
6. Respond in the same language the user writes in

**⚠️ STRICTLY PROHIBITED:**
- ❌ Diagnosing diseases or medical conditions
- ❌ Prescribing medications or specific treatments  
- ❌ Answering "is this cancer?" or similar serious disease questions
- ❌ Providing alternative treatments instead of doctor consultations
- ❌ Interpreting lab results or medical tests
- ❌ Giving second opinions on doctor's diagnoses
- ❌ Recommending specific doctors or hospitals

**SPECIAL CASES:**
- For "thank you", "thanks", "شكراً": Respond with brief acknowledgment only
- For "hello", "hi", "مرحباً": Respond with brief greeting only  
- For medical questions: Provide clear, step-by-step first aid instructions

**EMERGENCY PROTOCOL:**
If user describes emergency symptoms, immediately respond: "🚨 This sounds serious! Please call emergency services (911/999) or go to the nearest hospital immediately."

**PROHIBITED QUESTIONS RESPONSE:**
If user asks for diagnosis, medication, or serious disease advice, respond: "I cannot provide medical diagnosis or prescribe treatments. Please consult a healthcare professional for proper medical advice."

**RESPONSE EXAMPLES:**
User: "thank you"
Response: "You're welcome! 😊"

User: "شكراً"
Response: "العفو! 😊"

User: "What medicine for headache?"
Response: "I cannot prescribe medications. For headaches, rest and hydration may help, but consult a doctor for proper treatment."

User: "هل هذا سرطان؟"
Response: "لا أستطيع تشخيص الأمراض. يرجى استشارة طبيب متخصص للتشخيص الدقيق."

User: "burn treatment"
Response: "For minor burns: 1. Cool under running water for 10-15 minutes. 2. Cover with sterile dressing. 3. Seek medical help if severe."

User: "علاج الحروق"
Response: "لحروق بسيطة: 1. برد المنطقة تحت ماء جاري لمدة 10-15 دقيقة. 2. غطِ بضمادة معقمة. 3. اطلب المساعدة الطبية إذا كانت الحروق شديدة."
''';

      final response = await gemini.prompt(
        parts: [
          Part.text(systemPrompt),
          Part.text(userMessage),
        ],
      );

      String botResponse = response?.output ?? 'Sorry, I could not answer.';

      setState(() {
        _messages.add({'text': botResponse, 'isUser': false});
        _isLoading = false;
      });

      // Auto scroll to bottom
      _scrollToBottom();

    } catch (e) {
      setState(() {
        _messages.add({
          'text': 'Error: Please check your internet connection and try again.',
          'isUser': false,
        });
        _isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.smart_toy, color: Colors.white),
            SizedBox(width: 8),
            Text('Medical Assistant'),
          ],
        ),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(
                  text: message['text'],
                  isUser: message['isUser'],
                );
              },
            ),
          ),

          // Loading indicator
          if (_isLoading)
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      strokeWidth: 3,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Medical Assistant is typing...',
                    style: TextStyle(color: Colors.red[700], fontSize: 14),
                  ),
                ],
              ),
            ),

          // Input area
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your medical question here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.red[700]!),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.red[700],
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const MessageBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.smart_toy, color: Colors.red[600], size: 20),
            ),
          SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser ? Colors.red[700] : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: isUser ? Colors.white : Colors.grey[800],
                ),
              ),
            ),
          ),
          if (isUser) SizedBox(width: 8),
          if (isUser)
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.person, color: Colors.red[700], size: 20),
            ),
        ],
      ),
    );
  }
}