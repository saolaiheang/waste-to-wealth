import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
      final VoidCallback? onBackPress;

  const HeaderBar({super.key,
  required this.title,
      this.onBackPress,
  });

  @override
  Widget build(BuildContext context) {
return AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xff5DB751),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Image.asset('assets/icons/Frame 2.png', height: 50, width: 50),
          onPressed: onBackPress ?? () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/icons/Vector(10).png'),
            ),
          ),
        ],
      );
     }


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}