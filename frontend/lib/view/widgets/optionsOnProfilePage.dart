import 'package:flutter/material.dart';

class Options extends StatelessWidget{
  final String text;
  final IconData icon;
  final Function()? onTap;
  // IconData icon2;
  const Options({
    super.key,
    required this.text,
    required this.icon,
   // required this.icon2,
    this.onTap
});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ) ,
      iconColor: Colors.blue,
      textColor: Colors.black,
    );
  }
}