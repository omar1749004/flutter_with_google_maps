import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps/controller/google_controller.dart';
import 'package:google_maps/widgets/custom_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GoogleController());
    return GetBuilder<GoogleController>(
        builder: (controller) => Scaffold(
              resizeToAvoidBottomInset: false,
              floatingActionButton: FloatingActionButton(onPressed: () {
                controller.googleMapController?.animateCamera(
                    CameraUpdate.newLatLng(const LatLng(30, 31)));
              }),
              body: SafeArea(
                child: Stack(
                  children: [
                    GoogleMap(
                      zoomControlsEnabled: false,
                      polygons: controller.polygons,
                      polylines: controller.polylines,
                      circles: controller.circles,
                      onMapCreated: (mapController) {
                        controller.googleMapController = mapController;
                        controller.initMapstyle(context);
                        controller.updateCurrentLocation();
                      },
                      markers: controller.markers,
                      // cameraTargetBounds: CameraTargetBounds(LatLngBounds(southwest: LatLng(10, 20),
                      // northeast: LatLng(10, 20))),
                      initialCameraPosition:
                          CameraPosition(target: LatLng(0, 0), zoom: 20),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      right: 16,
                      child: CustomTextField(
                        textEditingController: controller.textEditingController,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
