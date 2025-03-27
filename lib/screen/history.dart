import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waste_to_wealth/screen/homescreen.dart';
import '../screen/components/navigate.dart';
import 'package:waste_to_wealth/controllers/history_pickup_controller.dart';
import 'package:waste_to_wealth/models/history_pickup_model.dart';
import 'package:waste_to_wealth/screen/pickup.dart';


import 'package:waste_to_wealth/screen/components/header.dart';
import 'package:waste_to_wealth/screen/pickup.dart';


class PickupScheduleHistory extends StatefulWidget {
  const PickupScheduleHistory({super.key});

  @override
  _PickupScheduleHistoryState createState() => _PickupScheduleHistoryState();
}

class _PickupScheduleHistoryState extends State<PickupScheduleHistory> {
  final HistoryPickupController _historyPickupController =
      HistoryPickupController();
  List<HistoryPickupModel> schedules = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    try {
      List<HistoryPickupModel> history =
          await _historyPickupController.fetchHistoryPickup();
      setState(() {
        schedules = history;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Failed to load pickup history. Please try again later.";
      });
      print("Error fetching history: $e");
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Color(0xff5DB751);
      case 'canceled':
        return Color(0xffADB4BF);
      case 'scheduled':
        return const Color(0xFFFE221A);
      default:
        return Colors.orange;
    }
  }

  Future<void> onCancelClick(int index) async {
    final schedule = schedules[index];

    // Show confirmation dialog if the status is 'scheduled'
    if (schedule.status.toLowerCase() == 'scheduled') {
      bool? isConfirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Cancellation'),
            content: const Text('Are you sure you want to cancel this pickup?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false); // User pressed "No"
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true); // User pressed "Yes"
                },
                child: const Text('Yes'),
              ),
            ],
          );
        },
      );

      // If confirmed, proceed with cancellation
      if (isConfirmed == true) {
        try {
          setState(() => isLoading = true);
          await _historyPickupController.deleteHistoryPickup(schedule.pickupId);
          setState(() {
            schedules.removeAt(index);
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pickup canceled successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } catch (e) {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to cancel pickup: $e'),
              backgroundColor: Colors.red,
            ),
          );
          print("Error canceling pickup: $e");
        }
      }
    }
  }

  String formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('MMM d, y, h:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
      appBar: HeaderBar(
        title: 'History Pickup',
       onBackPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                );
            },
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Schedule History:',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
                : schedules.isEmpty
                ? const Center(child: Text("No pickup history available"))
                : Expanded(
                  child: RefreshIndicator(
                    onRefresh: _fetchHistory,
                    child: ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (context, index) {
                        final schedule = schedules[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      formatDate(schedule.date),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      schedule.wasteTypes.join(", "),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap:
                                      schedule.status.toLowerCase() ==
                                              'scheduled'
                                          ? () => onCancelClick(index)
                                          : null,
                                  child: Container(
                                    height: 30,
                                    width: 100,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: getStatusColor(schedule.status),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        schedule.status,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
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
    );
  }
}