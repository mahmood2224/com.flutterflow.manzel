import '../../enviorment/env_variables.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'dart:convert';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class PropertiesCall {
  static Future<ApiCallResponse> call({
    String? populate =
        '*,banks.Bank_logo,managed_by.Company_logo,property_images,city,property_floor_plan',
    String? city = '',
    String? furnishingType = '',
    String? propertyType = '',
    String? pageNumber = '',
    String? pageSize = '',
    String? locale = 'en',
    String? minimumPrice = '',
    String? maximumPrice = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Properties',
      apiUrl: '${EnvVariables.instance.strapiBaseURl}/api/properties',
      callType: ApiCallType.GET,
      headers: {
        'x-api-key': '06db164b-46ff-44e8-a0b8-c08f8eaa069f',
      },
      params: {
        'populate': populate,
        'city': city,
        'furnishing_type': furnishingType,
        'property_type': propertyType,
        'page_number': pageNumber,
        'page_size': pageSize,
        'locale': locale,
        'minimum_price': minimumPrice,
        'maximum_price': maximumPrice,
      },
      returnBody: true,
    );
  }

  static dynamic properties(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

class PropertyCall {
  static Future<ApiCallResponse> call({
    int? propertyId,
    String? locale = 'en',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Property',
      apiUrl:
          '${EnvVariables.instance.strapiBaseURl}/api/properties/${propertyId}',
      callType: ApiCallType.GET,
      headers: {
        'x-api-key': '06db164b-46ff-44e8-a0b8-c08f8eaa069f',
      },
      params: {
        'locale': locale,
      },
      returnBody: true,
    );
  }

  static dynamic property(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
  static dynamic propertyRef(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_reference''',
      );
  static dynamic propertyStatus(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_status''',
      );
  static dynamic propertyUpdatedAt(dynamic response) => getJsonField(
        response,
        r'''$.attributes.updatedAt''',
      );
  static dynamic propertyName(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_name''',
      );
  static dynamic propertyCity(dynamic response) => getJsonField(
        response,
        r'''$.attributes.city.data.attributes.city_name''',
      );
  static dynamic propertyDistrict(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_district''',
      );

  static dynamic propertyStreet(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_street''',
      );

  static dynamic propertyDescription(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_description''',
      );
  static dynamic propertyBedrooms(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_bedrooms''',
      );
  static dynamic propertyBathrooms(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_bathrooms''',
      );
  static dynamic propertySize(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_size''',
      );
  static dynamic propertyBuiltIn(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_built_in''',
      );
  static dynamic propertyLivingrooms(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_livingroom''',
      );
  static dynamic propertyFloors(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_floors''',
      );
  static dynamic propertyFurnishingType(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_furnishing_type''',
      );
  static dynamic propertyStreetWidth(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_street_width''',
      );
  static dynamic propertyPrice(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_price''',
      );
  static dynamic propertyEntranceDirection(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_address''',
      );
  static dynamic propertyType(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_type''',
      );
  static dynamic propertyInitialInstallment(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_initial_installment''',
      );
  static dynamic propertyFloorNumber(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_floor_number''',
      );
  static dynamic propertyLat(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_lat''',
      );
  static dynamic propertylng(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_lng''',
      );
  static dynamic propertyCoordinates(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_coordinates''',
      );
  static dynamic banks(dynamic response) => getJsonField(
        response,
        r'''$.attributes.banks.data''',
      );
  static dynamic bankName(dynamic response) => getJsonField(
        response,
        r'''$.attributes.banks.data..bank_name''',
      );
  static dynamic bankDescription(dynamic response) => getJsonField(
        response,
        r'''$.attributes.banks.data..bank_description''',
      );
  static dynamic bankRules(dynamic response) => getJsonField(
        response,
        r'''$.attributes.banks.data..bank_rules''',
      );
  static dynamic mangedBy(dynamic response) => getJsonField(
        response,
        r'''$.attributes.managed_by.data.attributes.company_name''',
      );
  static dynamic propertyImg(dynamic response) => getJsonField(
        response,
        r'''$..property_images.data[0].attributes.formats.medium.url''',
      );
  static dynamic companyLogo(dynamic response) => getJsonField(
        response,
        r'''$.attributes.managed_by.data.attributes.company_logo.data.attributes.url''',
      );
  static dynamic reservationsCost(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_reservation_cost''',
      );
  static dynamic propertyImages(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_images.data''',
      );
  static dynamic propertyId(dynamic response) => getJsonField(
        response,
        r'''$.id''',
      );
  static dynamic thumbnailImage(dynamic response) => getJsonField(
        response,
        r'''$.attributes.property_images.data[0].attributes.formats.small.url''',
      );
}

class FilterCall {
  static Future<ApiCallResponse> call({
    String? city = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'filter',
      apiUrl:
          '${EnvVariables.instance.strapiBaseURl}/api/properties/?city=${city}',
      callType: ApiCallType.GET,
      headers: {
        'x-api-key': '06db164b-46ff-44e8-a0b8-c08f8eaa069f',
      },
      params: {},
      returnBody: true,
    );
  }

  static dynamic city(dynamic response) => getJsonField(
        response,
        r'''$..[?(@.city == "[city]")]''',
      );
}

class InitiateOrderCall {
  static Future<ApiCallResponse> call({
    String? userID = '',
    String? propertyID = '',
    String? authorazationToken = '',
    String? version = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'initiateOrder',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/addOrder',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authorazationToken}',
        'version': version
      },
      params: {
        'userID': userID,
        'propertyID': propertyID,
      },
      returnBody: true,
    );
  }
}

class BankDetailsCall {
  static Future<ApiCallResponse> call({
    int? bankId,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'BankDetails',
      apiUrl: '${EnvVariables.instance.strapiBaseURl}/api/banks/${bankId}?',
      callType: ApiCallType.GET,
      headers: {
        'x-api-key': '06db164b-46ff-44e8-a0b8-c08f8eaa069f',
      },
      params: {},
      returnBody: true,
    );
  }

  static dynamic bankName(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.bank_name''',
      );
  static dynamic bankDescription(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.bank_description''',
      );
  static dynamic bankRules(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.bank_rules''',
      );
  static dynamic bankLogo(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.bank_logo.data.attributes.name''',
      );
}

class StartInstanceCall {
  static Future<ApiCallResponse> call({
    String? userID = '',
    int? propertyID,
    int? orderID,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Start Instance',
      apiUrl:
          '${EnvVariables.instance.firebaseBaseUrl}/booking-process-best-case-scenario-test',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'userID': userID,
        'propertyID': propertyID,
        'orderID': orderID,
      },
      returnBody: true,
    );
  }
}

