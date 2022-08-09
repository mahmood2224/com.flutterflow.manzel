import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class PropertiesCall {
  static Future<ApiCallResponse> call({
    String populate =
        '*,banks.Bank_logo,managed_by.Company_logo,property_images,city',
    String city = '',
    String furnishingType = '',
    String propertyType = '',
    String pageNumber = '',
    String pageSize = '',
    String locale = 'en',
    String minimumPrice = '',
    String maximumPrice = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Properties',
      apiUrl: 'https://strapi-dev.manzel.app/api/properties/',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer 4831692c4e6cff9e42a99cf0fc1ef2184f9f55dba093695599f9f7abc4ff19f3aade5fd06d5ee5a1bc531d0114fd4f5557d5fd129dbcdc7f9083a6af0e857842f689ce780f893ed1ec6dc25e3de820827816275bef46013c8e331eee4a73e3ff1c56af93c35d114ad0871556ad9a7fdd2122095fd88b805f9ae49d45ec0babf8',
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
    int propertyId,
    String locale = 'en',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Property',
      apiUrl: 'https://strapi-dev.manzel.app/api/properties/${propertyId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer 4831692c4e6cff9e42a99cf0fc1ef2184f9f55dba093695599f9f7abc4ff19f3aade5fd06d5ee5a1bc531d0114fd4f5557d5fd129dbcdc7f9083a6af0e857842f689ce780f893ed1ec6dc25e3de820827816275bef46013c8e331eee4a73e3ff1c56af93c35d114ad0871556ad9a7fdd2122095fd88b805f9ae49d45ec0babf8',
      },
      params: {
        'locale': locale,
      },
      returnBody: true,
    );
  }

  static dynamic property(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  static dynamic propertyRef(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_reference''',
      );
  static dynamic propertyStatus(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_status''',
      );
  static dynamic propertyUpdatedAt(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.updatedAt''',
      );
  static dynamic propertyName(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_name''',
      );
  static dynamic propertyCity(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.city.data.attributes.city_name''',
      );
  static dynamic propertyDistrict(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_district''',
      );
  static dynamic propertyDescription(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_description''',
      );
  static dynamic propertyBedrooms(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_bedrooms''',
      );
  static dynamic propertyBathrooms(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_bathrooms''',
      );
  static dynamic propertySize(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_size''',
      );
  static dynamic propertyBuiltIn(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_built_in''',
      );
  static dynamic propertyLivingrooms(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_livingroom''',
      );
  static dynamic propertyFloors(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_floors''',
      );
  static dynamic propertyFurnishingType(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_furnishing_type''',
      );
  static dynamic propertyStreetWidth(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_street_width''',
      );
  static dynamic propertyPrice(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_price''',
      );
  static dynamic propertyEntranceDirection(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_address''',
      );
  static dynamic propertyType(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_type''',
      );
  static dynamic propertyInitialInstallment(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_initial_installment''',
      );
  static dynamic propertyFloorNumber(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_floor_number''',
      );
  static dynamic propertyLat(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_lat''',
      );
  static dynamic propertylng(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_lng''',
      );
  static dynamic propertyCoordinates(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_coordinates''',
      );
  static dynamic banks(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.banks.data''',
      );
  static dynamic bankName(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.banks.data..bank_name''',
      );
  static dynamic bankDescription(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.banks.data..bank_description''',
      );
  static dynamic bankRules(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.banks.data..bank_rules''',
      );
  static dynamic mangedBy(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.managed_by.data.attributes.company_name''',
      );
  static dynamic propertyImg(dynamic response) => getJsonField(
        response,
        r'''$..property_images.data[0].attributes.name''',
      );
  static dynamic companyLogo(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.managed_by.data.attributes.company_logo.data.attributes.url''',
      );
  static dynamic reservationsCost(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_reservation_cost''',
      );
  static dynamic propertyImages(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_images.data''',
      );
  static dynamic propertyId(dynamic response) => getJsonField(
        response,
        r'''$.data.id''',
      );
}

class FilterCall {
  static Future<ApiCallResponse> call({
    String city = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'filter',
      apiUrl: 'https://strapi-dev.manzel.app/api/properties/?city=${city}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer 4831692c4e6cff9e42a99cf0fc1ef2184f9f55dba093695599f9f7abc4ff19f3aade5fd06d5ee5a1bc531d0114fd4f5557d5fd129dbcdc7f9083a6af0e857842f689ce780f893ed1ec6dc25e3de820827816275bef46013c8e331eee4a73e3ff1c56af93c35d114ad0871556ad9a7fdd2122095fd88b805f9ae49d45ec0babf8',
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
    String userID = '',
    String propertyID = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'initiateOrder',
      apiUrl: 'https://asia-south1-manzel-prod.cloudfunctions.net/addOrder',
      callType: ApiCallType.GET,
      headers: {},
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
    int bankId,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'BankDetails',
      apiUrl: 'https://strapi-dev.manzel.app/api/banks/${bankId}?',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer 4831692c4e6cff9e42a99cf0fc1ef2184f9f55dba093695599f9f7abc4ff19f3aade5fd06d5ee5a1bc531d0114fd4f5557d5fd129dbcdc7f9083a6af0e857842f689ce780f893ed1ec6dc25e3de820827816275bef46013c8e331eee4a73e3ff1c56af93c35d114ad0871556ad9a7fdd2122095fd88b805f9ae49d45ec0babf8',
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
    String userID = '',
    int propertyID,
    int orderID,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Start Instance',
      apiUrl:
          'https://asia-south1-manzel-prod.cloudfunctions.net/booking-process-best-case-scenario-test',
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
    String locale = 'en',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'cityList',
      apiUrl: 'https://strapi-dev.manzel.app/api/cities/?',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer 4831692c4e6cff9e42a99cf0fc1ef2184f9f55dba093695599f9f7abc4ff19f3aade5fd06d5ee5a1bc531d0114fd4f5557d5fd129dbcdc7f9083a6af0e857842f689ce780f893ed1ec6dc25e3de820827816275bef46013c8e331eee4a73e3ff1c56af93c35d114ad0871556ad9a7fdd2122095fd88b805f9ae49d45ec0babf8',
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
          'https://strapi-dev.manzel.app/api/properties/?locale=en&populate=*,banks.bank_logo,managed_by.prob_company_logo,property_images,city',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer 4831692c4e6cff9e42a99cf0fc1ef2184f9f55dba093695599f9f7abc4ff19f3aade5fd06d5ee5a1bc531d0114fd4f5557d5fd129dbcdc7f9083a6af0e857842f689ce780f893ed1ec6dc25e3de820827816275bef46013c8e331eee4a73e3ff1c56af93c35d114ad0871556ad9a7fdd2122095fd88b805f9ae49d45ec0babf8',
      },
      params: {},
      returnBody: true,
    );
  }
}

class SearchPageCitiesCall {
  static Future<ApiCallResponse> call({
    String locale = 'en',
    String populate = 'city',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'searchPageCities',
      apiUrl: 'https://strapi-dev.manzel.app/api/property/search',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer 4831692c4e6cff9e42a99cf0fc1ef2184f9f55dba093695599f9f7abc4ff19f3aade5fd06d5ee5a1bc531d0114fd4f5557d5fd129dbcdc7f9083a6af0e857842f689ce780f893ed1ec6dc25e3de820827816275bef46013c8e331eee4a73e3ff1c56af93c35d114ad0871556ad9a7fdd2122095fd88b805f9ae49d45ec0babf8',
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
    int propertyId,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'propertStatus',
      apiUrl: 'https://strapi-dev.manzel.app/api/property/status/${propertyId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization':
            'Bearer 4831692c4e6cff9e42a99cf0fc1ef2184f9f55dba093695599f9f7abc4ff19f3aade5fd06d5ee5a1bc531d0114fd4f5557d5fd129dbcdc7f9083a6af0e857842f689ce780f893ed1ec6dc25e3de820827816275bef46013c8e331eee4a73e3ff1c56af93c35d114ad0871556ad9a7fdd2122095fd88b805f9ae49d45ec0babf8',
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
    int propertyId,
  }) {
    final body = '''
{"data": {"property_status": "Booked"}}''';
    return ApiManager.instance.makeApiCall(
      callName: 'propertyBookingStatus',
      apiUrl: 'https://strapi-dev.manzel.app/api/properties/${propertyId}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization':
            'Bearer 4831692c4e6cff9e42a99cf0fc1ef2184f9f55dba093695599f9f7abc4ff19f3aade5fd06d5ee5a1bc531d0114fd4f5557d5fd129dbcdc7f9083a6af0e857842f689ce780f893ed1ec6dc25e3de820827816275bef46013c8e331eee4a73e3ff1c56af93c35d114ad0871556ad9a7fdd2122095fd88b805f9ae49d45ec0babf8',
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
    String userId = '',
    String propertyId = '',
  }) {
    final body = '''
{
  "userID": "${userId}",
  "propertyID": "${propertyId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addOrder',
      apiUrl: 'https://asia-south1-manzel-prod.cloudfunctions.net/addOrder',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer 4831692c4e6cff9e42a99cf0fc1ef2184f9f55dba093695599f9f7abc4ff19f3aade5fd06d5ee5a1bc531d0114fd4f5557d5fd129dbcdc7f9083a6af0e857842f689ce780f893ed1ec6dc25e3de820827816275bef46013c8e331eee4a73e3ff1c56af93c35d114ad0871556ad9a7fdd2122095fd88b805f9ae49d45ec0babf8',
      },
      params: {
        'userId': userId,
        'propertyId': propertyId,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class AddTransactionCall {
  static Future<ApiCallResponse> call({
    int orderId,
    String userId = '',
    String amountPaid = '',
    String transactionMethod = '',
    String transactionStatus = '',
    String transactionId = '',
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
      apiUrl:
          'https://asia-south1-manzel-prod.cloudfunctions.net/addTransaction',
      callType: ApiCallType.POST,
      headers: {
        'Authorization':
            'Bearer 4831692c4e6cff9e42a99cf0fc1ef2184f9f55dba093695599f9f7abc4ff19f3aade5fd06d5ee5a1bc531d0114fd4f5557d5fd129dbcdc7f9083a6af0e857842f689ce780f893ed1ec6dc25e3de820827816275bef46013c8e331eee4a73e3ff1c56af93c35d114ad0871556ad9a7fdd2122095fd88b805f9ae49d45ec0babf8',
      },
      params: {
        'orderId': orderId,
        'userId': userId,
        'amountPaid': amountPaid,
        'transactionMethod': transactionMethod,
        'transactionStatus': transactionStatus,
        'transactionId': transactionId,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class GetOffersCall {
  static Future<ApiCallResponse> call({
    String userId = '',
    String propertyId = '',
  }) {
    final body = '''
{
  "userID": "${userId}",
  "propertyID": "${propertyId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getOffers',
      apiUrl:
          'https://asia-south1-manzel-prod.cloudfunctions.net/getActiveOffers',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'userId': userId,
        'propertyId': propertyId,
      },
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
  static Future<ApiCallResponse> call({
    String userId = '',
    String offerId = '',
  }) {
    final body = '''
{
  "userID": "${userId}",
  "offerID": "${offerId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'acceptOffer',
      apiUrl: 'https://asia-south1-manzel-prod.cloudfunctions.net/acceptOffer',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'userId': userId,
        'offerId': offerId,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class ArchivedOffersCall {
  static Future<ApiCallResponse> call({
    String userId = '',
  }) {
    final body = '''
{
  "userID": "${userId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'archivedOffers',
      apiUrl:
          'https://asia-south1-manzel-prod.cloudfunctions.net/getArchivedOffers',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'userId': userId,
      },
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

class BookedPropertiesCall {
  static Future<ApiCallResponse> call({
    String userId = '',
  }) {
    final body = '''
{
  "userID": "${userId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'bookedProperties',
      apiUrl:
          'https://asia-south1-manzel-prod.cloudfunctions.net/getBookedProperties',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'userId': userId,
      },
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
    String orderId = '',
    String userid = '',
  }) {
    final body = '''
{
  "orderId": "${orderId}",
  "userId": "${userid}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'orderDetails',
      apiUrl:
          'https://asia-south1-manzel-prod.cloudfunctions.net/getOrderDetail',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'orderId': orderId,
        'userid': userid,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class BookmarkPropertyCall {
  static Future<ApiCallResponse> call({
    String userId = '',
    String propertyId = '',
  }) {
    final body = '''
{
  "userID": "${userId}",
  "propertyID": "${propertyId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'bookmarkProperty',
      apiUrl: 'https://asia-south1-manzel-prod.cloudfunctions.net/bookmark',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'userId': userId,
        'propertyId': propertyId,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class GetBookMarkedPropertiesCall {
  static Future<ApiCallResponse> call({
    String userId = '',
  }) {
    final body = '''
{
  "userID": "${userId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getBookMarkedProperties',
      apiUrl:
          'https://asia-south1-manzel-prod.cloudfunctions.net/getBookMarkedProperties',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'userId': userId,
      },
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
    String orderId = '',
    String userId = '',
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
      headers: {},
      params: {
        'orderId': orderId,
        'userId': userId,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}
