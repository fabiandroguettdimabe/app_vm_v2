import 'package:app_vm/preferences/user.preferences.dart';
import 'package:app_vm/routing/routes.config.dart';
import 'package:app_vm/theme/theme.config.dart';
import 'package:app_vm/utils/permission.util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  await requestInitialPermission();
  runApp(VMApp());
}

class VMApp extends StatelessWidget {
  const VMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (_, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        darkTheme: darkThemeData,
        title: "Test App",
        initialRoute: '/',
        getPages: appRoutes(),
      );
    });
  }
}

// class Test {
//   card() {
//     return Card(
//       child: Wrap(
//         children: [
//           ListTile(
//             leading: AvatarIconTitleWidget(
//               icon: FontAwesome.truck_moving_solid,
//             ),
//             title: Text(
//               "Servicio : N° ${service.id}" ?? "",
//               style: TextStyle(
//                   color: primaryColorLight,
//                   fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(service.description ?? ""),
//           ),
//           Padding(
//             padding:
//             const EdgeInsets.only(left: 15, right: 15, top: 15),
//             child: Card(
//               elevation: 10,
//               child: ListTile(
//                 leading: AvatarIconTitleWidget(
//                   icon: FontAwesome.list_check_solid,
//                 ),
//                 title: const Text("Detalle del servicio"),
//               ),
//             ),
//           ),
//           const Divider(),
//           Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15),
//             child: Card(
//               elevation: 5,
//               child: ListTile(
//                 leading: AvatarIconTitleWidget(
//                   icon: FontAwesome.building,
//                 ),
//                 dense: true,
//                 title: const Text("Cliente: "),
//                 subtitle: Text(service.client?.name ?? ""),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15),
//             child: Card(
//               elevation: 5,
//               child: ListTile(
//                 leading: AvatarIconTitleWidget(
//                   icon: Icons.location_on,
//                 ),
//                 dense: true,
//                 title: Text(
//                     "Origen : ${service.originLocation?.name ?? ""}"),
//                 subtitle: Text(
//                     "Dirección : ${service.originLocation?.address}" ??
//                         ""),
//                 onTap: () {
//                   if (service.originLocation != null) {
//                     if (service.originLocation!.longitude != 0.0 &&
//                         service.originLocation!.latitude != 0.0) {
//                       showModalBottomSheet(
//                         context: context,
//                         builder: (context) {
//                           return AsyncBuilder(
//                             future: getMaps(
//                               showMapType: ShowMapType.marker,
//                               location: Coords(
//                                 service.originLocation!.latitude!,
//                                 service.originLocation!.longitude!,
//                               ),
//                             ),
//                             waiting: (context) => const Center(
//                                 child: CircularProgressIndicator()),
//                             builder: (context, value) {
//                               return Wrap(
//                                 children: value ?? [],
//                               );
//                             },
//                           );
//                         },
//                       );
//                     }
//                   }
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15),
//             child: Card(
//               elevation: 5,
//               child: ListTile(
//                 leading: AvatarIconTitleWidget(
//                   icon: Icons.location_on_outlined,
//                 ),
//                 dense: true,
//                 title: Text(
//                     "Destino : ${service.destinyLocation?.name ?? ""}"),
//                 subtitle: Text(
//                     "Dirección : ${service.destinyLocation?.address}" ??
//                         ""),
//                 onTap: () {
//                   if (service.destinyLocation != null) {
//                     if (service.destinyLocation!.longitude != 0.0 &&
//                         service.destinyLocation!.latitude != 0.0) {
//                       showModalBottomSheet(
//                         context: context,
//                         builder: (context) {
//                           return AsyncBuilder(
//                             future: getMaps(
//                               showMapType: ShowMapType.marker,
//                               location: Coords(
//                                 service.destinyLocation!.latitude!,
//                                 service.destinyLocation!.longitude!,
//                               ),
//                             ),
//                             waiting: (context) => const Center(
//                                 child: CircularProgressIndicator()),
//                             builder: (context, value) {
//                               return Wrap(
//                                 children: value ?? [],
//                               );
//                             },
//                           );
//                         },
//                       );
//                     }
//                   }
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15),
//             child: Card(
//               elevation: 5,
//               child: ListTile(
//                 leading: AvatarIconTitleWidget(
//                   icon: Mdi.accountCash,
//                 ),
//                 dense: true,
//                 title: const Text("¿Que traslada?"),
//                 subtitle:
//                 Text("${service.collectionMethod?.name}" ?? ""),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15),
//             child: Card(
//               elevation: 5,
//               child: ListTile(
//                 leading: AvatarIconTitleWidget(
//                   icon: Mdi.trainCar,
//                 ),
//                 dense: true,
//                 title: const Text("Tipo de viaje"),
//                 subtitle: Text("${service.journeyType?.name}" ?? ""),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15),
//             child: AsyncButtonBuilder(
//               child: const Text("Iniciar viaje"),
//               onPressed: () async {},
//               builder: (context, child, callback, buttonState) {
//                 return ElevatedButton.icon(
//                   icon: const Icon(Mdi.truckFast),
//                   onPressed: callback,
//                   label: child,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: successColor,
//                     minimumSize: const Size.fromHeight(50),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }