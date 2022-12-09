import 'dart:convert';
import 'dart:math' as math;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'flutter_flow_util.dart';
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart' as sendbird;

//   Future<String> unreadMessage(channelUrl)  async {
//
//    return getUnreadMessage(channelUrl).toString();
// }
Future<String?> getUnreadMessage(String channelUrl) async {
  try {
    String channel_url = channelUrl.toString();
    final aChannel = await GroupChannel.getChannel(channel_url);
    print(aChannel.unreadMessageCount);
    var channel = aChannel.unreadMessageCount.toString();
    return channel;

// print("unread Messages ${unreadMessage}");
//   return   unreadMessage.toString();

  } catch (error) {
    print("*********************************************************");
    print(error);
    print("*********************************************************");
  }
}

bool checkPhoneNumberFormat(String? phoneNumber) {
  // Add your function code here
  if (phoneNumber!.length < 9 || phoneNumber.length > 10) {
    return false;
  } else {
    return true;
  }
}

int calculate(String? builtIn) {
  // convert date to age
  final now = DateTime.now();
  final difference = now.difference(DateTime.parse(builtIn!));
  final result = difference.inDays / 365.25;
  return result.toInt();
}

LatLng latLngFronJson(dynamic latLngJson) {
  if (latLngJson == null) {
    return latLngJson;
  }
  return LatLng(latLngJson['lat'], latLngJson['lng']);
}

LatLng propertyLocation(
  double? lat,
  double? lng,
) {
  if (lat == 0 && lng == 0) {
    return LatLng(40.8295538, -73.9386429);
  }
  return LatLng(lat ?? 40.8295538, lng ?? -73.9386429);
}

String formatAmount(String? amount) {
  if (amount == "null") {
    return '0';
  }
  var format = NumberFormat('###,###', 'en_US');
  double value = double.parse(amount!);
  return format.format(value) + ".00";
}

double formattedDouble(int? maxRange) {
  // Add your function code here!
  double value = maxRange!.toDouble();
  return value;
}

String formattedSliderOutput(double? rawSliderValue) {
  // Add your function code here!
  double val = double.parse(rawSliderValue!.toStringAsFixed(0));
  String amount = val.toString();
  var format = NumberFormat('###,###', 'en_US');
  double value = double.parse(amount);
  return format.format(value);
}

int sliderToApi(double? sliderValue) {
  // Add your function code here!
  double val = double.parse(sliderValue!.toStringAsFixed(0));
  int res = val.toInt();
  return res;
}

String searchPagePropertyText(int? count) {
  // Add your function code here!
  if (count! > 1) {
    return "${count.toString()} properties available";
  } else {
    return "${count.toString()} property available";
  }
}

bool validateInstallmentRange(
  double? minIntallmentRange,
  double? maxInstallmentRange,
) {
  if (minIntallmentRange! < maxInstallmentRange!) {
    return true;
  } else {
    return false;
  }
  // Add your function code here!
}

List<String> cityListBuilder(
  List<String>? cityListApiResponse,
  String? locale,
) {
  // Add your function code here!
  if (locale == "en") {
    var finalList = ["All"];
    finalList.addAll(cityListApiResponse!);
    return finalList;
  } else {
    var finalList = ["الكل"];
    finalList.addAll(cityListApiResponse!);
    return finalList;
  }
}

List<String> propertTypeBuilder(
  List<String>? propertyTypeApiResponse,
  String? locale,
) {
  // Add your function code here!
  if (locale == "en") {
    var finalList = ["All"];
    finalList.addAll(propertyTypeApiResponse!);
    return finalList;
  } else {
    var finalList = ["الكل"];
    finalList.addAll(propertyTypeApiResponse!);
    return finalList;
  }
}

List<String> filteredResultChioceChipsBuilder(
  String? filteredCity,
  String? filteredPropertyType,
  String? filteredFurnishingType,
  String? locale,
) {
  List<String> results = [];
  if (locale == "en") {
    if (filteredCity != '') {
      results.add("City: ${filteredCity} ");
    }
    if (filteredPropertyType!.length != 0) {
      results.add("Type: ${filteredPropertyType}");
    }
    if (filteredFurnishingType!.length != 0) {
      results.add("Furnishing: ${filteredFurnishingType}");
    }
  } else {
    if (filteredCity != '') {
      results.add("المدينة: ${filteredCity} ");
    }
    if (filteredPropertyType!.length != 0) {
      results.add("النوع: ${filteredPropertyType} ");
    }
    if (filteredFurnishingType!.length != 0) {
      results.add("التأثيث: ${filteredFurnishingType} ");
    }
  }
  return results;
}

