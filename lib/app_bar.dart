import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onHistoryPressed;

  const CustomAppBar({super.key, required this.onHistoryPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 113, 6, 184),
      elevation: 0,
      title: Container(
        height: 60.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: const Center(
          child: Text(
            'Blood Pressure Tracker',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22.0,
            ),
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        Center(
          child: IconButton(
            icon: const Icon(
              Icons.history,
              color: Colors.white,
            ),
            onPressed: onHistoryPressed,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
