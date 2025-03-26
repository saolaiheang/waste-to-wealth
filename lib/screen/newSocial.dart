import 'package:flutter/material.dart';
import 'package:waste_to_wealth/screen/components/header.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool isRaisingFund = true;
  bool isJustPosting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(title: 'Create Post',
      onBackPress: () {
        Navigator.pop(context);
      },
      
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Text(
              "Title",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 18),
            TextField(
              decoration: InputDecoration(
                hintText: "Write your title here...",
                hintStyle: TextStyle(color: Color(0xff309255)),

                filled: true,
                fillColor: Colors.green.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 18),

            Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 18),

            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                    
                  ),
                ],
              ),

             child:  TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Write your description here...",
                  hintStyle: TextStyle(color: Color(0xff309255)),
                  filled: true,
                  fillColor: Colors.green.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset('assets/icons/Vector(9).png'),
              label: Text(
                "Upload Image",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Please Choose:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Raising Fund", style: TextStyle(fontSize: 16)),
                Switch(
                  value: isRaisingFund,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      isRaisingFund = value;
                      if (value) isJustPosting = false;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Just Posting", style: TextStyle(fontSize: 16)),
                Switch(
                  value: isJustPosting,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      isJustPosting = value;
                      if (value) isRaisingFund = false;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
