import 'package:flutter/material.dart';

SnackBar errorSnackbar({required String errorText}) {
  return SnackBar(
    content: Text(
      errorText,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.redAccent,
  );
}
