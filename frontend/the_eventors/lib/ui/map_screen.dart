import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  final String address;
  const MapScreen({Key? key, required this.address}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _conroller = Completer();
  LatLng? sourceLocation = LatLng(0, 0);
  LatLng? destination = LatLng(0, 0);
  List<LatLng> polylineCoordinates = [];
  bool isLoading = true;
  String address = "Skopje,North Macedonia";
  //var currentLocation;

  getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition();
    setState(() {
      sourceLocation = LatLng(position.latitude, position.longitude);
    });
  }

  getDestinationLocation(String address) async {
    var position = await Geocoder2.getDataFromAddress(
        address: widget.address,
        googleMapApiKey: "AIzaSyCJL6U_VH51jknp-Vs3ciddmoPX2_kH5Ak");

    setState(() {
      destination = LatLng(position.latitude, position.longitude);
    });
  }

  void getPolyPoints(LatLng source, LatLng dest) async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyCJL6U_VH51jknp-Vs3ciddmoPX2_kH5Ak",
        PointLatLng(sourceLocation!.latitude, sourceLocation!.longitude),
        PointLatLng(dest.latitude, dest.longitude));
    print("POLY POINTSSS");
    print(result.points);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    getDestinationLocation(address);
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF007CC7),
              ),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(destination!.latitude, destination!.longitude),
                  zoom: 16.5),
              polylines: {
                Polyline(
                    polylineId: PolylineId("route"),
                    points: polylineCoordinates,
                    color: Colors.red,
                    width: 10)
              },
              markers: {
                Marker(markerId: MarkerId("source"), position: sourceLocation!),
                Marker(
                    markerId: MarkerId("destination"),
                    position: destination!,
                    onTap: () {
                      if (polylineCoordinates.isEmpty) {
                        getPolyPoints(sourceLocation!, destination!);
                      } else {
                        setState(() {
                          polylineCoordinates = [];
                        });
                      }
                    })
              },
              onMapCreated: (mapController) {
                _conroller.complete(mapController);
              },
            ),
    );
  }
}
