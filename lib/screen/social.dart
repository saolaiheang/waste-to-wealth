import 'package:flutter/material.dart';
import 'package:waste_to_wealth/screen/newSocial.dart';
import '../screen/components/navigate.dart';


void main() {
  runApp(const SocialPage());
}

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WasteToWealthScreen(),
    );
  }
}

class WasteToWealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "waste to wealth",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),

        backgroundColor: Colors.white,
        elevation: 0,

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePostScreen()),
                );
            },
            icon: Image.asset('assets/icons/Frame 49.png'),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/Vector(5).png',
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/image 8.png', color: Colors.black),
          ),
          SizedBox(width: 10),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            PostInputField(),
            SizedBox(height: 19),
            PostCard(),
            SizedBox(height: 30),
            PostCard(),
            SizedBox(height: 30),
            PostCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2), 
    );
  }
}

class PostInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/icons/Ellipse 12.png'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "What's on your mind?",
                    

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Divider(
            thickness: 1,
            color: Colors.grey,
            height: 20,
          )
        ],
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/icons/Ellipse 13.png'),
            ),
            title: Text("HeaNG", style: TextStyle(fontSize: 20)),
            subtitle: Text(
              "Just now",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            trailing: Chip(
              label: Text(
                "Raising Funds",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color(0xff5DB751),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          Image.asset(
            'assets/icons/image(1).png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SizedBox(height: 6,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  
                  children: [
                    
                    Image.asset('assets/icons/Vector(8).png'),
                    SizedBox(width: 10),
                    Image.asset('assets/icons/Vector(6).png'),
                    SizedBox(width: 10),
                    Image.asset('assets/icons/Vector(7).png'),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 6),
                Text("65 Like",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                SizedBox(height: 10),
                Text(
                  "Collecting Truce in Village",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                ),
                SizedBox(height: 15),
                Text(
                  "Clean from small to big. Don't forget clean you home. Happy leave with Environment.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


