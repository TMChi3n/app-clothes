<<<<<<< HEAD
import 'package:flutter/cupertino.dart';
=======
>>>>>>> main
import 'package:flutter/material.dart';

class Options extends StatelessWidget{
  final String text;
  final IconData icon;
  final Function()? onTap;
<<<<<<< HEAD

  const Options({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap
}) :super(key: key);
=======
  // IconData icon2;
  const Options({
    super.key,
    required this.text,
    required this.icon,
   // required this.icon2,
    this.onTap
});
>>>>>>> main
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ) ,
<<<<<<< HEAD
=======
      iconColor: Colors.blue,
      textColor: Colors.black,
>>>>>>> main
    );
  }
}