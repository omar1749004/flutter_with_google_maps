import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<bool> cheackAndRequestLocationServes() async {
    bool isServesEnable =
        await location.serviceEnabled(); // cheak location is enable
    if (!isServesEnable) {
      isServesEnable = await location.requestService();
      if (!isServesEnable) {
        return false;
      }
    }
    return true;
  }

  Future<bool> cheackAndRequestLocationPermission() async {
    PermissionStatus permissionState =
        await location.hasPermission(); // cheak permission state
    if (permissionState == PermissionStatus.denied) {
      permissionState = await location.requestPermission();
      
      return permissionState == PermissionStatus.granted ;
      
    } else if (permissionState == PermissionStatus.deniedForever) {
      return false;
    }
    return true;
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) {
    location.changeSettings(distanceFilter: 2) ; //هيتغير كل 2 متر
    location.onLocationChanged.listen(onData);
  }
}