String countJsonData(dynamic jsonResponse) {
  var len = jsonResponse.length;
  return len.toString();
  // Add your function code here!
}

String listToApiParameters(List<String>? paramList) {
  // Add your function code here!
  var param = paramList!.join(',');
  return param;
}

bool propertyTypeCheckHouse(
  String? propertyType,
  String? locale,
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
  String? propertyType,
  String? locale,
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
  String? cityName,
  String? locale,
) {
  // Add your function code here!
  if (locale == "en") {
    return "No search results for “${cityName}”. Try a new search";
  } else {
    return "لا توجد نتائج بحث عن “ ${cityName}”. جرب بحث جديد";
  }
}

String getFormattedMobileNumber(String? mobileNumber) {
  if (mobileNumber!.startsWith('0')) {
    String number = '+966' + mobileNumber.substring(1, (mobileNumber.length));
    return number;
  }
  return '+966' + mobileNumber;
}

bool isSimilarPropertyAvailable(List<dynamic> similarProperties) {
  return similarProperties.isNotEmpty;
}

bool isPropertyAvailable(String? currentProprtyStatus) {
  // Add your function code here!
  if (currentProprtyStatus == "Available") {
    return true;
  } else {
    return false;
  }
}

bool queryCollectionHasValue(List<OrdersRecord>? queryDocuments) {
  // Add your function code here!
  if (queryDocuments!.length != 0) {
    return true;
  } else {
    return false;
  }
}

int orderIdGenerator(int? randomNumber) {
  // Add your function code here!
  String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
  int randomNumberLength = randomNumber.toString().length;
  int requiredDigits = 10 - randomNumberLength;
  String generatedId = timeStamp.substring(timeStamp.length - requiredDigits) +
      randomNumber.toString();
  int orderId = int.parse(generatedId);
  return orderId;
}

String formatDateTime(
  int? inputTimeStamp,
  String? locale,
) {
  // Add your function code here!
  if (locale == "en") {
    DateTime bookingTime =
        DateTime.fromMillisecondsSinceEpoch(inputTimeStamp! * 1000);
    String formattedResult =
        '${DateFormat.d().format(bookingTime)} ${DateFormat.MMM().format(bookingTime)} ${DateFormat.y().format(bookingTime)}  ${DateFormat.jm().format(bookingTime)}';
    return formattedResult;
  } else {
    DateTime bookingTime =
        DateTime.fromMillisecondsSinceEpoch(inputTimeStamp! * 1000);
    String formattedResult =
        '${DateFormat.d("ar_SA").format(bookingTime)} ${DateFormat.MMM("ar_SA").format(bookingTime)} ${DateFormat.y("ar_SA").format(bookingTime)}  ${DateFormat.jm("ar_SA").format(bookingTime)}';
    return formattedResult;
  }
}

String pastOfferScreenDateTime(int? inputDateTime) {
  // Add your function code here!
  DateTime offerTime =
      DateTime.fromMillisecondsSinceEpoch(inputDateTime! * 1000);
  String formattedResult =
      '${DateFormat.d().format(offerTime).toString().padLeft(2, "0")}/${DateFormat.M().format(offerTime).toString().padLeft(2, "0")}/${DateFormat.y().format(offerTime)} - ${DateFormat.jm().format(offerTime)}';

  return formattedResult;
}

bool pastOfferAcceptedStatusConditionalVisibilty(String? offerStatus) {
  // Add your function code here!
  if (offerStatus == 'accepted') {
    return true;
  } else {
    return false;
  }
}

