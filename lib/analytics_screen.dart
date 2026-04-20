import 'package:flutter/material.dart';
import 'room_detail_screen.dart';
import 'services/api_service.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<Map<String, dynamic>> _rooms = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final rooms = await ApiService.getPipelineStatus();

    setState(() {
      _isLoading = false;
      if (rooms.isEmpty) {
        _error = 'Could not load pipeline data. Pull down to retry.';
      } else {
        _rooms = rooms;
      }
    });
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
                    fontFamily: "Inria",
                  ),
                ),

                const SizedBox(height: 20),

                // Content
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : _error != null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _error!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontFamily: "Inria",
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: _fetchData,
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: _fetchData,
                              child: ListView.builder(
                                itemCount: _rooms.length,
                                itemBuilder: (context, index) {
                                  final room = _rooms[index];
                                  final bool isLeaking =
                                      room['leakage_detected'] == true;

                                  return GestureDetector(
                                    onTap: () {
                                      if (isLeaking) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RoomDetailsScreen(
                                              roomName: room['room_name'],
                                              status: room['status'],
                                              timeDuration:
                                                  room['time_duration'],
                                              distanceRange:
                                                  room['distance_range'],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: isLeaking
                                            ? Colors.red.withOpacity(0.6)
                                            : Colors.grey.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            room['room_name'],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: "Inria",
                                            ),
                                          ),
                                          Text(
                                            room['status'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontFamily: "Inria",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
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