class CityListCall {
  static Future<ApiCallResponse> call({
    String? locale = 'en',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'cityList',
      apiUrl: '${EnvVariables.instance.strapiBaseURl}/api/cities/?',
      callType: ApiCallType.GET,
      headers: {
        'x-api-key': '06db164b-46ff-44e8-a0b8-c08f8eaa069f',
      },
      params: {
        'locale': locale,
      },
      returnBody: true,
    );
  }

  static dynamic cityNames(dynamic response) => getJsonField(
        response,
        r'''$.data..attributes.city_name''',
      );
}

class FilterParamsCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'filterParams',
      apiUrl:
          '${EnvVariables.instance.strapiBaseURl}/api/properties/?locale=en&populate=*,banks.bank_logo,managed_by.prob_company_logo,property_images,city',
      callType: ApiCallType.GET,
      headers: {
        'x-api-key': '06db164b-46ff-44e8-a0b8-c08f8eaa069f',
      },
      params: {},
      returnBody: true,
    );
  }
}

class SearchPageCitiesCall {
  static Future<ApiCallResponse> call({
    String? locale = 'en',
    String? populate = 'city',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'searchPageCities',
      apiUrl: '${EnvVariables.instance.strapiBaseURl}/api/property/search',
      callType: ApiCallType.GET,
      headers: {
        'x-api-key': '06db164b-46ff-44e8-a0b8-c08f8eaa069f',
      },
      params: {
        'locale': locale,
        'populate': populate,
      },
      returnBody: true,
    );
  }

