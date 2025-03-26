import 'package:flutter/material.dart';
import '../../common/custom/customButton.dart';
import '../register/registerScreen.dart';
import '../login/forgotPassScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _obscurePassword = true; //ẩn mkhau

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
            const SizedBox(height: 180,),
            const Text(
              "HI, PLEASE LOGIN!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 60,),

            Expanded(
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40),),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildInputField(Icons.phone, "Enter your email"),
                      const SizedBox(height: 20,),
                      _buildPasswordField(),
                      Align(
                        alignment: Alignment.centerRight,
                        //forgot button
                        child: TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassScreen()),);
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                        ),
                      ),
                      const SizedBox(height: 20,),

                      //button login
                      CustomButton(
                          text: "Login",
                          textColor: Colors.white,
                          gradientColors: [Color(0xFFE53935), Color(0xFFFF7043)],
                          onPressed: (){

                          }
                      ),

                      const Spacer(),
                      //signup
                      _buildSignupText(),
                    ],
                  ),
                )
            )
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
          borderSide: BorderSide(color: Color(0xFFFF3300))
        )
      ),
    );
  }

  Widget _buildPasswordField(){
    return TextField(
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.redAccent,),
        suffixIcon: IconButton(
            //mkhau bị ẩn thì off, k thì on
            icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
            ),
            onPressed: (){
              setState(() {
                //đảo trạng thái
                _obscurePassword = !_obscurePassword;
              });
            },
        ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF3300))
          )
      ),
    );
  }

  Widget _buildSignupText(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
           // handle event register
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen())
              );
            }, 
            child: const Text("Sign up",style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),))
      ],
    );
  }
}