import 'package:fitness_mvp/helper/app_colors.dart';
import 'package:fitness_mvp/helper/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;
  bool isFocused = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Dimensions.calculateHeight(50, context),),
            Text("Welcome to Fitness World", style: TextStyle(color: Colors.white, fontSize: Dimensions.calculateHeight(30, context), fontWeight: FontWeight.bold),),
            SizedBox(height: Dimensions.calculateHeight(10, context),),
            Text("Please login into your account", style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontWeight: FontWeight.bold, fontSize: Dimensions.calculateHeight(20, context),)),
            SizedBox(height: Dimensions.calculateHeight(30, context)),
            Container(
                margin: EdgeInsetsGeometry.symmetric(horizontal: Dimensions.calculateWidth(30, context)),
                height: MediaQuery.of(context).size.height*0.6,
                padding: EdgeInsets.all(Dimensions.calculateHeight(20, context)),
                decoration: BoxDecoration(
                  color: const Color(0xFF25277A),
                  borderRadius: BorderRadius.circular(Dimensions.calculateHeight(20, context)),
                  border: Border.all(color: const Color(0xFF8A84FF))
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width:double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email",style: TextStyle(color: Colors.white,fontSize: Dimensions.calculateHeight(24, context), fontWeight: FontWeight.bold),),
                          SizedBox(height: Dimensions.calculateHeight(5, context),),
                          _textField("user@example.com", false, emailController, isFocused),
                          SizedBox(height: Dimensions.calculateHeight(20, context),),
                          Text("Password",style: TextStyle(color: Colors.white,fontSize: Dimensions.calculateHeight(24, context), fontWeight: FontWeight.bold),),
                          SizedBox(height: Dimensions.calculateHeight(5, context),),
                          _textField("your password",true, passwordController, isFocused),
                        ],
                      ),
                  ),
                  Container(
        
                  ),
                  Container(
        
                  )
                ],
              ),
              ),
        
          ],
        ),
      ),
    );
  }

  Widget _textField(String hintText, bool obscureText, TextEditingController _controller , bool isFocused){

    return Focus(
      onFocusChange: (value) {
        setState(() {
          isFocused = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),

        width: double.maxFinite,
        height: Dimensions.calculateHeight(38, context),

        decoration: BoxDecoration(
          color: isFocused
              ? const Color(0xFF25277A)
              : const Color(0xFF181A61),

          borderRadius: BorderRadius.circular(
            Dimensions.calculateHeight(12, context),
          ),

          border: Border.all(
            color: isFocused
                ? const Color(0xFF8A84FF)
                : const Color(0xFF34368A),
            width: isFocused ? 1.5 : 1,
          ),

          boxShadow: isFocused
              ? [
            BoxShadow(
              color: const Color(0xFF6C63FF)
                  .withValues(alpha: 0.18),
              blurRadius: 8,
            ),
          ]
              : [],
        ),

        child: TextField(
          controller: _controller,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,

          maxLength: 4,

          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.calculateHeight(16, context),
            fontWeight: FontWeight.w600,
          ),

          decoration: InputDecoration(
            counterText: "",

            hintText: hintText,

            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.28),
              fontSize: Dimensions.calculateHeight(15, context),
              fontWeight: FontWeight.normal,
            ),

            isCollapsed: true,

            contentPadding: EdgeInsets.symmetric(
              vertical: Dimensions.calculateHeight(9, context),
              horizontal: Dimensions.calculateWidth(6, context),
            ),

            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
