import 'package:permission_handler/permission_handler.dart';

Future<void> requestInitialPermission() async {
  var notificationPermission = Permission.notification;
  var gpsPermission = Permission.location;
  var cameraPermission = Permission.camera;
  var filePermission = Permission.accessMediaLocation;

  await notificationPermission.request();
  await gpsPermission.request();
  await cameraPermission.request();
  await filePermission.request();
}
