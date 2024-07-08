import 'package:flutter/material.dart';

class BottomNaviWidget extends StatelessWidget {
  const BottomNaviWidget({
    super.key,
    this.onTap,
    this.icon,
  });

  final void Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 37,
          child: Icon(
            icon,
            color: Colors.blue,
            size: 25, // Adjust icon size if needed
          ),
        ),
      ),
    );
  }
}
