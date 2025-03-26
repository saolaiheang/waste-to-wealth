import 'package:flutter/material.dart';
import 'package:waste_to_wealth/controllers/homescreen_controller.dart';
import '../screen/components/navigate.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final TotalPointsController homescreenController = TotalPointsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), // Set the height to 120
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false, // Removes the back button
          centerTitle: true,
          flexibleSpace: Center(
            child: Text(
              "Profile",
              style: TextStyle(
                fontSize: 25, // Bigger text size
                fontWeight: FontWeight.bold,
                color: Colors.green[500],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Keep the profile image at the top
          crossAxisAlignment: CrossAxisAlignment.center, // Center the text and avatar horizontally
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: CircleAvatar(
                radius: 80, // Set a radius to control the size of the avatar
                backgroundImage: AssetImage('assets/icons/vouch.jpeg'),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Mom Vouchheang",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            buildHeader(),
            const SizedBox(height: 16),
            buildProfileOptions(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3), // Attach BottomNavBar
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFFECE6EC),
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: BoxConstraints(
        maxWidth: 450, // Set a max width to avoid the container becoming too wide
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding for left and right
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.eco, color: Colors.green, size: 40),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rewards Balance",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    FutureBuilder<int>(
                      future: homescreenController.fetchHomescreen(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            '${snapshot.data} P',
                            style: const TextStyle(
                              fontSize: 32,
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
          ],
        ),
      ),
    );
  }

  Widget buildProfileOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          buildOptionTile(Icons.edit, "Edit profile", "Customize your profile"),
          buildOptionTile(Icons.notifications, "Notifications", "See your notifications"),
          buildOptionTile(Icons.settings, "Settings", "Customize your settings"),
          buildOptionTile(Icons.logout, "Log out", "Want to leave?"),
        ],
      ),
    );
  }

  Widget buildOptionTile(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: () {},
      ),
    );
  }
  }