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
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 36,
        width: 39,
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}
