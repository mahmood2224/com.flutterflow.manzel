// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '../../flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';

// Begin custom action code
Future<String> formatCurrency(String amount) async {
  final _currencyFormat = NumberFormat.simpleCurrency(
    decimalDigits: 0,
  );
  if (amount.trim().isEmpty ?? true) {
    return '';
  }
  String price = _currencyFormat.format(amount);
  if (price.isNotEmpty) {
    return price.substring(1);
  } else {
    return '';
  }
}
