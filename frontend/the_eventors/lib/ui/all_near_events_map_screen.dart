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
import 'package:provider/provider.dart';
import 'package:the_eventors/models/dto/ListingEventNearRepsonseDto.dart';
import 'package:the_eventors/models/dto/NearEventForMapDto.dart';
import 'package:the_eventors/ui/detail_event_screen.dart';

import '../providers/EventProvider.dart';

class AllNearEventsMapScreen extends StatefulWidget {
  const AllNearEventsMapScreen({Key? key}) : super(key: key);

  @override
  State<AllNearEventsMapScreen> createState() => _AllNearEventsMapScreenState();
}

class _AllNearEventsMapScreenState extends State<AllNearEventsMapScreen> {
  final Completer<GoogleMapController> _conroller = Completer();
  LatLng? sourceLocation = LatLng(0, 0);
  LatLng? destination = LatLng(0, 0);
  List<LatLng> polylineCoordinates = [];
  List<NearEventForMapDto> events = [];
  bool isLoading = true;
  late Map<MarkerId, Marker> markers;
  //var currentLocation;

  getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition();
    setState(() {
      sourceLocation = LatLng(position.latitude, position.longitude);
    });
  }

  createMarkers() async {
    MarkerId markerId = MarkerId("0");

    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(sourceLocation!.latitude, sourceLocation!.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    setState(() {
      markers[markerId] = marker;
    });
    for (int i = 0; i < events.length; i++) {
      var position = await Geocoder2.getDataFromAddress(
          address: events[i].location,
          googleMapApiKey: "AIzaSyCJL6U_VH51jknp-Vs3ciddmoPX2_kH5Ak");
      double latitude = position.latitude;
      double longitude = position.longitude;

      LatLng pos = LatLng(latitude, longitude);
      MarkerId markerId = MarkerId((i + 1).toString());
      Marker marker = Marker(
        markerId: markerId,
        position: pos,
        onTap: () {
          if (polylineCoordinates.isEmpty) {
            getPolyPoints(sourceLocation!, pos);
          } else {
            setState(() {
              polylineCoordinates = [];
            });
          }
        },
        infoWindow: InfoWindow(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailsEventScreen(
                      id: events[i].id,
                    ))),
            title: "Event: " + events[i].title,
            snippet: "Start at: ${events[i].startDateTime}"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
      setState(() {
        markers[markerId] = marker;
      });
    }
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
    Provider.of<EventProvider>(context, listen: false).getAllNearForMap();
    markers = <MarkerId, Marker>{};

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        events = context.read<EventProvider>().allNearForMap;
      });

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomAppBar(),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF007CC7),
                ),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        sourceLocation!.latitude, sourceLocation!.longitude),
                    zoom: 11.5),
                polylines: {
                  Polyline(
                      polylineId: PolylineId("route"),
                      points: polylineCoordinates,
                      color: Colors.red,
                      width: 10)
                },
                markers: Set<Marker>.of(markers.values),
                onMapCreated: (mapController) {
                  _conroller.complete(mapController);
                  createMarkers();
                },
              ));
  }
}
