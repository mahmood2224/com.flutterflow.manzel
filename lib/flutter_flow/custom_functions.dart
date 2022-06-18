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

LatLng getPropertyLocation(LatLng coordinates) {
  if (coordinates.latitude == 0 && coordinates.longitude == 0) {
    return LatLng(21.496661, 39.173354);
  }
  return coordinates;
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
