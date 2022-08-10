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
  if (phoneNumber.length < 9 || phoneNumber.length > 10) {
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
  if (amount == "null") {
    return '0';
  }
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

int sliderToApi(double sliderValue) {
  // Add your function code here!
  double val = double.parse(sliderValue.toStringAsFixed(0));
  int res = val.toInt();
  return res;
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
  List<String> results = [];
  if (locale == "en") {
    if (filteredCity != '') {
      results.add("City: ${filteredCity} ");
    }
    if (filteredPropertyType.length != 0) {
      String properties = filteredPropertyType.join(', ');
      results.add("Type: ${properties}");
    }
    if (filteredFurnishingType.length != 0) {
      String furnishing = filteredFurnishingType.join(', ');
      results.add("Furnishing: ${furnishing}");
    }
  } else {
    if (filteredCity != '') {
      results.add("المدينة: ${filteredCity} ");
    }
    if (filteredPropertyType.length != 0) {
      String properties = filteredPropertyType.join(', ');
      results.add("يكتب: ${properties} ");
    }
    if (filteredFurnishingType.length != 0) {
      String furnishing = filteredFurnishingType.join(', ');
      results.add("تأثيث: ${furnishing} ");
    }
  }
  return results;
}

String countJsonData(dynamic jsonResponse) {
  var len = jsonResponse.length;
  return len.toString();
  // Add your function code here!
}

String listToApiParameters(List<String> paramList) {
  // Add your function code here!
  var param = paramList.join(',');
  return param;
}

bool propertyTypeCheckHouse(
  String propertyType,
  String locale,
) {
  // Add your function code here!
  if (locale == "en") {
    if (propertyType == "House") {
      return true;
    } else {
      return false;
    }
  } else {
    if (propertyType == "منزل") {
      return true;
    } else {
      return false;
    }
  }
}

bool propertyTypeCheckApartment(
  String propertyType,
  String locale,
) {
  if (locale == "en") {
    if (propertyType == "Apartment") {
      return true;
    } else {
      return false;
    }
  } else {
    if (propertyType == "شقة") {
      return true;
    } else {
      return false;
    }
  }
  // Add your function code here!
}

String noResultsCityName(
  String cityName,
  String locale,
) {
  // Add your function code here!
  if (locale == "en") {
    return "No search results for “${cityName}”. Try a new search";
  } else {
    return "لا توجد نتائج بحث عن “ ${cityName}”. جرب بحث جديد";
  }
}

String getFormattedMobileNumber(String mobileNumber) {
  if (mobileNumber.startsWith('0')) {
    String number = '+966' + mobileNumber.substring(1, (mobileNumber.length));
    return number;
  }
  return '+966' + mobileNumber;
}

bool isSimilarPropertyAvailable(List<dynamic> similarProperties) {
  return similarProperties.isNotEmpty;
}

bool isPropertyAvailable(String currentProprtyStatus) {
  // Add your function code here!
  if (currentProprtyStatus == "Available") {
    return true;
  } else {
    return false;
  }
}

bool queryCollectionHasValue(List<OrdersRecord> queryDocuments) {
  // Add your function code here!
  if (queryDocuments.length != 0) {
    return true;
  } else {
    return false;
  }
}

int orderIdGenerator(int randomNumber) {
  // Add your function code here!
  String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
  int randomNumberLength = randomNumber.toString().length;
  int requiredDigits = 10 - randomNumberLength;
  String generatedId = timeStamp.substring(timeStamp.length - requiredDigits) +
      randomNumber.toString();
  int orderId = int.parse(generatedId);
  return orderId;
}

String formatDateTime(int inputTimeStamp) {
  // Add your function code here!
  DateTime bookingTime =
      DateTime.fromMillisecondsSinceEpoch(inputTimeStamp * 1000);
  String formattedResult =
      '${DateFormat.d().format(bookingTime)} ${DateFormat.MMM().format(bookingTime)} ${DateFormat.y().format(bookingTime)}  ${DateFormat.jm().format(bookingTime)}';
  return formattedResult;
}

String pastOfferScreenDateTime(int inputDateTime) {
  // Add your function code here!
  DateTime offerTime =
      DateTime.fromMillisecondsSinceEpoch(inputDateTime * 1000);
  String formattedResult =
      '${DateFormat.d().format(offerTime).toString().padLeft(2, "0")}/${DateFormat.M().format(offerTime).toString().padLeft(2, "0")}/${DateFormat.y().format(offerTime)} - ${DateFormat.jm().format(offerTime)}';

  return formattedResult;
}

bool pastOfferAcceptedStatusConditionalVisibilty(String offerStatus) {
  // Add your function code here!
  if (offerStatus == 'accepted') {
    return true;
  } else {
    return false;
  }
}

String offerScreenTime(
  int secondsTime,
  String locale,
) {
  DateTime offerTime;
  if (secondsTime.toString().length > 7) {
    offerTime = DateTime.fromMillisecondsSinceEpoch(secondsTime * 1000);
  } else {
    offerTime = DateTime.fromMillisecondsSinceEpoch(secondsTime * 10000000);
  }
  // Add your function code here!
  Duration diff = DateTime.now().difference(offerTime);
  int dayDiffrence = diff.inDays;
  int hrsDiffrence = diff.inHours;
  int minuteDiffrence = diff.inMinutes;
  int secondDiffence = diff.inSeconds;
  if (locale == "en") {
    if (dayDiffrence > 0) {
      return "${dayDiffrence} Days ago";
    } else if (hrsDiffrence > 0) {
      return "${hrsDiffrence} hrs ago";
    } else if (minuteDiffrence > 0) {
      return "${minuteDiffrence} min ago";
    } else {
      return "${secondDiffence} sec ago";
    }
  } else {
    if (dayDiffrence > 0) {
      return "قبل ${dayDiffrence} أيام";
    } else if (hrsDiffrence > 0) {
      return "قبل ${hrsDiffrence} ساعات";
    } else if (minuteDiffrence > 0) {
      return "قبل ${minuteDiffrence} دقائق";
    } else {
      return "قبل ${secondDiffence} ثوان";
    }
  }
}

bool conditionalVisibility(
  String apiResponseState,
  String desiredWidgetState,
) {
  if (apiResponseState == desiredWidgetState) {
    return true;
  } else {
    // Add your function code here!
    return false;
  }
}

List<String> choicechipUnselected(List<String> choicechipValue) {
  // Add your function code here!
  if (choicechipValue.length == 0) {
    return ["All"];
  } else {
    return choicechipValue;
  }
}

String myPropertiesFormatDate(int inputTimeStamp) {
  // Add your function code here!
  DateTime bookingTime;
  if (inputTimeStamp.toString().isEmpty) {
    bookingTime = DateTime.now();
  }
  bookingTime = DateTime.fromMillisecondsSinceEpoch(inputTimeStamp * 1000);
  return '${DateFormat.d().format(bookingTime)} ${DateFormat.MMMM().format(bookingTime)}. ${DateFormat.y().format(bookingTime)}';
}

String offerScreenPropertyIdisNull(String propertyId) {
  // Add your function code here!
  if (propertyId != null && propertyId != "null") {
    return propertyId;
  } else {
    return "";
  }
}

bool myPropertiesViewOffersVisibility(String status) {
  // Add your function code here!
  if (status == "cancelled" ||
      status == "completed" ||
      status == "offer_accepted" ||
      status == "ownership_transferred" ||
      status == "accepted") {
    return true;
  } else {
    return false;
  }
}

bool cancelReverveButtonVisibility(String bookingStatus) {
  // Add your function code here!
  if (bookingStatus == "reserved" ||
      bookingStatus == "collect_offers" ||
      bookingStatus == "waiting_offer_acceptance") {
    return true;
  } else {
    return false;
  }
}

bool orderProcessStatus(
  String apiResponse,
  String processStage,
  String setType,
) {
  switch (apiResponse) {
    case "reserved":
      if ((processStage == "reserved") && setType == "checked") {
        return true;
      } else if ((processStage != "reserved") && setType == "unchecked") {
        return true;
      } else {
        return false;
      }
      // do something
      break;
    case "collect_offers":
      if ((processStage == "reserved" || processStage == "collect_offers") &&
          setType == "checked") {
        return true;
      } else if ((processStage != "reserved" &&
              processStage != "collect_offers") &&
          setType == "unchecked") {
        return true;
      } else {
        return false;
      }
      // do something else
      break;
    case "waiting_offer_acceptance":
      if ((processStage == "reserved" ||
              processStage == "collect_offers" ||
              processStage == "waiting_offer_acceptance") &&
          setType == "checked") {
        return true;
      } else if ((processStage != "reserved" &&
              processStage != "collect_offers" &&
              processStage != "waiting_offer_acceptance") &&
          setType == "unchecked") {
        return true;
      } else {
        return false;
      }
      break;
    case "accepted":
      if ((processStage == "reserved" ||
              processStage == "collect_offers" ||
              processStage == "waiting_offer_acceptance" ||
              processStage == "accepted") &&
          setType == "checked") {
        return true;
      } else if ((processStage != "reserved" &&
              processStage != "collect_offers" &&
              processStage != "waiting_offer_acceptance" &&
              processStage != "accepted") &&
          setType == "unchecked") {
        return true;
      } else {
        return false;
      }
      // do something else
      break;
    case "offer_accepted":
      if ((processStage == "reserved" ||
              processStage == "collect_offers" ||
              processStage == "waiting_offer_acceptance" ||
              processStage == "accepted") &&
          setType == "checked") {
        return true;
      } else if ((processStage != "reserved" &&
              processStage != "collect_offers" &&
              processStage != "waiting_offer_acceptance" &&
              processStage != "accepted") &&
          setType == "unchecked") {
        return true;
      } else {
        return false;
      }
      // do something else
      break;
    case "ownership_transferred":
      if ((processStage == "reserved" ||
              processStage == "collect_offers" ||
              processStage == "waiting_offer_acceptance" ||
              processStage == "accepted" ||
              processStage == "ownership_transferred") &&
          setType == "checked") {
        return true;
      } else if ((processStage != "reserved" &&
              processStage != "collect_offers" &&
              processStage != "waiting_offer_acceptance" &&
              processStage != "accepted" &&
              processStage != "ownership_transferred") &&
          setType == "unchecked") {
        return true;
      } else {
        return false;
      }
      // do something else
      break;
    case "cancelled":
      // do something else
      if (processStage == "cancelled" && setType == "checked") {
        return true;
      } else if (processStage != "cancelled" && setType == "unchecked") {
        return true;
      } else {
        return false;
      }
      break;
    default:
      if (setType == "unchecked") {
        return true;
      } else {
        return false;
      }
      break;
  }
}

bool offerStatusPaymentCompletedCheck(
  String transactionId,
  String status,
) {
  // Add your function code here!
  if ((transactionId != null || transactionId != "null") &&
      (status != "cancelled")) {
    return true;
  } else {
    return false;
  }
}

String myPropertiesBookedStatus(
  String transactionId,
  String status,
) {
  if ((transactionId == null ||
          transactionId.isEmpty ||
          transactionId == "null") &&
      status == "reserved") {
    return "pending_payment";
  } else if ((transactionId != null || transactionId != "null") &&
      status == "reserved") {
    return "reserved";
  } else {
    return status;
  }
  // Add your function code here!
}

int bookinPagePropertyIdToInt(String propertyId) {
  // Add your function code here!
  if (propertyId == "null") {
    return 0;
  }
  int res = int.parse(propertyId);
  return res;
}

bool chatButtonVisibility(String status) {
  // Add your function code here!
  if (status == "new" || status == "accepted") {
    return true;
  } else {
    return false;
  }
}

bool pastOfferColumnVisibility(
  String status,
  String installmentPeriod,
  String installmentRange,
  String agentName,
  String totalPrice,
) {
  if (status == "disqualified") {
    return false;
  }
  if (status == "cancelled") {
    if (installmentPeriod != null ||
        installmentRange != null ||
        agentName != null ||
        totalPrice != null) {
      return true;
    } else {
      return false;
    }
  }
  // Add your function code here!
}
