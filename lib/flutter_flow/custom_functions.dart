import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

bool checkPhoneNumberFormat(String phoneNumber) {
  // Add your function code here
  if (phoneNumber.length != 13 || !phoneNumber.startsWith('+')) {
    return false;
  } else {
    return true;
  }
}

int calculate(String builtIn) {
  // convert date to age
  final now = DateTime.now();
  final difference = now.difference(DateTime.parse(builtIn));
  final result = difference.inDays / 365.25;
  return result.toInt();
}

LatLng latLngFronJson(dynamic latLngJson) {
  if (latLngJson == null) {
    return null;
  }
  return LatLng(latLngJson['lat'], latLngJson['lng']);
}

LatLng propertyLocation(
  double lat,
  double lng,
) {
  if (lat == 0 && lng == 0) {
    return LatLng(40.8295538, -73.9386429);
  }
  return LatLng(lat, lng);
}

String formatAmount(String amount) {
  var format = NumberFormat('###,###', 'en_US');
  double value = double.parse(amount);
  return format.format(value);
}

double formattedDouble(int maxRange) {
  // Add your function code here!
  double value = maxRange.toDouble();
  return value;
}

String formattedSliderOutput(double rawSliderValue) {
  // Add your function code here!
  double val = double.parse(rawSliderValue.toStringAsFixed(0));
  String amount = val.toString();
  var format = NumberFormat('###,###', 'en_US');
  double value = double.parse(amount);
  return format.format(value);
}

String sliderToApi(double sliderValue) {
  // Add your function code here!
  double val = double.parse(sliderValue.toStringAsFixed(0));
  return val.toString();
}

String searchPagePropertyText(int count) {
  // Add your function code here!
  if (count > 1) {
    return "${count.toString()} properties available";
  } else {
    return "${count.toString()} property available";
  }
}

bool validateInstallmentRange(
  double minIntallmentRange,
  double maxInstallmentRange,
) {
  if (minIntallmentRange < maxInstallmentRange) {
    return true;
  } else {
    return false;
  }
  // Add your function code here!
}

List<String> cityListBuilder(List<String> cityListApiResponse) {
  // Add your function code here!
  var finalList = ["All"];
  finalList.addAll(cityListApiResponse);
  return finalList;
}

List<String> propertTypeBuilder(List<String> propertyTypeApiResponse) {
  // Add your function code here!
  var finalList = ["All"];
  finalList.addAll(propertyTypeApiResponse);
  return finalList;
}

List<String> filteredResultChioceChipsBuilder(
  String filteredCity,
  List<String> filteredPropertyType,
  List<String> filteredFurnishingType,
  String locale,
) {
  var results = [];
  if (locale == "en") {
    if (filteredCity != '') {
      results.add("City: ${filteredCity} ");
    }
    if (filteredPropertyType.length != 0) {
      String properties = filteredPropertyType.join(',');
      results.add("Type: ${properties}");
    }
    if (filteredFurnishingType.length != 0) {
      String furnishing = filteredFurnishingType.join(',');
      results.add("Furnishing: ${furnishing}");
    }
  } else {
    if (filteredCity != '') {
      results.add("المدينة: ${filteredCity} ");
    }
    if (filteredPropertyType.length != 0) {
      String properties = filteredPropertyType.join(',');
      results.add("يكتب: ${properties} ");
    }
    if (filteredFurnishingType.length != 0) {
      String furnishing = filteredFurnishingType.join(',');
      results.add("تأثيث: ${furnishing} ");
    }
  }
  return results;
}
