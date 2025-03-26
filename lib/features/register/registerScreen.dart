import 'package:flutter/material.dart';
import '../../common/custom/customButton.dart';

// void main() {
//   runApp(
//     MaterialApp(debugShowCheckedModeBanner: false, home: RegisterScreen()),
//   );
// }

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE53935),
              Color(0xFFFF7043),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 200),
            const Text(
              "CREATE YOUR ACCOUNT",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildInputField(Icons.person, "Full name"),
                    const SizedBox(height: 20),
                    _buildInputField(Icons.phone, "Phone"),
                    const SizedBox(height: 20),
                    _buildInputField(Icons.email, "Email"),
                    const SizedBox(height: 20),
                    _buildPasswordField("Password"),
                    const SizedBox(height: 20,),
                    _buildPasswordField("Confirm Password"),
                    const SizedBox(height: 40,),
                    
                    //button
                    CustomButton(
                        text: "Sign up", 
                        textColor: Colors.white, 
                        gradientColors: [Color(0xFFE53935), Color(0xFFFF7043)], 
                        onPressed: (){
                          
                        }
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(IconData icon, String hintText) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.redAccent),
        hintText: hintText,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String hintText) {
    return TextField(
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.redAccent),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        hintText: hintText,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
