import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final String text;
  final bool isSelected;

  const CustomTab({
    super.key,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade300 : Colors.white, // Màu nền khi được chọn
        borderRadius: BorderRadius.circular(25), // Viền cong
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300, // Viền màu khi được chọn
          width: 2.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18.5),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black, // Màu chữ khi được chọn
        ),
      ),
    );
  }
}
