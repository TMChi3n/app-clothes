import 'package:clothes_app/view/widgets/appstyle.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscureText;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function()? onEditComplete;

  const CustomTextField({
    super.key,
    required this.controller,
    this.obscureText,
    required this.hintText,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onEditComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        onEditingComplete: onEditComplete,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefix: prefixIcon,
          suffixIconColor: Colors.black,
          hintStyle: appstyle(13.5, Colors.grey, FontWeight.w600),
          contentPadding: EdgeInsets.zero,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(
              color: Colors.green,
              width: 10,
            ),
          ),
        ),
      ),
    );
  }
}
