import 'package:flutter/material.dart';
import 'waves_screen.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Navigate to WavesScreen
  void _navigateToWavesScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WavesScreen()),
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

                const Text(
                  "Login with Email",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inira",
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),

                // Email Field
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
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontFamily: "Inira",
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "Inira",
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Password Field
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
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        fontFamily: "Inira",
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "Inira",
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Login Button -> Navigate to WavesScreen
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}