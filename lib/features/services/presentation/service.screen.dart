import 'package:app_vm/constants/widgets/avatar.icon.title.widget.dart';
import 'package:app_vm/features/services/application/service.service.dart';
import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../utils/map.util.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  ScrollController scrollController = ScrollController();
  var id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = Get.arguments['id'];
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder(
      future: ServiceService.getService(id),
      waiting: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (context, error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
      builder: (context, value) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Viaje en proceso'),
          ),
          body: ListView(
            controller: scrollController,
            children: [
              ListTile(
                leading: AvatarIconTitleWidget(icon: FontAwesome.eye_solid),
                title: const Text("Id de viaje"),
                dense: true,
                subtitle: Text(value!.id.toString()),
              ),
              const Divider(),
              ListTile(
                leading:
                    AvatarIconTitleWidget(icon: FontAwesome.building_solid),
                title: const Text("Cliente"),
                dense: true,
                subtitle: Text(value.client!.name!),
              ),
              const Divider(),
              ListTile(
                leading: AvatarIconTitleWidget(icon: Bootstrap.geo_alt_fill),
                title: const Text("Origen"),
                dense: true,
                subtitle: Text(value.originLocation!.name!),
                onTap: () {
                  if (value.originLocation != null) {
                    if (value.originLocation!.longitude != 0.0 &&
                        value.originLocation!.latitude != 0.0) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return AsyncBuilder(
                            future: getMaps(
                              showMapType: ShowMapType.marker,
                              location: Coords(
                                value.originLocation!.latitude!,
                                value.originLocation!.longitude!,
                              ),
                            ),
                            waiting: (context) => const Center(
                                child: CircularProgressIndicator()),
                            builder: (context, value) {
                              return Wrap(
                                children: value ?? [],
                              );
                            },
                          );
                        },
                      );
                    }
                  }
                },
              ),
              const Divider(),
              ListTile(
                leading: AvatarIconTitleWidget(icon: Bootstrap.geo_alt),
                title: const Text("Destino"),
                dense: true,
                subtitle: Text(value.destinyLocation!.name!),
                onTap: () {
                  if (value.destinyLocation != null) {
                    if (value.destinyLocation!.longitude != 0.0 &&
                        value.destinyLocation!.latitude != 0.0) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return AsyncBuilder(
                            future: getMaps(
                              showMapType: ShowMapType.marker,
                              location: Coords(
                                value.destinyLocation!.latitude!,
                                value.destinyLocation!.longitude!,
                              ),
                            ),
                            waiting: (context) => const Center(
                                child: CircularProgressIndicator()),
                            builder: (context, value) {
                              return Wrap(
                                children: value ?? [],
                              );
                            },
                          );
                        },
                      );
                    }
                  }
                },
              ),
              const Divider(),
              ListTile(
                leading: AvatarIconTitleWidget(icon: Mdi.accountCash),
                title: const Text("¿Que traslada?"),
                dense: true,
                subtitle: Text(value.collectionMethod!.name!),
              ),
              const Divider(),
              ListTile(
                leading: AvatarIconTitleWidget(icon: Mdi.trainCar),
                title: const Text("Tipo de viaje"),
                dense: true,
                subtitle: Text(value.journeyType!.name!),
              ),
            ],
          ),
        );
      },
    );
  }
}
