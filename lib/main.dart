import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LockScreen(),
    );
  }
}

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  double _unlockPosition = 0.0;
  bool _isUnlocked = false;

  @override
  Widget build(BuildContext context) {
    double buttonWidth = 250;
    double buttonHeight = 55;
    double knobSize = 50;
    double maxSlide = buttonWidth - knobSize - 10;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/front_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // App Title
          const Center(
            child: Text(
              'WAVES',
              style: TextStyle(
                fontSize: 80,
                fontFamily: "Inira",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
                shadows: [Shadow(blurRadius: 10, color: Colors.black54)],
              ),
            ),
          ),

          // Settings Icon
          Positioned(
            top: 60,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.3),
              child: const Icon(Icons.settings, color: Colors.white),
            ),
          ),

          // Slide-to-Unlock Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _unlockPosition = (details.localPosition.dx).clamp(0, maxSlide);
                  });
                },
                onHorizontalDragEnd: (details) {
                  if (_unlockPosition >= maxSlide) {
                    setState(() {
                      _isUnlocked = true;
                    });

                    // Navigate to LoginScreen
                    Future.delayed(const Duration(milliseconds: 300), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    });
                  } else {
                    // Reset if not fully slid
                    setState(() {
                      _unlockPosition = 0.0;
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: buttonWidth,
                  height: buttonHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: _isUnlocked ? Colors.green.withOpacity(0.8) : Colors.grey.withOpacity(0.6),
                    boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.black38, spreadRadius: 2)],
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          _isUnlocked ? "Unlocked" : "Slide to Unlock",
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 200),
                        left: _unlockPosition,
                        child: Container(
                          width: knobSize,
                          height: knobSize,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black38, spreadRadius: 2)],
                          ),
                          child: Icon(
                            _isUnlocked ? Icons.check : Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}