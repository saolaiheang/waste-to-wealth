import 'package:flutter/material.dart';
import 'package:waste_to_wealth/controllers/homescreen_controller.dart';
import 'package:waste_to_wealth/controllers/redeem_controller.dart';
import 'package:waste_to_wealth/models/redeem_model.dart';
import 'package:waste_to_wealth/screen/components/header.dart';

class RedeemListPage extends StatefulWidget {
  const RedeemListPage({super.key});

  @override
  _RedeemListPageState createState() => _RedeemListPageState();
}

class _RedeemListPageState extends State<RedeemListPage> {
  final TotalPointsController _totalPointsController = TotalPointsController();
  final RedeemController _redeemController = RedeemController();
  List<bool> loadingStates = [];

  @override
  void initState() {
    super.initState();
    _loadRedeems();
  }

  Future<void> _loadRedeems() async {
    final redeems = await _redeemController.fetchRedeems();
    setState(() {
      loadingStates = List.generate(redeems.length, (index) => false);
    });
  }

  void redeem(int index) async {
    setState(() {
      loadingStates[index] = true;
    });

    await Future.delayed(Duration(seconds: 2)); // Simulating a redeem process

    setState(() {
      loadingStates[index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: HeaderBar(
        title: 'Redeem',
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.eco,
                      color: Colors.green,
                      size: 100,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start,

              children: [
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rewards Balance",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    FutureBuilder<int>(
                      future: _totalPointsController.fetchHomescreen(),
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
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Redeem>>(
                  future: _redeemController.fetchRedeems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      debugPrint("Error fetching redeems: ${snapshot.error}");
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No redeems found.'));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final redeem = snapshot.data![index];
                        return _rewardItem(
                          title: redeem.title,
                          description: redeem.description,
                          exchangePoint: redeem.exchangePoint,
                          icon: Icons.card_giftcard,
                          index: index,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rewardItem({
    required String title,
    required String description,
    required int exchangePoint,
    required IconData icon,
    required int index,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE1FFF3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green, size: 45),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.green[700]),
                  ),
                  Text(
                    "$exchangePoint points",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          loadingStates.isNotEmpty && loadingStates[index]
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () => redeem(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[500],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Redeem", style: TextStyle(color: Colors.white)),
                ),
        ],
      ),
    );
  }
}
