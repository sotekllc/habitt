import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import 'package:habitt/theme.dart';

Widget buildInputField(
  TextEditingController controller,
  String hint,
  IconData icon,
  ThemeData theme,
) {
  return Container(
    decoration: formFieldDecoration,
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: theme.primaryColorDark),
        hintText: hint,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
      ),
      style: TextStyle(color: Colors.black),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
    ),
  );
}

void showToast(FToast fToast, String text, Color color) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: color,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [Icon(Icons.check), SizedBox(width: 12.0), Text(text)],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );
}