String offerScreenTime(
  int? secondsTime,
  String? locale,
) {
  DateTime offerTime;
  if (secondsTime.toString().length > 7) {
    offerTime = DateTime.fromMillisecondsSinceEpoch(secondsTime! * 1000);
  } else {
    offerTime = DateTime.fromMillisecondsSinceEpoch(secondsTime! * 10000000);
  }
  // Add your function code here!
  Duration diff = DateTime.now().difference(offerTime);
  //int monthDiffrence = diff.i;
  int yearsAgo;
  int monthsAgo;
  int dayDiffrence = diff.inDays;
  int hrsDiffrence = diff.inHours;
  int minuteDiffrence = diff.inMinutes;
  int secondDiffence = diff.inSeconds;
  if (locale == "en") {
    if (dayDiffrence > 0) {
      if ((dayDiffrence >= 365) && ((dayDiffrence % 365) > 0)) {
        yearsAgo = dayDiffrence % 365;
        return "${yearsAgo} Years ago";
      }
      if ((dayDiffrence > 30) && ((dayDiffrence % 30) > 0)) {
        monthsAgo = dayDiffrence % 30;
        return "${monthsAgo} Months ago";
      }
      return "${dayDiffrence} Days ago";
    }
    else if (hrsDiffrence > 0) {
      if (hrsDiffrence == 1) {
        return '1 hr ago';
      }
      return "${hrsDiffrence} hrs ago";
    }
    else if (minuteDiffrence > 0) {
      return "${minuteDiffrence} min ago";
    }
    else {
      return "${secondDiffence} sec ago";
    }
  } else {
    //in arabic
    if (dayDiffrence > 0) {
      if ((dayDiffrence >= 365) && ((dayDiffrence % 365) > 0)) {
        yearsAgo = dayDiffrence % 365;
        if (yearsAgo == 1) {
          return "قبل سنة";
        }
        if (yearsAgo == 2) {
          return "قبل سنتين";
        }
        if (yearsAgo >= 3 && yearsAgo <= 10) {
          return "منذ ${yearsAgo} سنوات";
        }
        else {
          return "قبل ${yearsAgo} سنة";
        }
      }
      if ((dayDiffrence > 30) && ((dayDiffrence % 30) > 0)) {
        monthsAgo = dayDiffrence % 30;
        if (monthsAgo == 1) {
          return "منذ شهر";
        }
        if (monthsAgo == 2) {
          return "منذ شهرين";
        }
        if (monthsAgo >= 3 && monthsAgo <= 10) {
          return "منذ ${monthsAgo} أشهر";
        } else {
          return "قبل ${monthsAgo} شهر";
        }
      }
      if (dayDiffrence == 1) {
        return "قبل يوم";
      }
      if (dayDiffrence == 2) {
        return "منذ يومين";
      }
      if (dayDiffrence >= 3 && dayDiffrence <= 10) {
        return "منذ ${dayDiffrence} أيام";
      }
      else {
        return "منذ ${dayDiffrence} يوم";
      }
    }
    else if (hrsDiffrence > 0) {
      if (hrsDiffrence == 1) {
        return "قبل ساعة";
      }
      if (hrsDiffrence == 2) {
        return "قبل ساعتين";
      }
      if (hrsDiffrence >= 3 && hrsDiffrence <= 10) {
        return "منذ ${hrsDiffrence} ساعات";
      } else {
        return "منذ ${hrsDiffrence} ساعة";
      }
    }
    else if (minuteDiffrence > 0) {
      if (minuteDiffrence == 1) {
        return "قبل دقيقة";
      }
      if (minuteDiffrence == 2) {
        return "قبل دقيقتين";
      }
      if (minuteDiffrence >= 3 && minuteDiffrence <= 10) {
        return "منذ ${minuteDiffrence} دقائق";
      } else {
        return "منذ ${minuteDiffrence} دقيقة";
      }
    }
    else {
      return "منذ ${secondDiffence} ثانية";
    }
  }
}

bool conditionalVisibility(
  String? apiResponseState,
  String? desiredWidgetState,
) {
  if (apiResponseState == desiredWidgetState) {
    return true;
  } else {
    // Add your function code here!
    return false;
  }
}

List<String> choicechipUnselected(
  List<String>? choicechipValue,
  String? locale,
) {
  // Add your function code here!
  if (choicechipValue!.length == 0) {
    if (locale == "en") {
      return ["All"];
    } else {
      return ["الكل"];
    }
  } else {
    return choicechipValue;
  }
}

String myPropertiesFormatDate(
  int? inputTimeStamp,
  String? locale,
) {
  String today = "اليوم";
  // Add your function code here!
  DateTime bookingTime;
  if (inputTimeStamp.toString().isEmpty) {
    bookingTime = DateTime.now();
  }
  if (locale == "en") {
    bookingTime = DateTime.fromMillisecondsSinceEpoch(inputTimeStamp! * 1000);
    return '${DateFormat.d().format(bookingTime)} ${DateFormat.MMMM().format(bookingTime).substring(0,3)} ${DateFormat.y().format(bookingTime)}';
  } else {
    bookingTime = DateTime.fromMillisecondsSinceEpoch(inputTimeStamp! * 1000);
    return '${DateFormat.d("ar_SA").format(bookingTime)} ${DateFormat.MMMM("ar_SA").format(bookingTime)}. ${DateFormat.y("ar_SA").format(bookingTime)}';
  }
}

String offerScreenPropertyIdisNull(String? propertyId) {
  // Add your function code here!
  if (propertyId != null && propertyId != "null") {
    return propertyId;
  } else {
    return "";
  }
}

bool myPropertiesViewOffersVisibility(String? status) {
  // Add your function code here!
  if (status == "cancelled" ||
      status == "completed" ||
      status == "offer_accepted" ||
      status == "ownership_transferred" ||
      status == "expired" ||
      status == "accepted") {
    return true;
  } else {
    return false;
  }
}

