import 'package:app_vm/preferences/user.preferences.dart';
import 'package:app_vm/utils/location.util.dart';

import '../features/services/domain/log.dto.dart';

Future<LogDto?> createLog() async {
  var position = await getCurrentPosition();
  if (position == null) {
    return null;
  }
  return LogDto(
    latitude: position.latitude,
    longitude: position.longitude,
  );
}