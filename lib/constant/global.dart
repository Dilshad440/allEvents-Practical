import 'package:flutter/material.dart';

extension GetInitial on String {
  String get getInitialCaps => trim()[0].toUpperCase();

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

enum ApiState { idle, loading, loaded, error }

Color getColor(bool item) => item == true ? Colors.red : Colors.black;