  static dynamic cityName(dynamic response) => getJsonField(
        response,
        r'''$.results..name''',
      );
  static dynamic numberOfProperties(dynamic response) => getJsonField(
        response,
        r'''$.results..count''',
      );
  static dynamic cityImage(dynamic response) => getJsonField(
        response,
        r'''$.results..image''',
      );
}

class PropertStatusCall {
  static Future<ApiCallResponse> call({
    int? propertyId,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'propertStatus',
      apiUrl:
          '${EnvVariables.instance.strapiBaseURl}/api/property/status/${propertyId}',
      callType: ApiCallType.GET,
      headers: {
        'x-api-key': '06db164b-46ff-44e8-a0b8-c08f8eaa069f',
      },
      params: {},
      returnBody: true,
    );
  }

  static dynamic propertyStatus(dynamic response) => getJsonField(
        response,
        r'''$.status.property_status''',
      );
}

class PropertyBookingStatusCall {
  static Future<ApiCallResponse> call({
    int? propertyId,
  }) {
    final body = '''
{"data": {"property_status": "Booked"}}''';
    return ApiManager.instance.makeApiCall(
      callName: 'propertyBookingStatus',
      apiUrl:
          '${EnvVariables.instance.strapiBaseURl}/api/properties/${propertyId}',
      callType: ApiCallType.PUT,
      headers: {
        'x-api-key': '06db164b-46ff-44e8-a0b8-c08f8eaa069f',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class AddOrderCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? propertyId = '',
    String? authorazationToken = '',
    String? version = '',
  }) {
    final body = '''
{
  "userID": "${userId}",
  "propertyID": "${propertyId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addOrder',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/addOrder',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authorazationToken}',
        'version': version
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class AddTransactionCall {
  static Future<ApiCallResponse> call({
    int? orderId,
    String? userId = '',
    String? amountPaid = '',
    String? transactionMethod = '',
    String? transactionStatus = '',
    String? transactionId = '',
    String? authorazationToken = '',
    String? version = '',
  }) {
    final body = '''
{
  "orderId": ${orderId},
  "userId": "${userId}",
  "transactionID": "${transactionId}",
  "amountPaid": "${amountPaid}",
  "transactionMethod": "${transactionMethod}",
  "transactionStatus": "${transactionStatus}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addTransaction',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/addTransaction',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authorazationToken}',
        'version': version
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class GetOffersCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? propertyId = '',
    String? locale = '',
    String? authorazationToken = '',
    String? version = '',
  }) {
    final body = '''
{
  "userID": "${userId}",
  "propertyID": "${propertyId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getOffers',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/getActiveOffers',
      callType: ApiCallType.POST,
      headers: {
        'Accept-Language': '${locale}',
        'Authorization': 'Bearer ${authorazationToken}',
        'version': version
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic bankLogo(dynamic response) => getJsonField(
        response,
        r'''$.result..bank_logo''',
      );
  static dynamic bankName(dynamic response) => getJsonField(
        response,
        r'''$.result..bank_name''',
      );
  static dynamic orderId(dynamic response) => getJsonField(
        response,
        r'''$.result..order_id''',
      );
  static dynamic installmentAmount(dynamic response) => getJsonField(
        response,
        r'''$.result..offered_installment_amount''',
      );
  static dynamic installmentPeriod(dynamic response) => getJsonField(
        response,
        r'''$.result..offered_installment_period''',
      );
  static dynamic agentName(dynamic response) => getJsonField(
        response,
        r'''$.result..agent_name''',
      );
  static dynamic updatedAt(dynamic response) => getJsonField(
        response,
        r'''$.result..updated_at._seconds''',
      );
  static dynamic createdAt(dynamic response) => getJsonField(
        response,
        r'''$.result..created_at''',
      );
  static dynamic offerStatus(dynamic response) => getJsonField(
        response,
        r'''$.result..property_id''',
      );
  static dynamic result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
      );
}

class AcceptOfferCall {
  static Future<ApiCallResponse> call(
      {String? userId = '',
      String? offerId = '',
      String? authorazationToken = '',
      String? version = ''}) {
    final body = '''
{
  "userID": "${userId}",
  "offerID": "${offerId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'acceptOffer',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/acceptOffer',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authorazationToken}',
        'version': version
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class ArchivedOffersCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? locale = '',
    String? authorazationToken = '',
    String? version = '',
  }) {
    final body = '''
{
  "userID": "${userId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'archivedOffers',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/getArchivedOffers',
      callType: ApiCallType.POST,
      headers: {
        'Accept-Language': '${locale}',
        'Authorization': 'Bearer ${authorazationToken}',
        'version': version
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
      );
}

class BookmarkListCall {
  static Future<ApiCallResponse> call(
      {String? userId = '',
      String? authorazationToken = '',
      String? version = ''}) {
    final body = '''
{
  "userId": "${userId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'bookmarkList',
      apiUrl:
          '${EnvVariables.instance.firebaseBaseUrl}/getBookMarkedPropertyIds',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authorazationToken}',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class BookedPropertiesCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? locale = '',
    String? authorazationToken = '',
    String? version = '',
  }) {
    final body = '''
{
  "userID": "${userId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'bookedProperties',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/getBookedProperties',
      callType: ApiCallType.POST,
      headers: {
        'Accept-Language': '${locale}',
        'Authorization': 'Bearer ${authorazationToken}',
        'version': version
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
      );
}

class OrderDetailsCall {
  static Future<ApiCallResponse> call({
    String? orderId = '',
    String? userid = '',
    String? locale = '',
    String? authorazationToken = '',
    String? version = '',
  }) {
    final body = '''
{
  "orderId": "${orderId}",
  "userId": "${userid}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'orderDetails',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/getOrderDetail',
      callType: ApiCallType.POST,
      headers: {
        'Accept-Language': '${locale}',
        'Authorization': 'Bearer ${authorazationToken}',
        'version': version
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic depositreceipt(dynamic response) => getJsonField(
        response,
        r'''$.result.deposit_receipt''',
      );
}

class BookmarkPropertyCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? propertyId = '',
    String? locale = '',
    String? authorazationToken = '',
    String? version = '',
  }) {
    final body = '''
{
  "userID": "${userId}",
  "propertyID": "${propertyId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'bookmarkProperty',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/bookmark',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authorazationToken}',
        'version': version
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class GetBookMarkedPropertiesCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? locale = '',
    String? authorazationToken = '',
    String? version = '',
  }) {
    final body = '''
{
  "userID": "${userId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getBookMarkedProperties',
      apiUrl:
          '${EnvVariables.instance.firebaseBaseUrl}/getBookMarkedProperties',
      callType: ApiCallType.POST,
      headers: {
        'Accept-Language': '${locale}',
        'Authorization': 'Bearer ${authorazationToken}',
        'version': version
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic result(dynamic response) => getJsonField(
        response,
        r'''$.result''',
      );
}

class CancelOrderCall {
  static Future<ApiCallResponse> call({
    String? orderId = '',
    String? userId = '',
    String? authorazationToken = '',
  }) {
    final body = '''
{
  "orderID": "${orderId}",
  "userID": "${userId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'cancelOrder',
      apiUrl: 'https://asia-south1-manzel-prod.cloudfunctions.net/cancelOrder',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authorazationToken}',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class TermsConitionsAndPrivacyPoliciesCall {
  static Future<ApiCallResponse> call({
    int? pageType = 5,
    String? locale = 'en',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'termsConitionsAndPrivacyPolicies',
      apiUrl:
          '${EnvVariables.instance.strapiBaseURl}/api/in-app-contents/${pageType}',
      callType: ApiCallType.GET,
      headers: {
        'x-api-key': '06db164b-46ff-44e8-a0b8-c08f8eaa069f',
      },
      params: {
        'locale': locale,
      },
      returnBody: true,
    );
  }
}

class GetBanksCall {
  static Future<ApiCallResponse> call({
    String? locale = 'en',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getBanks',
      apiUrl: '${EnvVariables.instance.strapiBaseURl}/api/banks?',
      callType: ApiCallType.GET,
      headers: {
        'x-api-key': '06db164b-46ff-44e8-a0b8-c08f8eaa069f',
      },
      params: {
        'locale': locale,
      },
      returnBody: true,
    );
  }

  static dynamic bankNames(dynamic response) => getJsonField(
        response,
        r'''$.data..attributes.bank_name''',
        true,
      );

  static dynamic bankData(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
}

class EmplymentTypeCall {
  static Future<ApiCallResponse> call({
    String? locale = 'en',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'emplymentType',
      apiUrl:
          '${EnvVariables.instance.strapiBaseURl}/api/employement-statuses?',
      callType: ApiCallType.GET,
      headers: {
        'x-api-key': '06db164b-46ff-44e8-a0b8-c08f8eaa069f',
      },
      params: {
        'locale': locale,
      },
      returnBody: true,
    );
  }

  static dynamic emplymentTypes(dynamic response) => getJsonField(
        response,
        r'''$.data..attributes.Name''',
        true,
      );

  static dynamic emplymentData(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

class OtpCalls {
  static Future<ApiCallResponse> generateOtp({
    String phoneNumber = '',
  }) {
    final body = '''
{
  "phoneNumber": "${phoneNumber}"
}''';
    String basicAuth = 'Basic ' +
        base64.encode(utf8.encode(
            '${EnvVariables.instance.jetAdminUserName}:${EnvVariables.instance.jetAdminPassword}'));
    return ApiManager.instance.generateOtpApiCall(
      callName: 'generateOtp',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/generateOtp',
      callType: ApiCallType.POST,
      bodyType: BodyType.JSON,
      returnBody: true,
      body: body,
      headers: <String, String>{'authorization': basicAuth},
    );
  }

  static Future<ApiCallResponse> verifyOtp({
    String phoneNumber = '',
    String otp = '',
    String key = '',
  }) {
    final body = '''
{
  "phoneNumber": "${phoneNumber}",
  "otp": "${otp}",
  "key": "${key}"
}''';
    String basicAuth = 'Basic ' +
        base64.encode(utf8.encode(
            '${EnvVariables.instance.jetAdminUserName}:${EnvVariables.instance.jetAdminPassword}'));
    return ApiManager.instance.generateOtpApiCall(
      callName: 'verifyOtp',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/verifyOtp',
      callType: ApiCallType.POST,
      bodyType: BodyType.JSON,
      returnBody: true,
      body: body,
      headers: <String, String>{'authorization': basicAuth},
    );
  }

  static Future<ApiCallResponse> verifyPhone({
    String phoneNumber = '',
    String otp = '',
    String key = '',
  }) {
    String idToken = FFAppState().authToken;
    final body = '''
{
  "phoneNumber": "${phoneNumber}",
  "otp": "${otp}",
  "key": "${key}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'verifyPhone',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/verifyPhone',
      callType: ApiCallType.POST,
      bodyType: BodyType.JSON,
      headers: {
        'Authorization': 'Bearer $idToken',
      },
      returnBody: true,
      body: body,
    );
  }

  static Future<ApiCallResponse> updatePhone({
    String newPhoneNumber = '',
    String idToken = '',
  }) {
    String idToken = FFAppState().authToken;
    final body = '''
{
  "newPhoneNumber": "$newPhoneNumber"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updatePhone',
      apiUrl: '${EnvVariables.instance.firebaseBaseUrl}/updatePhone',
      headers: {
        'Authorization': 'Bearer $idToken',
      },
      callType: ApiCallType.POST,
      bodyType: BodyType.JSON,
      returnBody: true,
      body: body,
    );
  }

  static dynamic tokenFromOtp(dynamic response) => getJsonField(
        response,
        r'''$.tokenKey''',
      );
  static dynamic generateSuccess(dynamic response) => getJsonField(
        response,
        r'''$.success''',
      );
  static dynamic generateKey(dynamic response) => getJsonField(
        response,
        r'''$.key''',
      );
  static dynamic verifyOtpStatus(dynamic response) => getJsonField(
        response,
        r'''$.error''',
      );
}
