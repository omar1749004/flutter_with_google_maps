import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps/models/place_model.dart';
import 'package:google_maps/utils/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

import 'package:location/location.dart';

class GoogleController extends GetxController {
  GoogleMapController? googleMapController;
  late LocationService locationService;
  late Location location;
  late TextEditingController textEditingController ;
  bool isFirstcall = true;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Set<Polygon> polygons = {};
  Set<Circle> circles = {};
  @override
  void onInit() {
    location = Location();
    locationService = LocationService();
    initMarker();
    updateMyLocation();
    textEditingController = TextEditingController() ;
    textEditingController.addListener(() {
      
    });
    //updateCurrentLocation();
    // initPolyline();
    // initPolygon();
    // initCircles();
    super.onInit();
  }
   @override
  void dispose() {
    textEditingController.dispose();
  }
  @override
  void onClose() {
    googleMapController?.dispose();
    super.onClose();
  }

  void updateMyLocation() async {
    try {
      locationService.getRealTimeLocationData(
        (locationData) {
          setmyLocationMarker(locationData);
          navigateCamera(locationData);
        },
      );
    } catch ($e) {
      //
    }
  }

  void updateCurrentLocation() async {
    try {
      var locationData = await locationService.getCurrentLocation();
      setmyLocationMarker(locationData) ;
      var cameraPosition = CameraPosition(target: LatLng(locationData.latitude!, locationData.longitude!,),
      zoom: 16
      ) ;
      googleMapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition)) ;
    } on LocationServesException catch (e) {
      // todo
    } on LocationPermissionException catch (e) {
      // todo
    } 
  }

  void navigateCamera(LocationData locationData) {
    if (!isFirstcall) {
      googleMapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!),
        ),
      );
    } else {
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(locationData.latitude!, locationData.longitude!),
            zoom: 17)),
      );
      isFirstcall = false;
    }
  }

  void setmyLocationMarker(LocationData locationData) {
    var myLocationMarker = Marker(
        markerId: const MarkerId(
          "my location marker",
        ),
        position: LatLng(locationData.latitude!, locationData.longitude!));
    markers.add(myLocationMarker);
    update();
  }

  void initMapstyle(BuildContext context) async {
    String nightMapstyle = await DefaultAssetBundle.of(context)
        .loadString("assets/map_style/night_map_style.json");
    googleMapController!.setMapStyle(nightMapstyle);
  }

  Future<Uint8List> getimageFromRawdata(String image, double width) async {
    var imagdata = await rootBundle.load(image);
    var imagecodec = await ui.instantiateImageCodec(
        imagdata.buffer.asUint8List(),
        targetHeight: width.toInt());
    var imagefarme = await imagecodec.getNextFrame();
    var imageBytedata =
        await imagefarme.image.toByteData(format: ui.ImageByteFormat.png);
    return imageBytedata!.buffer.asUint8List();
  }

  void initMarker() async {
    BitmapDescriptor customMarkerIcone =
        BitmapDescriptor.bytes(await getimageFromRawdata("zdffzdf", 20));
    places.map(
      (e) {
        print("Places list: $places");
        markers.add(
          Marker(
              markerId: MarkerId(e.id.toString()),
              position: e.latlng,
              infoWindow: InfoWindow(title: e.name),
              icon: customMarkerIcone),
        );
      },
    ).toList();
    update();
  }

  initPolyline() {
    polylines.add(
      Polyline(
          polylineId: PolylineId("1"),
          points: [LatLng(31, 31.2222)],
          color: Colors.red,
          zIndex: 2,
          patterns: [PatternItem.dot]),
    );
  }

  initPolygon() {
    polygons.add(
      Polygon(
          polygonId: PolygonId("1"),
          points: [],
          fillColor: Colors.black.withOpacity(0.1),
          holes: [[], []]),
    );
  }

  initCircles() {
    circles.add(
      Circle(
        circleId: CircleId("1"),
        center: LatLng(31, 30),
        radius: 10000,
      ),
    );
  }
}

List<PlaseModel> places = [
  PlaseModel(id: 123, name: "branch1", latlng: const LatLng(31.212, 29.12312)),
  PlaseModel(id: 1234, name: "branch2", latlng: const LatLng(31, 29)),
  PlaseModel(
      id: 56453, name: "branch3", latlng: const LatLng(31.7676, 29.112122)),
];
