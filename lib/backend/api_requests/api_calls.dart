import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class PropertiesCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'Properties',
      apiUrl: 'https://strapi-dev.manzel.app/api/properties/?populate=*',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
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
          'https://strapi-dev.manzel.app/api/properties/${propertyId}/?populate=*',
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
  static dynamic propertyId(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_id''',
      );
  static dynamic propertyStatus(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.status''',
      );
  static dynamic propertyUpdatedAt(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.updatedAt''',
      );
  static dynamic propertyName(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.name''',
      );
  static dynamic propertyCity(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.city''',
      );
  static dynamic propertyDistrict(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.district''',
      );
  static dynamic propertyDescription(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.description''',
      );
  static dynamic propertyBedrooms(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.bedrooms''',
      );
  static dynamic propertyBathrooms(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.bathrooms''',
      );
  static dynamic propertySize(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.size''',
      );
  static dynamic propertyBuiltIn(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.built_in''',
      );
  static dynamic propertyLivingrooms(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.livingroom''',
      );
  static dynamic propertyFloors(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.floors''',
      );
  static dynamic propertyFurnishingType(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.furnishing_type''',
      );
  static dynamic propertyStreetWidth(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.price''',
      );
  static dynamic propertyPrice(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.price''',
      );
  static dynamic propertyEntranceDirection(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.entrance_direction''',
      );
  static dynamic propertyType(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.property_type''',
      );
  static dynamic propertyInitialInstallment(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.initial_installment''',
      );
  static dynamic propertyFloorNumber(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.floor_number''',
      );
  static dynamic propertyLat(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.lat''',
      );
  static dynamic propertylng(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.lng''',
      );
  static dynamic propertyCoordinates(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.coordinates''',
      );
  static dynamic banks(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.banks.data''',
      );
  static dynamic bankName(dynamic response) => getJsonField(
        response,
        r'''$.data.attributes.banks.data..name''',
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
        r'''$.data.attributes.managed_by.data.attributes.name''',
      );
  static dynamic propertyImg(dynamic response) => getJsonField(
        response,
        r'''$..images.data[0].attributes.name''',
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
