import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  final PermissionHandler _permissionHandler = PermissionHandler();

  Future<bool> _requestPermission() async {
    var result = await _permissionHandler.requestPermissions([
      PermissionGroup.location,
      PermissionGroup.camera,
      PermissionGroup.mediaLibrary,
      PermissionGroup.calendar,
      PermissionGroup.notification
    ]);
    if (result == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestPermission({required Function onPermissionDenied}) async {
    var granted = await _requestPermission();
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }

  Future<bool> hasLocationPermission() async {
    return hasPermission(PermissionGroup.location);
  }

  Future<bool> hasCameranPermission() async {
    return hasPermission(PermissionGroup.camera);
  }

  Future<bool> hasMediaPermission() async {
    return hasPermission(PermissionGroup.mediaLibrary);
  }

  Future<bool> hasCalendarPermission() async {
    return hasPermission(PermissionGroup.calendar);
  }

  Future<bool> hasNotificationPermission() async {
    return hasPermission(PermissionGroup.notification);
  }

  Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus =
        await _permissionHandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }
}
