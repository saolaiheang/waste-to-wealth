import 'package:flutter/material.dart';

class SchedulePickupScreen extends StatefulWidget {
  @override
  _SchedulePickupScreenState createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends State<SchedulePickupScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedWasteType = "Paper";
  String selectedWeightUnit = "(kg)";
  bool recurringMonth = false;
  bool recurringWeek = false;
  bool recurringDay = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: Color(0xffFF972F), // Header color
              onPrimary: Colors.white, // Header text color
              surface: Color(0XFF6C9182), // Dialog background color
              onSurface: const Color.fromARGB(
                255,
                254,
                254,
                254,
              ), // Default text color
            ),
            // dialogTheme: DialogTheme(
            //   backgroundColor: Color(0xff012788), // Background color
            // ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Schedule Pickup",
          style: TextStyle(
            color: Color(0xff5DB751),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,

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
          SizedBox(width: 40),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Select Date/Time"),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: _buildInputContainer(
                "${selectedDate.toLocal()}".split(' ')[0],
                'assets/icons/Vector(4).png', // Replace icon with image
              ),
            ),
            SizedBox(height: 15),

            _buildSectionTitle("Select Waste Type"),
            _buildDropdown(
              selectedWasteType,
              'assets/icons/Vector(3).png',
              ["Paper", "Plastic", "Metal", "Glass"],
              (value) {
                setState(() {
                  selectedWasteType = value!;
                });
              },
            ),
            SizedBox(height: 15),

            _buildSectionTitle("Estimate Weight/Volume"),
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                "Schedule Pickup",
                style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 26),

            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                "Schedule Pickup History",
                style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
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
}
