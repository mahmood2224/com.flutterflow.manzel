import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class PropertiesCall {
  static Future<ApiCallResponse> call({
    String populate =
        '*,banks.bank_logo,managed_by.company_logo,property_images,city',
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
      headers: {},
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
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Property',
      apiUrl:
          'https://strapi-dev.manzel.app/api/properties/${propertyId}/?populate=*,banks.bank_logo,managed_by.company_logo, property_images',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
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
        r'''$.data.attributes.property_entrance_direction''',
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
        r'''$.data.attributes.managed_by.data.attributes.company_logo.data.attributes.name''',
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
      headers: {},
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
      apiUrl: 'https://us-central1-manzel-prod.cloudfunctions.net/addOrder',
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
      headers: {},
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
          'https://us-central1-manzel-prod.cloudfunctions.net/booking-process-best-case-scenario-test',
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
      headers: {},
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
      headers: {},
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
      headers: {},
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
