import 'package:app_vm/constants/widgets/avatar.icon.title.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<List<Widget>> getMaps(
    {required ShowMapType showMapType,
      required Coords location,
      String? title}) async {
  var result = <Widget>[];
  var mapInstalled = await MapLauncher.installedMaps;
  if (mapInstalled.isEmpty) {
    Get.showSnackbar(
      const GetSnackBar(
        title: "Aplicación de mapa no encontrada",
        message: "No cuenta con ninguna aplicación de mapa instalada",
        icon: Icon(Mdi.alertBox),
        duration: Duration(seconds: 30),
      ),
    );
  }
  result.add(
    Card(
      elevation: 5,
      margin: EdgeInsets.only(
        top: Adaptive.px(10),
      ),
      child: ListTile(
        leading: AvatarIconTitleWidget(icon: Icons.map),
        title: const Text("Seleccione un mapa para continuar"),
      ),
    ),
  );
  for (var mapInstalled in mapInstalled) {
    result.add(
      ListTile(
        leading: SvgPicture.asset(
          mapInstalled.icon,
          width: Adaptive.px(30),
          height: Adaptive.px(30),
        ),
        title: Text(mapInstalled.mapName),
        onTap: () async {
          if (ShowMapType.marker == showMapType) {
            await mapInstalled.showMarker(coords: location, title: "Ubicación");
          } else if (ShowMapType.directions == showMapType) {
            await mapInstalled.showDirections(destination: location);
          }
        },
      ),
    );
  }
  return result;
}


enum ShowMapType {
  marker(0, "Mostrar en el mapa"),
  directions(1, "Mostrar direcciones");

  const ShowMapType(this.value, this.description);

  final int value;
  final String description;
}