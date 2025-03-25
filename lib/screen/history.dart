import 'package:flutter/material.dart';
import 'package:waste_to_wealth/screen/homescreen.dart';
import 'package:waste_to_wealth/screen/pickup.dart';
import 'package:waste_to_wealth/screen/profile.dart'; // Assuming ProfilePage exists

class PickupScheduleHistory extends StatefulWidget {
  @override
  _PickupScheduleHistoryState createState() => _PickupScheduleHistoryState();
}

class _PickupScheduleHistoryState extends State<PickupScheduleHistory> {
  List<Map<String, String>> schedules = [
    {'date': '02-Dec-2028', 'waste': 'Plastic', 'status': 'Cancel'},
    {'date': '02-Dec-2028', 'waste': 'Paper', 'status': 'Completed'},
    {'date': '02-Dec-2028', 'waste': 'Paper', 'status': 'Canceled'},
    {'date': '02-Dec-2028', 'waste': 'Paper', 'status': 'Cancel'},
    {'date': '02-Dec-2028', 'waste': 'Paper', 'status': 'Canceled'},
    {'date': '02-Dec-2028', 'waste': 'Paper', 'status': 'Completed'},
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'Canceled':
        return Colors.grey;
      case 'Cancel':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  void onCancelClick(int index) {
    setState(() {
      schedules.removeAt(index); // Remove item from the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          margin: EdgeInsets.only(top: 40),
          child: AppBar(
            elevation: 0,
            title: Text(
              'Pickup History',
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: Image.asset(
                'assets/icons/Frame 2.png',
                height: 80,
                width: 80,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SchedulePickupScreen()),
                );
              },
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/icons/Ellipse 12.png'),
                ),
              ),
              SizedBox(width: 33),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 44),
            Text(
              'Your Schedule History:',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 22),
            Container(
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          final schedule = schedules[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(schedule['date']!),
                                Text(schedule['waste']!),
                                GestureDetector(
                                  onTap: schedule['status'] == 'Cancel'
                                      ? () => onCancelClick(index)
                                      : null, // Only clickable if status is "Cancel"
                                  child: Container(
                                    height: 26,
                                    width: 100,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 11,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getStatusColor(schedule['status']!),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        schedule['status']!,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context), // Attach BottomNavBar
    );
  }

  Widget buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green.shade200,
      selectedItemColor: Colors.green[900],
      unselectedItemColor: Colors.green[700],
      type: BottomNavigationBarType.fixed,
      currentIndex: 1, // Ensure "History" is highlighted
      onTap: (int index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()), // Navigate to Home
          );
        } else if (index == 1) {
          // Already on PickupScheduleHistory, no action needed
        } else if (index == 2) {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => SocialPage()), // Navigate to Social
          // );
        } else if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to Profile
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "Social"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
