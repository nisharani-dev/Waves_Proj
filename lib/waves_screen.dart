import 'package:flutter/material.dart';
import 'pipeline_check_screen.dart';

class WavesScreen extends StatefulWidget {
  const WavesScreen({super.key});

  @override
  _WavesScreenState createState() => _WavesScreenState();
}

class _WavesScreenState extends State<WavesScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to PipelineCheckScreen after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PipelineCheckScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/front_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            "WAVES",
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              fontFamily: "Inira",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}