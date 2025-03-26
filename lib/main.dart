import 'package:flutter/material.dart';
import './common/custom/customButton.dart';
import './features/register/registerScreen.dart';
import './features/login/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HandSignApp(),
  ));
}

class HandSignApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Image.asset("assets/images/bakcground_1.png", height: 430, width: 430,),
            Text(
              "GET START",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 30,),

            //button sign up
            CustomButton(
                text: "Signup",
                textColor: Colors.white,
                gradientColors: [Color(0xFFFF157A), Color(0xFF4E002F)],
                onPressed: (){
                  //chuyển sang đăng ký
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                }
            ),
            const SizedBox(height: 30,),

            //button đăng nhập
            CustomButton(
                text: "Login",
                textColor: Color(0xFFFF4545),
                gradientColors: [Colors.white, Colors.white],
                isOutlined: true,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen())
                  );
                }
            ),
            const SizedBox(height: 40,),

            const Text(
              "Continute with Social Media",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Các biểu tượng mạng xã hội
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon("assets/icons/facebook.png"),
                const SizedBox(width: 20),
                _buildSocialIcon("assets/icons/apple.png"),
                const SizedBox(width: 20),
                _buildSocialIcon("assets/icons/google.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget tạo biểu tượng mạng xã hội
  Widget _buildSocialIcon(String assetPath) {
    return Container(
      width: 79,
      height: 58,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFFF6262)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Image.asset(assetPath, width: 40, height: 40,),
      ),
    );
  }
}

