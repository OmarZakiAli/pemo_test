import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration defaultDecoration({
    required String label,
    String? hintText,
  }) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(),
      labelText: label,
      hintText: hintText,
    );
  }
}
