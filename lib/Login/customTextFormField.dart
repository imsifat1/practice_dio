import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String HintText;
  bool ObscureText = false;
  var textController = TextEditingController();
  IconData icon;

  MyTextFormField({
    required this.HintText,
    required this.ObscureText,
    required this.icon,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(35, 20, 35, 0),
      child: TextFormField(
        controller: textController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This Field is Required';
          }
          return null;
        },
        obscureText: ObscureText,
        decoration: InputDecoration(
            //labelText: '${HintText}',

            hintText: HintText,
            prefixIcon: Icon(icon),
            labelStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            )),
      ),
    );
  }
}
