import 'package:flutter/material.dart';
import 'waves_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(4, (_) => FocusNode());

  // Navigate to WavesScreen
  void _navigateToWavesScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WavesScreen()),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Handle OTP entry with auto-focus navigation
  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next box if there is input
      if (index < _focusNodes.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    } else {
      // Move back if the box is cleared
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
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

          Positioned(
            top: 60,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              child: const Icon(Icons.settings, color: Colors.white),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),

                // Title
                const Text(
                  "Enter Authentication Code",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inira",
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  "Enter the 4-digit code sent to ${widget.phoneNumber}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontFamily: "Inira",
                  ),
                ),

                const SizedBox(height: 40),

                // OTP Input Fields with Auto Focus Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 70,
                      height: 70,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontFamily: "Inira",
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                        ),
                        onChanged: (value) => _onOtpChanged(value, index),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 40),

                // Continue Button -> Navigate to WavesScreen
                InkWell(
                  onTap: _navigateToWavesScreen,
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
                        "Continue",
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

                // Resend Code Button
                Center(
                  child: TextButton(
                    onPressed: () {
                      print("Resend Code Pressed");
                    },
                    child: const Text(
                      "Resend code",
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