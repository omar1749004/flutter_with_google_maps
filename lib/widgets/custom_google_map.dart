import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps/controller/google_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GoogleController());
    return GetBuilder<GoogleController>(
        builder: (controller) => Scaffold(
              floatingActionButton: FloatingActionButton(onPressed: () {
                controller.googleMapController?.animateCamera(
                    CameraUpdate.newLatLng(const LatLng(30, 31)));
              }),
              body: GoogleMap(
                zoomControlsEnabled: false,
                polygons: controller.polygons,
                polylines: controller.polylines,
                circles: controller.circles,
                  onMapCreated: (mapController) {
                    controller.googleMapController = mapController;
                    controller.initMapstyle(context);
                    
                  },
                  markers: controller.markers,
                  // cameraTargetBounds: CameraTargetBounds(LatLngBounds(southwest: LatLng(10, 20),
                  // northeast: LatLng(10, 20))),
                  initialCameraPosition:
                      CameraPosition(target: LatLng(0, 0), zoom: 20)),
            ));
  }
}
