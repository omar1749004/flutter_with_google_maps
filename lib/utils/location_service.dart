import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<void> _cheackAndRequestLocationServes() async {
    bool isServesEnable =
        await location.serviceEnabled(); // cheak location is enable
    if (!isServesEnable) {
      isServesEnable = await location.requestService();
      if (!isServesEnable) {
        throw LocationServesException() ;
      }
    }
    // return true;
  }

  Future<void> _cheackAndRequestLocationPermission() async {
    PermissionStatus permissionState =
        await location.hasPermission(); // cheak permission state
    if (permissionState == PermissionStatus.denied) {
      permissionState = await location.requestPermission();
      
      if( permissionState != PermissionStatus.granted){
         throw LocationPermissionException();
      }
      
    } else if (permissionState == PermissionStatus.deniedForever) {
      throw LocationPermissionException();
    }
    // return true;
  }

  void getRealTimeLocationData(void Function(LocationData)? onData)async {
    await _cheackAndRequestLocationServes();
    await _cheackAndRequestLocationPermission();
    location.changeSettings(distanceFilter: 2) ; //هيتغير كل 2 متر
    location.onLocationChanged.listen(onData);  
  }

 Future<LocationData> getCurrentLocation() async{
   await _cheackAndRequestLocationServes();
   await _cheackAndRequestLocationPermission();
  return await  location.getLocation() ;
  }
}

class LocationServesException implements Exception{}
class LocationPermissionException implements Exception{}