import 'package:flutter/material.dart';

class SnackbarStyle {
  static SnackBar snackStyle(String message) {
    return SnackBar(
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      backgroundColor: Color(0xFF3B3B3B),
      behavior: SnackBarBehavior.floating,
    );
  }
}
