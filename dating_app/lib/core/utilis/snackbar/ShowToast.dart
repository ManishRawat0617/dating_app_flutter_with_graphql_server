import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ShowToast {
  static void display({
    required String message,
    Color backgroundColor = Colors.red,
    Color textColor = Colors.white,
    ToastGravity gravity = ToastGravity.TOP,
    Toast toastLength = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}
