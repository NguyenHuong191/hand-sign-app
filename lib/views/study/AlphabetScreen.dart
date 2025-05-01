import 'package:flutter/material.dart';
import '../../widgets/custom/CustomAppBar.dart';


class AlphabetScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Alphabet"),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
               colors: [Color(0xFFFF004D), Color(0xFFFF1354), Color(0xFFFF7A95)],
               begin: Alignment.topLeft,
               end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
               "Let's be smart together!",
               style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Cần có màu để ShaderMask hoạt động
              ),
              textAlign: TextAlign.center,
            ),
            ),
            SizedBox(height: 30,),
            Image.asset("assets/images/alphabet.png", height: 400, width: double.infinity,),
          ],
        ),
      ),
    );
  }
}