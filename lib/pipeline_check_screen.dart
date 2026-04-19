import 'package:flutter/material.dart';
import 'dart:async';
import 'analytics_screen.dart';

class PipelineCheckScreen extends StatefulWidget {
  const PipelineCheckScreen({super.key});

  @override
  _PipelineCheckScreenState createState() => _PipelineCheckScreenState();
}

class _PipelineCheckScreenState extends State<PipelineCheckScreen>
    with SingleTickerProviderStateMixin {
  double progress = 0.0;
  List<String> tasks = [
    "Checking the main water pipeline....",
    "Checking the room 1 water pipeline....",
    "Checking the room 2 water pipeline....",
    "Checking the room 3 water pipeline....",
    "Checking the room 4 water pipeline....",
    "Checking the kitchen water pipeline....",
    "Checking the living room water pipeline....",
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 7),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          progress = _animation.value;
        });
      });

    _controller.forward();

    // Navigate to Analytics screen after progress completes
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AnalyticsScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentTask = (progress * tasks.length).floor();

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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                // Title
                const Text(
                  "Running Pipeline Checks....",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inira",
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                // Task List
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return AnimatedOpacity(
                        duration: const Duration(seconds: 1),
                        opacity: index <= currentTask ? 1.0 : 0.3,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            tasks[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "Inira",
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Custom Paint Progress Bar with gliding percentage mark
                Stack(
                  children: [
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: _GlowingProgressBarPainter(progress),
                      ),
                    ),

                    // Gliding Percentage Marker
                    Positioned(
                      left: (MediaQuery.of(context).size.width - 48) * progress,
                      child: Container(
                        height: 50,
                        width: 48,
                        alignment: Alignment.center,
                        child: Text(
                          "${(progress * 100).toInt()}%",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Inira",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Custom Painter ---
class _GlowingProgressBarPainter extends CustomPainter {
  final double progress;

  _GlowingProgressBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final double barHeight = size.height * 0.6;

    // Background Bar
    final backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, barHeight),
        const Radius.circular(25),
      ),
      backgroundPaint,
    );

    // Gradient Progress Bar
    final progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.lightBlueAccent,
          Colors.blueAccent,
          Colors.blue.shade700,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width * progress, barHeight))
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * progress, barHeight),
        const Radius.circular(25),
      ),
      progressPaint,
    );

    // Glow effect
    final glowPaint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * progress, barHeight),
        const Radius.circular(25),
      ),
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GlowingProgressBarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}