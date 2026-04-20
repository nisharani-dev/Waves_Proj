import 'package:flutter/material.dart';
import 'waves_screen.dart';
import 'services/api_service.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isRegistering = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Please enter your email and password.');
      return;
    }

    setState(() => _isLoading = true);

    final result = _isRegistering
        ? await ApiService.register(email, password)
        : await ApiService.login(email, password);

    setState(() => _isLoading = false);

    if (result['success'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WavesScreen()),
      );
    } else {
      _showError(result['error'] ?? 'Something went wrong.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontFamily: "Inria")),
        backgroundColor: Colors.redAccent,
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

                Text(
                  _isRegistering ? "Create Account" : "Login with Email",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inria",
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
                      BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
                    ],
                  ),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 18, fontFamily: "Inria"),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Inria"),
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
                      BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
                    ],
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 18, fontFamily: "Inria"),
                      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                    ),
                    style: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Inria"),
                  ),
                ),

                const SizedBox(height: 40),

                // Login / Register Button
                InkWell(
                  onTap: _isLoading ? null : _submit,
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
                    child: Center(
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              _isRegistering ? "REGISTER" : "LOGIN",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inria",
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Toggle between login and register
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() => _isRegistering = !_isRegistering);
                    },
                    child: Text(
                      _isRegistering
                          ? "Already have an account? Login"
                          : "Don't have an account? Register",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Inria",
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
