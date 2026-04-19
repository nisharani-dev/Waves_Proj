import 'package:flutter/material.dart';

class RoomDetailsScreen extends StatelessWidget {
  final String roomName;
  final String status;

  const RoomDetailsScreen({
    super.key,
    required this.roomName,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    bool isMinorLeakage = status.contains('Minor');

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

                // Room Title
                Text(
                  roomName,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Inira",
                  ),
                ),

                const SizedBox(height: 10),

                // Leakage Status
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 18,
                    color: isMinorLeakage ? Colors.redAccent : Colors.green,
                    fontFamily: "Inira",
                  ),
                ),

                const SizedBox(height: 40),

                // Info Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Time Duration:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Inira",
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "N/A",  // Placeholder value
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontFamily: "Inira",
                        ),
                      ),

                      SizedBox(height: 20),

                      Text(
                        "Distance (Range):",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Inira",
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "N/A",  // Placeholder value
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          fontFamily: "Inira",
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 80),

                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "Back",
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}