bool cancelReverveButtonVisibility(String? bookingStatus) {
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
  String? apiResponse,
  String? processStage,
  String? setType,
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
      if ((processStage == "reserved") && setType == "checked") {
        return true;
      } else if ((processStage == "collect_offers") && setType == "pending") {
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
      if ((processStage == "reserved" || processStage == "collect_offers") &&
          setType == "checked") {
        return true;
      } else if ((processStage == "waiting_offer_acceptance") &&
          setType == "pending") {
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
              processStage == "waiting_offer_acceptance") &&
          setType == "checked") {
        return true;
      } else if ((processStage == "accepted") && setType == "pending") {
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
              processStage == "waiting_offer_acceptance") &&
          setType == "checked") {
        return true;
      } else if ((processStage == "offer_accepted") && setType == "pending") {
        return true;
      } else if ((processStage != "reserved" &&
              processStage != "offer_accepted" &&
              processStage != "collect_offers" &&
              processStage != "waiting_offer_acceptance") &&
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
              processStage == "offer_accepted" ||
              processStage == "completed" ||
              processStage == "ownership_transferred") &&
          setType == "checked") {
        return true;
      } else if ((processStage != "reserved" &&
              processStage != "collect_offers" &&
              processStage != "waiting_offer_acceptance" &&
              processStage != "offer_accepted" &&
              processStage != "ownership_transferred" &&
              processStage != "completed") &&
          setType == "unchecked") {
        return true;
      } else {
        return false;
      }
      // do something else
      break;
    case "completed":
      if ((processStage == "reserved" ||
              processStage == "collect_offers" ||
              processStage == "waiting_offer_acceptance" ||
              processStage == "offer_accepted" ||
              processStage == "completed" ||
              processStage == "ownership_transferred") &&
          setType == "checked") {
        return true;
      } else if ((processStage != "reserved" &&
              processStage != "collect_offers" &&
              processStage != "waiting_offer_acceptance" &&
              processStage != "offer_accepted" &&
              processStage != "ownership_transferred" &&
              processStage != "completed") &&
          setType == "unchecked") {
        return true;
      } else {
        return false;
      }
      // do something else
      break;
    case "cancelled":
      // do something else
      if ((processStage == "reserved" ||
              processStage == "collect_offers" ||
              processStage == "cancelled") &&
          setType == "checked") {
        return true;
      } else if ((processStage != "reserved" &&
              processStage != "collect_offers" &&
              processStage != "cancelled") &&
          setType == "unchecked") {
        return true;
      } else {
        return false;
      }
      break;
    case "disqualified":
      // do something else
      if ((processStage == "reserved" ||
              processStage == "collect_offers" ||
              processStage == "disqualified") &&
          setType == "checked") {
        return true;
      } else if ((processStage != "reserved" &&
              processStage != "collect_offers" &&
              processStage != "disqualified") &&
          setType == "unchecked") {
        return true;
      } else {
        return false;
      }
      break;
    case "expired":
      // do something else
      if ((processStage == "reserved" || processStage == "expired") &&
          setType == "checked") {
        return true;
      } else if ((processStage != "reserved" && processStage != "expired") &&
          setType == "unchecked") {
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
  String? transactionId,
  String? status,
) {
  // Add your function code here!
  if (transactionId != null && transactionId != "null") {
    return true;
  } else {
    return false;
  }
}

String myPropertiesBookedStatus(
  String? transactionId,
  String? status,
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
    return status!;
  }
  // Add your function code here!
}

int bookinPagePropertyIdToInt(String? propertyId) {
  // Add your function code here!
  if (propertyId == "null") {
    return 0;
  }
  int res = int.parse(propertyId!);
  return res;
}

bool chatButtonVisibility(String? status) {
  // Add your function code here!
  if (status == "new") {
    return true;
  } else {
    return false;
  }
}

bool pastOfferColumnVisibility(
  String? status,
  String? installmentPeriod,
  String? installmentRange,
  String? agentName,
  String? totalPrice,
) {
  if (status == "disqualified") {
    return false;
  }
  if (status == "cancelled") {
    if (((installmentPeriod != null && installmentPeriod.isNotEmpty) &&
            (installmentRange != null && installmentRange.isNotEmpty) &&
            (totalPrice != null && totalPrice.isNotEmpty)) &&
        (agentName != null && agentName.isNotEmpty)) {
      return true;
    } else {
      return false;
    }
  }
  if (status == "rejected") {
    if (((installmentPeriod != null && installmentPeriod.isNotEmpty) &&
            (installmentRange != null && installmentRange.isNotEmpty) &&
            (totalPrice != null && totalPrice.isNotEmpty)) &&
        (agentName != null && agentName.isNotEmpty)) {
      return true;
    } else {
      return false;
    }
  }
  return true;
  // Add your function code here!
}

