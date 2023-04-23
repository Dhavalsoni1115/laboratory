import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

class CurrentLocation {
  double? latitude, longitude;
  Future<dynamic> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      return position;
    } catch (e) {
      print('=======');

      //await LocationPermissions().shouldShowRequestPermissionRationale();
      // await LocationPermissions().requestPermissions(permissionLevel: LocationPermissionLevel.locationAlways);
      //final status = await LocationPermissions().requestPermissions();

      // if (status == PermissionStatus.granted) {
      //   print('Permission Granted');
      //   return;
      // } else if (status == PermissionStatus.denied) {
      //   print('Permission denied');
      //   return LocationPermissions().openAppSettings();
      // } else if (status == PermissionStatus.restricted) {
      //   print('Permission Permanently Denied');
      //   await LocationPermissions().openAppSettings();
      // }
    }
  }
}
