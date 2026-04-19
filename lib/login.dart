import 'package:flutter/material.dart';
import 'otp.dart';
import 'email_login.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNumber = "+91"; // Default country code

  void _navigateToOtpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpScreen(phoneNumber: phoneNumber),
      ),
    );
  }

  void _navigateToEmailLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailLoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/main_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Settings Icon
          Positioned(
            top: 60,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              child: const Icon(Icons.settings, color: Colors.white),
            ),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                // Welcome Text
                const Text(
                  "Welcome!",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inira",
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),

                // Phone Input Field
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      setState(() {
                        phoneNumber = number.phoneNumber!;
                      });
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    initialValue: PhoneNumber(isoCode: 'IN', dialCode: '+91'),
                    textStyle: const TextStyle(fontSize: 18, fontFamily: "Inira"),
                    inputDecoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Mobile number",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // SMS Info Text
                const Text(
                  "You will receive an SMS verification that may apply message and data rates.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontFamily: "Inira",
                  ),
                ),

                const SizedBox(height: 40),

                // Login Button
                InkWell(
                  onTap: _navigateToOtpScreen,
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        colors: [Colors.grey.shade400, Colors.grey.shade600],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inira",
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Email Login Navigation
                Center(
                  child: TextButton(
                    onPressed: _navigateToEmailLogin,
                    child: const Text(
                      "Use email, instead",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "Inira",
                      ),
                    ),
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