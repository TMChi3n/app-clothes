import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Options extends StatelessWidget{
  final String text;
  final IconData icon;
  final Function()? onTap;

  const Options({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap
}) :super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ) ,
    );
  }
}