import 'package:flutter/material.dart';
import '../../common/custom/customButton.dart';
import './verificationScreen.dart';

class ForgotPassScreen extends StatefulWidget {
  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.black,)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Forgot Password?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent
              ),
            ),
            Text(
              "It is a long established fact that a roader will be distracted by the roadable content",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30,),
            _buildInputField(Icons.person, "Email or phone"),
            const SizedBox(height: 30,),
            CustomButton(
                text: "Submit",
                textColor: Colors.white,
                gradientColors: [Color(0xFFFF1A63), Color(0xFFFF8595)],
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VerificationScreen())
                  );
                }
            ),
            const Spacer(),
            Image.asset("assets/images/background_2.png", height: 361, width: 433,)
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(IconData icon, String hintText){
    return TextField(
      decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.redAccent,),
          hintText: hintText,
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          )
      ),
    );
  }
}