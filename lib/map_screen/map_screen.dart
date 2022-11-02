// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:manzel/backend/api_requests/api_calls.dart';
// import 'package:manzel/flutter_flow/flutter_flow_drop_down.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:manzel/flutter_flow/flutter_flow_util.dart';
//
// import '../app_state.dart';
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   bool isSwitchEnabled = false;
//   Iterable markers = [];
//   Completer<GoogleMapController> _controller = Completer();
//   late Polyline routeLine;
//   String cityName = '';
//
//   @override
//   void initState() {
//     createRouteLine();
//     createMarker();
//     super.initState();
//     searchPageCitiesCall();
//   }
//
//   Future<ApiCallResponse> searchPageCitiesCall() async {
//     final searchPageCitiesCallResult = await SearchPageCitiesCall.call(
//       locale: FFAppState().locale,
//       populate: 'city',
//     );
//     final query= searchPageCitiesCallResult.jsonBody['results'];
//
//     print(query);
//     return searchPageCitiesCallResult;
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Future<void> makeProeprtyApiCall() async {
//     //   isLoading.value = true;
//     //   //Future.delayed(Duration(seconds: 5));
//     //   final callResult = await PropertyCall.call(
//     //     propertyId: widget.propertyId,
//     //     locale: FFAppState().locale,
//     //   );
//     //   final callResultToJson = callResult.jsonBody['data'];
//     //   columnPropertyResponse = callResultToJson;
//     //   print("++++");
//     //   isLoading.value = false;
//     // }
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: 40,
//           ),
//
//           SizedBox(
//             width: 100,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               InkWell(onTap: () {
//                 Navigator.of(context).pop();
//
//               }, child: Icon(Icons.arrow_back)),
//               FlutterFlowDropDown(
//                 hintText: 'City: ' + cityName,
//                 hidesUnderline: true,
//                 initialOption: 'Hejjh',
//                 width: 350,
//                 options: (getJsonField(
//                   citiesListCityListResponse
//                       .jsonBody,
//                   r'''$.cities''',
//                 ) as List)
//                     .map<String>(
//                         (s) => s.toString())
//                     .toList(),//['Riyadh', 'Indore', 'Delhi', 'Haryana'],
//                 borderRadius: 0,
//                 elevation: 0,
//                 borderColor: Color(0xffF3F2F2),
//                 borderWidth: 2,
//                 margin: EdgeInsets.symmetric(horizontal: 30),
//                 textStyle: TextStyle(),
//                 onChanged: (value) {
//                   setState(() {
//                     cityName = value!;
//                   });
//                 },
//               ),
//             ],
//           ),
//           Container(
//             height: 600,
//             width: 500,
//             child: GoogleMap(
//               mapType:
//               isSwitchEnabled ? MapType.satellite : MapType.normal,
//               polylines: {routeLine},
//               initialCameraPosition: CameraPosition(
//                   target: LatLng(
//                       24.0??0,
//                       35.0??0),
//                   zoom: 10.5),
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//               markers: Set.from(markers),
//               onTap: (coordinates) {},
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   void createRouteLine() {
//     List<LatLng> pointsList =
//         [].map((e) => LatLng(e.latitude ?? 0, e.longitude ?? 0)).toList();
//     routeLine = Polyline(
//       polylineId: PolylineId('hello'),
//       points: pointsList,
//       width: 3,
//       color: Colors.red,
//     );
//     setState(() {});
//   }
//
//   void createMarker() {
//     markers = [
//       Marker(
//           markerId: MarkerId(24.toString()),
//           position: LatLng(
//             24 ?? 0,
//             35 ?? 0,
//           ),
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//           infoWindow: InfoWindow(title: 'hello'),
//           onTap: () {}),
//       Marker(
//           markerId: MarkerId(34.toString()),
//           position: LatLng(
//             24 ?? 0,
//             34 ?? 0,
//           ),
//           icon: BitmapDescriptor.defaultMarkerWithHue(
//               BitmapDescriptor.hueMagenta),
//           infoWindow: InfoWindow(title: 'hello'),
//           onTap: () {}),
//     ];
//     setState(() {});
//   }
// }