String bookingScreenCountOffers(List<dynamic> bankIds) {
  return bankIds.length.toString();
  // Add your function code here!
}

bool offerScreenConitionalVisibilty(
  bool? isLoggedIn,
  String? status,
) {
  if (isLoggedIn!) {
    if (status == "Active") {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
  // Add your function code here!
}

bool bookingDeatilsViewOfferVisibilty(
  String? status,
  String? bankIdCount,
) {
  int count;
  if (bankIdCount != null || bankIdCount != "null") {
    count = int.parse(bankIdCount!);
  } else {
    count = 0;
  }
  if ((status == "waiting_offer_acceptance" || status == "collect_offers") &
      (count > 1)) {
    return true;
  } else {
    return false;
  }
  // Add your function code here!
}

String notificationsDateTime(
  String? locale,
  DateTime? timestamp,
) {
  if (locale == "en") {
    if ((DateFormat.yMd().format(timestamp??DateTime.now())) ==
        (DateFormat.yMd().format(DateTime.now()))) {
      return "Today";
    } else if ((DateFormat.yMd().format(timestamp??DateTime.now())) ==
        (DateFormat.yMd().format(DateTime.now()))) {
      return "Yesterday";
    } else {
      String result = DateFormat.d().format(timestamp??DateTime.now()) +
          " " +
          DateFormat.MMM().format(timestamp??DateTime.now()) +
          " " +
          DateFormat.y().format(timestamp??DateTime.now());
      return result;
    }
  } else {
    if ((DateFormat.yMd().format(timestamp!)) ==
        (DateFormat.yMd().format(DateTime.now()))) {
      return "اليوم";
    } else if ((DateFormat.yMd().format(timestamp)) ==
        (DateFormat.yMd().format(DateTime.now()))) {
      return "امس";
    } else {
      String result = DateFormat.d("ar_SA").format(timestamp) +
          " " +
          DateFormat.MMM("ar_SA").format(timestamp) +
          "" +
          DateFormat.y("ar_SA").format(timestamp);
      return result;
    }
  }
}

String notificationBadgeCount(List<NotificationsRecord>? unreadNotifications) {
  // Add your function code here!
  if (unreadNotifications!.isEmpty) {
    return '0';
  }
  String count = unreadNotifications.length.toString();
  return count;
}

String emptyListWidgetTitle(
  String? screenName,
  String? locale,
) {
  switch (screenName) {
    case "homeScreen":
      {
        // statements;
        if (locale == "en") {
          return "No properties avaiable";
        } else {
          return "لا توجد عقارات متاحة";
        }
      }
      break;

    case "notifications":
      {
        if (locale == "en") {
          return "No notifications yet";
        } else {
          return "لا توجد إشعارات حتى الآن";
        }
      }
      break;
    case "cityList":
      {
        if (locale == "en") {
          return "No cities yet";
        } else {
          return "لا توجد مدن متاحة حتى الان";
        }
      }
      break;
    case "pastOffers":
      {
        if (locale == "en") {
          return "No past offers yet";
        } else {
          return "لا توجد عروض سابقة حتى الآن";
        }
      }
      break;
    case "filterResult":
      {
        if (locale == "en") {
          return "No result found";
        } else {
          return "لم يتم العثور على نتائج";
        }
      }
      break;
    case "offers":
      {
        if (locale == "en") {
          return "No offers added yet";
        } else {
          return "لم تتم إضافة أي عروض حتى الآن";
        }
      }
      break;
    case "bookedProperties":
      {
        if (locale == "en") {
          return "No properties booked yet";
        } else {
          return "لا توجد عقارات محجوزة حتى الآن";
        }
      }
      break;
    case "favorite":
      {
        if (locale == "en") {
          return "No properties favorite yet";
        } else {
          return "لا توجد عقارات مفضلة حتى الآن";
        }
      }
      break;

    default:
      {
        if (locale == "en") {
          return "Unable to fetch data";
        } else {
          return "تعذر جلب البيانات";
        }
      }
      break;
  }

  // Add your function code here!
}

String snackBarMessage(
  String? messageType,
  String? locale,
) {
  switch (messageType) {
    case "error":
      {
        if (locale == "en") {
          return "Some error has occurred. Please try again later.";
        } else {
          return "حدث خطأ ما. الرجاء المحاولة مرة أخرى في وقت لاحق.";
        }
      }
      break;
    case "bookmarkRemoved":
      {
        if (locale == "en") {
          return "The property has been successfully removed from the bookmark.";
        } else {
          return "تم الإزالة من المفضلة بنجاح";
        }
      }
      break;
    case "invalidInstallmentRange":
      {
        if (locale == "en") {
          return "Please select valid instalment range.";
        } else {
          return "الرجاء تحديد نطاق أقساط صحيح";
        }
      }
      break;
    case "offerAccepted":
      {
        if (locale == "en") {
          return "Offer accepted.";
        } else {
          return "تم قبول العرض";
        }
      }
      break;
    case "reservationConfirmed":
      {
        if (locale == "en") {
          return "This property is already booked.";
        } else {
          return "هذا العقار محجوز بالفعل";
        }
      }
      break;
    case "depositReceipt":
      {
        if (locale == "en") {
          return "We are working on generating your transaction receipt . Please wait for few moments .";
        } else {
          return "نحن نعمل على إصدار إيصال معاملتك. من فضلك انتظر لحظات قليلة.";
        }
      }
      break;
    default:
      {
        {
          if (locale == "en") {
            return "Some error has occurred. Please try again later.";
          } else {
            return "حدث خطأ ما. الرجاء المحاولة مرة أخرى في وقت لاحق.";
          }
        }
      }
      break;
  }
}

String subTitleText(
  String? locale,
  String? screenName,
) {
  switch (screenName) {
    case "bookedProperties":
      {
        if (locale == "en") {
          return " ";
        } else {
          return " ";
        }
      }
      break;
    case "favorite":
      {
        if (locale == "en") {
          return " ";
        } else {
          return " ";
        }
      }
      break;
    default:
      {
        {
          if (locale == "en") {
            return "No Results to show.";
          } else {
            return "لا توجد نتائج للعرض.";
          }
        }
      }
      break;
  }
}

String formatAmountWithoutDecimal(String? amount) {
  // Add your function code here!
  if (amount == "null") {
    return '0';
  }
  var format = NumberFormat('###,###', 'en_US');
  double value = double.parse(amount!);
  return format.format(value);
}

bool bookingDetailsOrderStatusConditionlVisibilty(
  String? orderStatus,
  String? statusText,
) {
  switch (orderStatus) {
    case "cancelled":
      {
        if (statusText != "reserved" &&
            statusText != "collect_offers" &&
            statusText != "payment_confirmed") {
          return false;
        } else {
          return true;
        }
      }
      break;
    case "disqualified":
      {
        if (statusText != "reserved" && statusText != "payment_confirmed") {
          return false;
        } else {
          return true;
        }
      }
      break;
    case "expired":
      {
        if (statusText != "reserved") {
          return false;
        } else {
          return true;
        }
      }
      break;

    default:
      {
        return true;
      }
      break;
  }
}

bool notificationConditionalVisibilty(
  String? appLocale,
  int? isRead,
  String? textLang,
  int? textWeight,
) {
  if ((appLocale == textLang) && (isRead == textWeight)) {
    return true;
  } else {
    return false;
  }
  // Add your function code here!
}

bool videoPlayerVisibilty(String? videoURL) {
  // Add your function code here!
  if (videoURL?.isNotEmpty ?? false) {
    return true;
  } else {
    return false;
  }
}

bool requestButtonVisibilty(String? pincode) {
  if ((pincode != null) && ((pincode).isNotEmpty)) {
    return false;
  } else {
    return true;
  }
}

bool propertyStatusConditionalVisibilty(String? propertyStatus) {
  // Add your function code here!
  if (propertyStatus == "Available") {
    return true;
  } else {
    return false;
  }
}

String orderIdFormatter(String? orderId) {
  // Add your function code here!
  return '#${orderId}';
}

bool profileCompletetionCheck(
  String? email,
  String? name,
  String? bank,
  String? employment,
  String? income,
  String? loanCoverage,
) {
  // Add your function code here!
  if ((email != null && email.isNotEmpty) &&
      (name != null && name.isNotEmpty) &&
      (bank != null && bank.isNotEmpty) &&
      (employment != null && employment.isNotEmpty) &&
      (income != null && income.isNotEmpty) &&
      (loanCoverage != null && loanCoverage.isNotEmpty)) {
    return true;
  } else {
    return false;
  }
}

bool sakaniLoan(String? chioceChipValue) {
  // Add your function code here!
  if (chioceChipValue == 'Yes' || chioceChipValue == 'نعم') {
    return true;
  } else {
    return false;
  }
}

String sakaniLoanInitialValue(
  bool? loanCoverage,
  String? locale,
) {
  // Add your function code here!
  if (locale == 'en') {
    if (loanCoverage == true) {
      return 'Yes';
    } else {
      return 'No';
    }
  } else {
    if (loanCoverage == true) {
      return 'نعم';
    } else {
      return 'رقم';
    }
  }
}

//updated code
String? editProfileDropDownInitalVal(
  List optionsList,
  String? id,
) {
  if (optionsList != null) {
    if (optionsList[0]["attributes"].containsKey('bank_name')) {
      if (id != null && id.isNotEmpty) {
        for (var element in optionsList) {
          if (element['id'].toString() == id)
            return element['attributes']['bank_name'].toString();
        }
      }
      return null;
    } else {
      if (id != null && id.isNotEmpty) {
        for (var element in optionsList) {
          if (element['id'].toString() == id)
            return element['attributes']['Name'].toString();
        }
      }
      return null;
    }
  } else
    return null;
}

//updated code
String? editProfileindexReturn(
  List optionsArray,
  String? selectedItem,
) {
  if (optionsArray != null) {
    if (optionsArray[0]["attributes"].containsKey('bank_name')) {
      if (selectedItem != null && selectedItem.isNotEmpty) {
        for (var element in optionsArray) {
          if (element["attributes"]["bank_name"] == selectedItem)
            return element["id"].toString();
        }
        return null;
      }
      return null;
    } else {
      if (selectedItem != null && selectedItem.isNotEmpty) {
        for (var element in optionsArray) {
          if (element['attributes']['Name'] == selectedItem)
            return element["id"].toString();
        }
      }
      return null;
    }
  } else
    return null;
}

String? monthlyIncome(
  String? functionType,
  String? intialValue,
  String? locale,
) {
  // Add your function code here!
  List<String> incomeEN = [
    '4,000 - 20,000 SAR',
    '21,000 - 50,000 SAR',
    '51,000 - 100,000+ SAR'
  ];
  List<String> incomeAR = [
    '4,000 - 20,000 ريال سعودي',
    '21,000 - 50,000 ريال سعودي',
    '51,000 - 100,000+ ريال سعودي'
  ];
  if (locale == 'en') {
    if (functionType == 'initialValue') {
      if (intialValue == "") intialValue = '-1';
      int ind = int.parse(intialValue!);
      if (ind == -1) {
        return null;
      }
      return incomeEN[ind];
    } else {
      int ind = incomeEN.indexOf(intialValue!);
      return ind.toString();
    }
  } else {
    if (functionType == 'initialValue') {
      if (intialValue == "") intialValue = '-1';
      int ind = int.parse(intialValue!);
      if (ind == -1) {
        return null;
      }
      return incomeAR[ind];
    } else {
      int ind = incomeAR.indexOf(intialValue!);
      return ind.toString();
    }
  }
}

bool depositReciptSnackBar(String? url) {
  // Add your function code here!
  if (url == null || url.isEmpty || url == '') {
    return true;
  } else {
    return false;
  }
}

String bedroomsText(
  int? num,
  String? locale,
) {
  if (locale!.isNotEmpty && num != null) {
    if (locale == 'en') {
      if (num == 1) {
        return "Bedroom";
      }
      return "Bedrooms";
    } else {
      if (num == 1) {
        return "غرفة";
      }
      if (num == 2) {
        return "غرفتين";
      }
      if (num >= 3 && num <= 11) {
        return "غرف";
      } else {
        return "غرفة";
      }
    }
  } else {
    return "Bedrooms";
  }
  // Add your function code here!
}

String bathroomText(
  int? num,
  String? locale,
) {
  // Add your function code here!
  if (locale!.isNotEmpty && num != null) {
    if (locale == 'en') {
      if (num == 1) {
        return "Bathroom";
      }
      return "Bathrooms";
    } else {
      if (num == 1) {
        return "دورة مياة";
      }
      if (num == 2) {
        return "دورتين مياة";
      }
      if (num >= 3 && num <= 11) {
        return "دورات مياة";
      } else {
        return "دورة مياة";
      }
    }
  } else {
    return "Bathrooms";
  }
}

String livingroomText(
  int? num,
  String? locale,
) {
  // Add your function code here
  if (locale!.isNotEmpty && num != null) {
    if (locale == 'en') {
      if (num == 1) {
        return "Livingroom";
      }
      return "Livingrooms";
    } else {
      if (num == 1) {
        return "غرفة معيشة";
      }
      if (num == 2) {
        return "غرفتان معيشة";
      }
      if (num >= 3 && num <= 11) {
        return "غرف معيشة";
      } else {
        return "غرفة معيشة";
      }
    }
  } else {
    return "Livingroom";
  }
}

String intText(
  String? text,
  String? locale,
) {
  // Add your function code here!
  if (locale!.isNotEmpty && text!.isNotEmpty) {
    if (locale == 'en') {
      final engRegex = RegExp(r'[^0-9].*', multiLine: true);
      Iterable<String> res =
          (engRegex.allMatches(text).map((m) => m.group(0)!));
      return text.replaceAll(res.elementAt(0), '');
    } else {
      final arRegex = RegExp(r'\s+(\d+)\s+', multiLine: true);
      Iterable<String> res = (arRegex.allMatches(text).map((m) => m.group(0)!));
      return res.elementAt(0);
    }
  } else {
    return "null";
  }
}

String agoTextDetailScreen(
  String? inputText,
  String? locale,
) {
  // Add your function code here!
  if (locale!.isNotEmpty && inputText!.isNotEmpty) {
    if (locale == 'en') {
      final engRegex = RegExp(r'[^0-9].*', multiLine: true);
      Iterable<String> res =
          (engRegex.allMatches(inputText).map((m) => m.group(0)!));
      return res.elementAt(0).trim();
    } else {
      final arRegex = RegExp(r'\s+(\d+)\s+', multiLine: true);
      Iterable<String> res =
          (arRegex.allMatches(inputText).map((m) => m.group(0)!));
      return inputText.replaceAll(res.elementAt(0), ' ');
    }
  } else {
    return "null";
  }
}

String resultText(
  String? count,
  String? locale,
) {
  // Add your function code here!
  if (locale!.isNotEmpty && (count?.isNotEmpty ?? false)) {
    int results = int.parse(count ?? '0');
    if (locale == 'en') {
      if (results == 1) {
        return "1 Result Found ";
      } else {
        return "${results} Results Found";
      }
    } else {
      if (results == 1) {
        return "نتيجة واحدة";
      }
      if (results == 2) {
        return "نتيجتين";
      }
      if (results >= 3 && results <= 10) {
        return "${results} نتائج";
      } else {
        return "${results} نتيجة";
      }
    }
  } else {
    return "No results found";
  }
}

String intToString(int? num) {
  // Add your function code here!
  if (num != null) {
    return num.toString();
  } else {
    return "0";
  }
}

Future<bool> isInternetConnected() async {
  return true;
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

void unAuthorizedUser(context,mounted) async {
 // Function() _navigate = () {};
 GoRouter.of(context).prepareAuthEvent();
  await signOut();
  FFAppState().authToken = '';
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        FFLocalizations.of(context).getText(
          'unAuthorizedUser' /* You are logged - in*/,
        ),
        style: TextStyle(
          fontFamily: 'Sofia Pro By Khuzaimah',
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      duration: Duration(milliseconds: 4000),
      backgroundColor: FlutterFlowTheme.of(context).primaryRed,
      ),
  );

 // _navigate = () =>
 //     context.goNamedAuth('Login', mounted);
 // _navigate();
  //context.goNamed('Login', mounted);
}



class CurrentRemainingTime {
  final String? days;
  final String? hours;
  final String? minutes;
  final String? seconds;

  CurrentRemainingTime({this.days, this.hours, this.minutes, this.seconds});

  @override
  String toString() {
    return 'CurrentRemainingTime{days: $days, hours: $hours, min: $minutes, sec: $seconds';
  }
}


CurrentRemainingTime milliSecondsToDay(value){
  int seconds = (int.parse(value.toString())/1000).floor();
  int days= (seconds~/(3600 *24));
  int remainingSeconds= (seconds%(3600 *24));
  int hours = (remainingSeconds~/3600);
  remainingSeconds = (remainingSeconds%3600);
  int minutes = remainingSeconds~/60;
  remainingSeconds = (remainingSeconds%60);
  return CurrentRemainingTime(days: days.toString().padLeft(2, '0'),hours: hours.toString().padLeft(2, '0'),minutes:minutes.toString().padLeft(2, '0'),seconds: remainingSeconds.toString().padLeft(2, '0'));
}

bool validateMobileNumber(String text)  {
  final RegExp _saudiArabiaMobileRegex = RegExp(r'^(05|5)[0-9]{8}$');
  if (text == null || text == '') {
    return false;
  } else {
    if (_saudiArabiaMobileRegex.hasMatch(text)) {
      return true;
    } else {
      return false;
    }
  }
}
bool isNameValidFunction(String text) {
  final RegExp _nameRegex = RegExp(
      r'^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+(?:\s[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+)*$');
  if (text != null || text != '') {
    if (_nameRegex.hasMatch(text)) {
      return true;
    }
    return false;
  }
  return false;
}
bool isEmailValidFunction(String text) {
  final RegExp _emialRegex = RegExp(
      r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+");
  if (text != null || text != '') {
    if (_emialRegex.hasMatch(text)) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}

