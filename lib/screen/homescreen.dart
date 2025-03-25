import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:waste_to_wealth/controllers/activity_controller.dart';
import 'package:waste_to_wealth/controllers/homescreen_controller.dart';
import 'package:waste_to_wealth/models/activity_model.dart';
import 'package:waste_to_wealth/screen/activity.dart';
import 'package:waste_to_wealth/screen/history.dart';
import 'package:waste_to_wealth/screen/pickup.dart';
import 'package:waste_to_wealth/screen/profile.dart';
import 'package:waste_to_wealth/screen/redeem.dart';
import 'package:waste_to_wealth/screen/social.dart';


// Main HomePage Widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TotalPointsController homescreenController = TotalPointsController();
  Future<Future<int>> get homescreenData async {
    return homescreenController.fetchHomescreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: _buildBottomNavBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 10),
              _buildActions(context), // Pass context for navigation
              const SizedBox(height: 10),
              _buildGraph(),
              const SizedBox(height: 10),
              _buildRecentActivity(context), // Pass context for navigation
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.eco, color: Colors.green, size: 100),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Rewards Balance",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  // Use FutureBuilder to show total points once data is fetched
                  FutureBuilder<int>(
                    future: TotalPointsController().fetchHomescreen(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Use snapshot.data directly since it's an integer
                        return Text(
                          'Total Points: ${snapshot.data}', // No need for `totalPoints` property
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.notifications, size: 28),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              // Navigate to a new page (Add your Redeem functionality here)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RedeemPage()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.card_giftcard, color: Colors.white, size: 40),
                SizedBox(width: 8),
                Text(
                  "Redeem",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              padding: const EdgeInsets.symmetric(vertical: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              // Navigate to the ActivityListPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SchedulePickupScreen()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, color: Colors.white, size: 40),
                SizedBox(width: 8),
                Text(
                  "Pickup",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGraph() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.white,
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            getDrawingHorizontalLine:
                (value) => FlLine(color: Colors.grey.shade300, strokeWidth: 1),
            drawVerticalLine: false,
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}p',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTitlesWidget: (value, meta) {
                  int month = value.toInt();
                  if (month == 1) {
                    return Text("Jan", style: TextStyle(color: Colors.grey));
                  } else if (month == 2) {
                    return Text("Feb", style: TextStyle(color: Colors.grey));
                  } else if (month == 3) {
                    return Text("Mar", style: TextStyle(color: Colors.grey));
                  } else if (month == 4) {
                    return Text("Apr", style: TextStyle(color: Colors.grey));
                  } else if (month == 5) {
                    return Text("May", style: TextStyle(color: Colors.grey));
                  }
                  return SizedBox();
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.shade300),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(1, 200),
                FlSpot(2, 400),
                FlSpot(3, 600),
                FlSpot(4, 800),
                FlSpot(5, 1000),
              ],
              isCurved: true,
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [Colors.blue.withOpacity(0.3), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              dotData: FlDotData(show: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to ActivityListPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ActivityListPage(),
                    ),
                  );
                },
                child: const Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<Activity>>(
              future:ActivityController().fetchActivities(), // Create an instance first
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print("Error fetching activities: ${snapshot.error}");
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No activities found.'));
                }

                // Display activities
                return ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final activity = snapshot.data![index];
                    return _buildActivityTile(
                      activity.title,
                      activity.description,
                      "+10 points", // Replace with actual points if available
                      activity.date.toString(), // Format this properly
                      Colors.green,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTile(
    String title,
    String weight,
    String points,
    String time,
    Color pointColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.recycling, color: Colors.green, size: 30),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(weight, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                points,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: pointColor,
                ),
              ),
              Text(time, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildBottomNavBar(BuildContext context) {
  return BottomNavigationBar(
    backgroundColor: Colors.green.shade200,
    selectedItemColor: Colors.green[900],
    unselectedItemColor: Colors.green[700],
    type: BottomNavigationBarType.fixed,
    onTap: (int index) {
      if (index == 1) {
        // Navigate to History page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PickupScheduleHistory()),
        );
      } else if (index == 2) {
        // Navigate to Social page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SocialPage()), // Replace with your actual SocialPage class
        );
      } else if (index == 3) {
        // Navigate to Profile page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()), // Replace with your actual ProfilePage class
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