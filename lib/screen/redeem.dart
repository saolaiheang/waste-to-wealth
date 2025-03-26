import 'package:flutter/material.dart';
import 'package:waste_to_wealth/screen/components/header.dart';

class RedeemPage extends StatefulWidget {
  const RedeemPage({super.key});

  @override
  _RedeemPageState createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  Map<int, bool> loadingStates = {};

  void redeem(int index) {
    setState(() {
      loadingStates[index] = true;
    });

    // Simulate API call delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loadingStates[index] = false;
      });
      // You can also show a success message here
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Redeemed successfully!")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: HeaderBar(title: 'Redeem',
      onBackPress: (){
        Navigator.pop(context);
      },
      ),


      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Image/Icon Section
                    Icon(
                      Icons.eco,
                      color: Colors.green,
                      size: 100,
                    ), // Adjusted size
                    // Text & Points Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rewards Balance",
                            style: TextStyle(
                              fontSize: 16, // Adjusted font size
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 2), // Added space
                          Text(
                            "1963p",
                            style: TextStyle(
                              fontSize: 32, // Adjusted font size
                              fontWeight: FontWeight.bold,
                              color: Colors.green[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    rewardItem(
                      0,
                      "Cash Voucher",
                      "\$10",
                      500,
                      Icons.attach_money,
                    ),
                    rewardItem(
                      1,
                      "Shopping Discount",
                      "20% OFF",
                      1000,
                      Icons.percent,
                    ),
                    rewardItem(
                      2,
                      "Free PickUp",
                      "1 Service",
                      250,
                      Icons.local_shipping,
                    ),
                    rewardItem(
                      3,
                      "Eco-Friendly Products",
                      "Gift Box",
                      750,
                      Icons.card_giftcard,
                    ),
                    rewardItem(
                      4,
                      "Free PickUp",
                      "1 Service",
                      250,
                      Icons.local_shipping,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rewardItem(
    int index,
    String title,
    String subtitle,
    int points,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Color(0xFFE1FFF3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green, size: 45),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.green[700]),
                  ),
                  Text(
                    "$points points",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          loadingStates[index] == true
              ? CircularProgressIndicator()
              : ElevatedButton(
                onPressed: () => redeem(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Redeem", style: TextStyle(color: Colors.white)),
              ),
        ],
      ),
    );
  }
}
