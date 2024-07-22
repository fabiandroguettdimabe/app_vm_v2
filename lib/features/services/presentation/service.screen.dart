import 'package:app_vm/constants/constants.dart';
import 'package:app_vm/constants/widgets/avatar.icon.title.widget.dart';
import 'package:app_vm/features/services/application/service.service.dart';
import 'package:app_vm/features/services/domain/service.dto.dart';
import 'package:app_vm/theme/color.config.dart';
import 'package:async_builder/async_builder.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select_clone/flutter_awesome_select.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
      waiting: (context) =>
      const Center(
        child: CircularProgressIndicator(),
      ),
      error: (context, error, stackTrace) =>
          Center(
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
                            waiting: (context) =>
                            const Center(
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
                            waiting: (context) =>
                            const Center(
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
              Visibility(
                  visible: value.commissionByContainer ?? false,
                  child: Wrap(
                    children: [
                      const Divider(),
                      ListTile(
                        leading: Padding(
                          padding: EdgeInsets.all(Adaptive.px(10)),
                          child: SvgPicture.asset(
                            'assets/svg/cargo_container_icon.svg',
                            colorFilter: ColorFilter.mode(
                                Theme
                                    .of(context)
                                    .iconTheme
                                    .color ??
                                    Colors.black,
                                BlendMode.srcIn),
                            width: Adaptive.w(2),
                            height: Adaptive.h(2),
                          ),
                        ),
                        title: const Text("Cantidad de Contenedores"),
                        subtitle: Text(value.containerQty != null
                            ? value.containerQty.toString()
                            : ""),
                        trailing: IconButton(
                          color: Colors.transparent,
                          icon: Icon(Mdi.squareEditOutline,
                              color: Get.theme.iconTheme.color),
                          onPressed: () {
                            showQuantityContainer(context, value);
                          },
                        ),
                      ),
                      const Divider(),
                    ],
                  )),
              const Divider(),
              showLines(context, value.lines),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: AsyncButtonBuilder(
                  builder: (context, child, callback, buttonState) {
                    return ElevatedButton(
                      onPressed: callback,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColorDark),
                      child: child,
                    );
                  },
                  child: ListTile(
                    leading: AvatarIconTitleWidget(icon: FontAwesome.map),
                    title: const Text(
                      "Ir al Mapa",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: AsyncButtonBuilder(
                  builder: (context, child, callback, buttonState) {
                    return ElevatedButton(
                      onPressed: callback,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColorDark),
                      child: child,
                    );
                  },
                  child: ListTile(
                    leading: AvatarIconTitleWidget(icon: Mdi.truckAlertOutline),
                    title: const Text(
                      "Registrar Evento/Comentario",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: AsyncButtonBuilder(
                  builder: (context, child, callback, buttonState) {
                    return ElevatedButton(
                      onPressed: callback,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: successColor),
                      child: child,
                    );
                  },
                  child: ListTile(
                    leading: AvatarIconTitleWidget(icon: Mdi.truckCheckOutline),
                    title: const Text(
                      "Finalizar viaje",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showQuantityContainer(BuildContext context, ServiceShowMobileDto service) {
    Get.bottomSheet(
      Wrap(
        children: [
          Card(
            elevation: 10,
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.all(Adaptive.px(10)),
                child: SvgPicture.asset(
                  'assets/svg/cargo_container_icon.svg',
                  colorFilter: ColorFilter.mode(
                      Theme
                          .of(context)
                          .iconTheme
                          .color ?? Colors.black,
                      BlendMode.srcIn),
                  width: Adaptive.w(2),
                  height: Adaptive.h(2),
                ),
              ),
              title: const Text("Ingrese la cantidad de contenedores"),
            ),
          ),
          SmartSelect<int?>.single(
            modalHeaderStyle: S2ModalHeaderStyle(
              centerTitle: true,
              textStyle: Get.theme.textTheme.titleMedium,
              actionsIconTheme: Get.theme.iconTheme,
              iconTheme: Get.theme.iconTheme,
            ),
            selectedValue: service.containerQty,
            title: "Cantidad de contenedores",
            choiceItems: qtyContainer
                .map((e) => S2Choice<int?>(value: e, title: e.toString()))
                .toList(),
            modalConfig: const S2ModalConfig(type: S2ModalType.bottomSheet),
            onChange: (value) {
              service.containerQty = value.choice?.value;
            },
          ),
          const Divider(),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              AsyncButtonBuilder(
                child: const Text(
                  "Guardar",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Get.back();
                  setState(() {});
                },
                builder: (context, child, callback, buttonState) {
                  return ElevatedButton.icon(
                    onPressed: callback,
                    icon: AvatarIconTitleWidget(
                      icon: Icons.save,
                      color: Colors.white,
                    ),
                    label: child,
                    style:
                    ElevatedButton.styleFrom(backgroundColor: successColor),
                  );
                },
              )
            ],
          )
        ],
      ),
      backgroundColor: Get.theme.dialogBackgroundColor,
    );
  }

  showLines(BuildContext context, List<ServiceLineShowDto>? lines) {
    return ListView.separated(
        itemCount: lines!.length,
        itemBuilder: (context, index)
    {
      final line = lines[index];
      return Wrap(
        alignment: WrapAlignment.center,
        children: [
          ListTile(
            leading: AvatarIconTitleWidget(icon: FontAwesome.cube_solid),
            dense: true,
            title: const Text("Cantidad: "),
            subtitle: Text(line.quantity != null
                ? "${line.quantity} ${line.uomName}"
                : "Sin definir"),
          )
        ],
      );
    },
    separatorBuilder: (context, index) {
      final line = lines[index];
      if (line == lines.first) {
        return Card(
          elevation: 10,
          child: SizedBox(
            height: Adaptive.h(10),
            child: ListTile(
              leading: AvatarIconTitleWidget(
                icon: FontAwesome.info_solid,
              ),
              dense: true,
              title: Text("Detalle de linea ${index + 1}"),
            ),
          ),
        );
      }
      else {
        return SizedBox(height: Adaptive.h(10));
      }
    });
  }
}