// import 'dart:async';
// import 'dart:convert';
// import 'locationJS.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:js/js.dart';
// import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as web;

// class MyMapView extends StatefulWidget {
//   @override
//   _MyMapViewState createState() => _MyMapViewState();
// }

// class _MyMapViewState extends State<MyMapView> {
//   var latTemp, lngTemp;
//   bool _isWeb = true;
//   CameraPosition _initialLocation =
//       CameraPosition(target: LatLng(19.0760, 72.8777), zoom: 10);

//   GoogleMapController _googleMapController;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         height: 300,
//         width: size.width,
//         child: Scaffold(
//           body: Stack(
//             children: [
//               GoogleMap(
//                 initialCameraPosition: _initialLocation,
//                 mapType: MapType.normal,
//                 zoomGesturesEnabled: true,
//                 zoomControlsEnabled: false,
//                 onMapCreated: (GoogleMapController controller) {
//                   setState(() {
//                     _googleMapController = controller;
//                     _getCurrentLocation();
//                   });
//                 },
//               ),
//               IconButton(
//                   icon: Icon(Icons.my_location),
//                   onPressed: () {
//                     _myCurrentPosition();
//                   })
//               //later add zoom buttons
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _myCurrentPosition() {
//     _googleMapController.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(
//             // Will be fetching in the next step
//             latTemp,
//             lngTemp,
//           ),
//           zoom: 18.0,
//         ),
//       ),
//     );
//   }

//   //this is from locationJS.dart
//   success(pos) {
//     try {
//       latTemp = pos.coords.laitude;
//       lngTemp = pos.coords.longitude;
//       print(pos.coords.latitude);
//       print(pos.coords.longitude);
//     } catch (ex) {
//       print("Exception thrown : " + ex.toString());
//     }
//   }

//   _getCurrentLocation() {
//     if (_isWeb) {
//       getCurrentPosition(allowInterop((pos) => success(pos)));
//     }
//   }
// }
