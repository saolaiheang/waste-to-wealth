import 'package:flutter/material.dart';

class PickupScheduleHistory extends StatefulWidget {
  @override
  _PickupScheduleHistoryState createState() => _PickupScheduleHistoryState();
}

class _PickupScheduleHistoryState extends State<PickupScheduleHistory> {
  final List<Map<String, String>> schedules = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pickup History', style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your Schedule History:', style: TextStyle(fontSize: 16, color: Colors.black54)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  final schedule = schedules[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(schedule['date']!, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(schedule['waste']!),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        decoration: BoxDecoration(
                          color: getStatusColor(schedule['status']!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          schedule['status']!,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
