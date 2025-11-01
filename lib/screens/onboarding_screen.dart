import 'package:flutter/material.dart';
import 'package:mus3if/screens/login_screen.dart';
import '../models/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: content.length,
                onPageChanged: (int index){
                  setState(() {
                    currentIndex= index;
                  });
                },
                itemBuilder: (_,i){
                  return Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Image.asset(content[i].image,
                        height: 350,),
                        SizedBox(height: 20,),
                        Text(content[i].title,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        ),
                        SizedBox(height: 20),
                        Text(content[i].description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[700],
                        ),
                        ),
                      ],
                    ),
                    );
                },
                ),
              ),
              SmoothPageIndicator(
                controller: _controller!,
                count: content.length,
                effect: ExpandingDotsEffect(
                  expansionFactor: 4,
                  spacing: 8,
                  radius: 16,
                  dotWidth: 8,
                  dotHeight: 8,
                  dotColor: Colors.grey.shade500,
                  activeDotColor: Color(0xffB72323),
                ),
              ),
              
              SizedBox(height: 30,),
              Padding(
                padding:  EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: (){
                    if (currentIndex == content.length - 1){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    } else{
                    _controller!.nextPage(
                      duration: Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                    );
                    }
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffB72323),
                    foregroundColor: Colors.white,
                    padding:  EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), 
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentIndex == content.length - 1 ? "Continue" : "Next",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(Icons.arrow_forward),
                    ],
                  ),
                    ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                }, 
                child: Text('Skip',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]
                ),)
                ),
                SizedBox(height: 15,),
        
          ],
        ),
      ),
    );
  }
}