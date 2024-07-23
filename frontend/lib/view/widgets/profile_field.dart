import 'package:flutter/material.dart';
import 'package:clothes_app/view/widgets/appstyle.dart';

class ProfileField extends StatelessWidget {
  final String? value;
  final IconData icon;
  const ProfileField({
    super.key,
    required this.icon,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
           BoxShadow(
             color: Colors.grey.withOpacity(0.5),
             spreadRadius: 2,
             blurRadius: 3,
             offset: const Offset(0, 3),
           ),
        ],
      ),
      child: Row(
             children: [
               Icon(icon, size: 21,color: Colors.blue,),
               const SizedBox(width: 10,),
               Text(value!,style: appstyle(13.5,Colors.black,FontWeight.normal),
               ),

             ],
      ),
    );
  }
}
