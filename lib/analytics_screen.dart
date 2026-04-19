import 'package:flutter/material.dart';
import 'room_detail_screen.dart';  // Import the separate room details screen

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> data = [
      {'title': 'MAIN PIPELINE', 'status': 'No leakage detected'},
      {'title': 'ROOM 1', 'status': 'No leakage detected'},
      {'title': 'ROOM 2', 'status': 'Minor leakage detected'},
      {'title': 'ROOM 3', 'status': 'Minor leakage detected'},
      {'title': 'ROOM 4', 'status': 'Minor leakage detected'},
      {'title': 'KITCHEN', 'status': 'No leakage detected'},
      {'title': 'LIVING ROOM', 'status': 'Minor leakage detected'},
    ];

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                // Title
                const Text(
                  "Analytics",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Inira",
                  ),
                ),

                const SizedBox(height: 20),

                // Room List
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];

                      return GestureDetector(
                        onTap: () {
                          if (item['status']!.contains('Minor')) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RoomDetailsScreen(  // Correct class name
                                  roomName: item['title']!,
                                  status: item['status']!,
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: item['status']!.contains('Minor')
                                ? Colors.red.withOpacity(0.6)
                                : Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title']!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                item['status']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
