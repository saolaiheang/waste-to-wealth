import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:waste_to_wealth/controllers/schedule_controller.dart';
import 'package:waste_to_wealth/screen/history.dart';

class SchedulePickupScreen extends StatefulWidget {
  @override
  _SchedulePickupScreenState createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends State<SchedulePickupScreen> {
  DateTime selectedDate = DateTime.now();
  List<String> selectedWasteTypes = [];
  String selectedWeightUnit = "(kg)";
  bool recurringMonth = false;
  bool recurringWeek = false;
  bool recurringDay = false;

  // List of waste types
  final List<String> _wasteTypes = ["Paper", "Plastic", "Metal", "Glass"];

  final ScheduleController _scheduleController = ScheduleController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _schedulePickup() async {
    try {
      final weightValue =
          double.tryParse(
            selectedWeightUnit.replaceAll(RegExp(r'[^0-9.]'), ''),
          ) ??
          0.0;

      final _ = await _scheduleController.createNewSchedule(
        userId: "1",
        date: selectedDate.toIso8601String(),
        wasteTypes: selectedWasteTypes,
        estimateWeight: weightValue,
        recurring: recurringMonth || recurringWeek || recurringDay,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Pickup scheduled successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to schedule pickup: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Schedule Pickup",
          style: TextStyle(
            color: Color(0xff5DB751),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        // backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/icons/Frame 2.png', height: 80, width: 80),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/icons/Ellipse 12.png'),
            ),
          ),
          SizedBox(width: 30),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 37),
            _buildSectionTitle("Select Date/Time"),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: _buildInputContainer(
                "${selectedDate.toLocal()}".split(' ')[0],
                'assets/icons/Vector(4).png',
              ),
            ),
            SizedBox(height: 15),

            _buildSectionTitle("Select Waste Type"),
            SizedBox(height: 15),
            _buildMultiSelectDropdown(),
            SizedBox(height: 15),

            _buildSectionTitle("Estimate Weight/Volume"),
            SizedBox(height: 15),
            _buildDropdown(
              selectedWeightUnit,
              'assets/icons/Vector(2).png',
              ["(kg)", "1kg", "5kg", "10kg", "(1lbs)", "(2lbs)", "more"],
              (value) {
                setState(() {
                  selectedWeightUnit = value!;
                });
              },
            ),
            SizedBox(height: 20),

            _buildSectionTitle("Recurring Pickup"),
            SizedBox(height: 15),
            _buildSwitch("A Month", recurringMonth, (value) {
              setState(() {
                recurringMonth = value;
              });
            }),
            _buildSwitch("A Week", recurringWeek, (value) {
              setState(() {
                recurringWeek = value;
              });
            }),
            _buildSwitch("A Day", recurringDay, (value) {
              setState(() {
                recurringDay = value;
              });
            }),
            SizedBox(height: 30),

            ElevatedButton(
              onPressed: _schedulePickup,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                "Schedule Pickup",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>PickupScheduleHistory()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                "Schedule Pickup History",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      )
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _buildInputContainer(String text, String imagePath) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontSize: 16, color: Colors.green)),
          Image.asset(imagePath, height: 15, width: 19, fit: BoxFit.cover),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String value,
    String imagePath,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: EdgeInsets.only(right: 15, left: 15),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, height: 15, width: 19, fit: BoxFit.cover),
          SizedBox(width: 10),
          Expanded(
            child: DropdownButton<String>(
              value: value,
              style: TextStyle(color: Colors.green),
              isExpanded: true,
              underline: SizedBox(),
              onChanged: onChanged,
              items:
                  items.map<DropdownMenuItem<String>>((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.green,
    );
  }

  Widget _buildMultiSelectDropdown() {
    return MultiSelectDialogField(
      items: _wasteTypes.map((e) => MultiSelectItem(e, e)).toList(),
      title: Text("Select Waste Types"),
      selectedColor: Colors.green,
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      buttonIcon: Icon(Icons.arrow_drop_down, color: Colors.green),
      buttonText: Text(
        selectedWasteTypes.isEmpty
            ? "Select Waste Types"
            : selectedWasteTypes.join(", "),
        style: TextStyle(color: Colors.green),
      ),
      onConfirm: (results) {
        setState(() {
          selectedWasteTypes = results.cast<String>();
        });
      },
    );
  }
}
