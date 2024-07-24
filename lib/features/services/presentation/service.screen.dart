import 'dart:io';

import 'package:app_vm/constants/constants.dart';
import 'package:app_vm/constants/dto/type.event.dto.dart';
import 'package:app_vm/constants/widgets/avatar.icon.title.widget.dart';
import 'package:app_vm/features/documents/application/document.service.dart';
import 'package:app_vm/features/documents/application/document.type.service.dart';
import 'package:app_vm/features/documents/domain/document.dto.dart';
import 'package:app_vm/features/documents/domain/document.type.dto.dart';
import 'package:app_vm/features/event_reasons/application/event.reason.service.dart';
import 'package:app_vm/features/event_reasons/domain/event.reason.dto.dart';
import 'package:app_vm/features/services/application/dispatch.guide.service.dart';
import 'package:app_vm/features/services/application/service.service.dart';
import 'package:app_vm/features/services/domain/guide.number.dto.dart';
import 'package:app_vm/features/services/domain/service.dto.dart';
import 'package:app_vm/preferences/user.preferences.dart';
import 'package:app_vm/theme/color.config.dart';
import 'package:app_vm/utils/choice.util.dart';
import 'package:app_vm/utils/log.util.dart';
import 'package:async_builder/async_builder.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select_clone/flutter_awesome_select.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:number_editing_controller/number_editing_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:path/path.dart' as path;
import 'package:badges/badges.dart' as badges;

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
        child: Text('Error: $error, $stackTrace'),
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
                                Theme.of(context).iconTheme.color ??
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Card(
                  elevation: 10,
                  child: ListTile(
                    leading: AvatarIconTitleWidget(
                        icon: FontAwesome.list_check_solid),
                    title: const Text(
                      "Detalle del viaje",
                    ),
                  ),
                ),
              ),
              const Divider(),
              Padding(
                  padding: const EdgeInsets.all(30),
                  child: showLines(context, value.lines)),
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
                  onPressed: () async {
                    if (value.destinyLocation!.latitude != null &&
                        value.destinyLocation!.longitude != null) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return AsyncBuilder(
                            future: getMaps(
                              showMapType: ShowMapType.directions,
                              location: Coords(value.destinyLocation!.latitude!,
                                  value.destinyLocation!.longitude!),
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
                  },
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
                  onPressed: () async {
                    Get.bottomSheet(
                      showAddEventReason(context, value),
                      backgroundColor: Get.theme.dialogBackgroundColor,
                      isScrollControlled: true,
                    );
                  },
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
                  onPressed: () async {
                    if (value.state == 2) {
                      showFinishBottomSheet(context, value);
                    } else {
                      var truckId = await UserPreferences.getInt('truckId');
                      var log = await createLog();
                      var finish = ServiceFinishDto(
                          serviceId: value.id,
                          truckId: truckId,
                          finishLog: log);
                      await ServiceService.finishService(finish);
                    }
                  },
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
                      Theme.of(context).iconTheme.color ?? Colors.black,
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: lines!.length,
      itemBuilder: (context, index) {
        final line = lines[index];
        return Wrap(
          alignment: WrapAlignment.center,
          children: [
            ListTile(
              leading: AvatarIconTitleWidget(
                icon: FontAwesome.info_solid,
              ),
              dense: true,
              title: Text("Detalle de linea ${index + 1}"),
            ),
            const Divider(),
            ListTile(
              leading: AvatarIconTitleWidget(icon: FontAwesome.cube_solid),
              dense: true,
              title: const Text("Cantidad: "),
              subtitle: Text(line.quantity != null
                  ? "${line.quantity} ${line.uomName}"
                  : "Sin definir"),
            ),
            ListTile(
              leading: AvatarIconTitleWidget(icon: Mdi.weightKilogram),
              dense: true,
              title: const Text("Pesaje: "),
              subtitle: Text(line.weightQuantity != null
                  ? "${line.weightQuantity} Kg"
                  : "Sin definir"),
            ),
            ListTile(
              leading: AvatarIconTitleWidget(icon: FontAwesome.tag_solid),
              dense: true,
              title: const Text("Guía: "),
              subtitle: Text(line.guideNumbers ?? "Sin definir"),
            ),
            const Divider(),
            Padding(
              padding: EdgeInsets.all(Adaptive.px(10)),
              child: ElevatedButton.icon(
                onPressed: () {
                  showEditInfoLine(context, line);
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text(
                  "Ingresar Información",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: secondaryColorDark,
                    minimumSize: const Size.fromHeight(50)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Adaptive.px(10)),
              child: AsyncButtonBuilder(
                child: const Text("Guías de despacho",
                    style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  Get.bottomSheet(
                      StatefulBuilder(builder: (context, setStateGuide) {
                    return Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Card(
                          elevation: 10,
                          child: ListTile(
                            leading: AvatarIconTitleWidget(
                                icon: FontAwesome.tags_solid),
                            title: const Text("Guías de Despacho"),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: AsyncButtonBuilder(
                            child: const Text(
                              "Agregar Guía",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              showAddGuideNumber(context, line, setStateGuide);
                            },
                            builder: (context, child, callback, buttonState) {
                              return ElevatedButton.icon(
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                onPressed: callback,
                                label: child,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColorDark,
                                  minimumSize: const Size.fromHeight(50),
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(),
                        showGuideNumbers(context, line),
                      ],
                    );
                  }), backgroundColor: Get.theme.dialogBackgroundColor);
                },
                builder: (context, child, callback, buttonState) {
                  return ElevatedButton.icon(
                    onPressed: callback,
                    icon:
                        const Icon(FontAwesome.tags_solid, color: Colors.white),
                    label: child,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColorDark,
                      minimumSize: const Size.fromHeight(50),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Adaptive.px(10)),
              child: AsyncButtonBuilder(
                onPressed: () async {
                  Get.bottomSheet(
                      StatefulBuilder(builder: (context, setStateDocuments) {
                    return Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Card(
                          elevation: 10,
                          child: ListTile(
                            leading: AvatarIconTitleWidget(
                                icon: FontAwesome.tags_solid),
                            title: const Text("Documentos"),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: AsyncButtonBuilder(
                            child: const Text(
                              "Agregar Documentos",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              showAddDocuments(
                                  context, line, setStateDocuments);
                            },
                            builder: (context, child, callback, buttonState) {
                              return ElevatedButton.icon(
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                onPressed: callback,
                                label: child,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColorDark,
                                  minimumSize: const Size.fromHeight(50),
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(),
                        showDocumentLine(context, line),
                      ],
                    );
                  }), backgroundColor: Get.theme.dialogBackgroundColor);
                },
                builder: (context, child, callback, buttonState) {
                  return ElevatedButton.icon(
                    onPressed: callback,
                    icon: const Icon(FontAwesome.paperclip_solid,
                        color: Colors.white),
                    label: child,
                    style: TextButton.styleFrom(
                      backgroundColor: secondaryColorDark,
                      minimumSize: const Size.fromHeight(50),
                    ),
                  );
                },
                child: const Text(
                  "Adjuntar Documentos",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  showEditInfoLine(BuildContext context, ServiceLineShowDto? line) {
    var quantityController =
        NumberEditingTextController.decimal(value: line?.quantity ?? 0);
    var weightQuantityController =
        NumberEditingTextController.decimal(value: line?.weightQuantity);
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateClient) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SafeArea(
              child: Form(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.all(
                        Adaptive.px(10),
                      ),
                      child: ListTile(
                        trailing:
                            AvatarIconTitleWidget(icon: Icons.edit_outlined),
                        title: const Text("Editar Linea"),
                        dense: true,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.all(Adaptive.px(10)),
                      child: TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        enabled: line?.canEdit ?? false,
                        decoration: InputDecoration(
                            labelText: line?.uomName ?? "Cantidad",
                            prefixIcon: AvatarIconTitleWidget(
                                icon: FontAwesome.cube_solid)),
                        onChanged: (value) {
                          if (line!.canEditWeight!) {
                            weightQuantityController.number =
                                quantityController.number;
                          }
                        },
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.all(
                        Adaptive.px(10),
                      ),
                      child: TextFormField(
                        enabled: line?.canEditWeight ?? false,
                        controller: weightQuantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Pesaje",
                          prefixIcon:
                              AvatarIconTitleWidget(icon: Mdi.weightKilogram),
                        ),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close, color: Colors.white),
                          label: const Text("Cancelar",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: errorColorDark,
                          ),
                        ),
                        AsyncButtonBuilder(
                          child: const Text(
                            "Guardar",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            var update = ServiceLineUpdateDto(
                                id: line?.id,
                                quantity: quantityController.number?.toDouble(),
                                weightQuantity: weightQuantityController.number
                                    ?.toDouble());
                            await ServiceService.updateServiceLine(update);
                            setState(() {});
                          },
                          builder: (context, child, callback, buttonState) {
                            return ElevatedButton.icon(
                                onPressed: callback,
                                icon:
                                    const Icon(Icons.save, color: Colors.white),
                                label: child,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: successColor,
                                ));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  showGuideNumbers(BuildContext context, ServiceLineShowDto? line) {
    return AsyncBuilder(
      future: DispatchGuideService.getGuidesByServiceLineId(line?.id),
      waiting: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      builder: (context, guideNumbers) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: guideNumbers!.length,
          itemBuilder: (context, index) {
            final guide = guideNumbers[index];
            return ListTile(
              leading: AvatarIconTitleWidget(icon: FontAwesome.tags_solid),
              title: Text("Guía de Despacho ${index + 1}"),
              subtitle: Text(guide.guideNumber ?? "Sin definir"),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: AvatarIconTitleWidget(
                              icon: FontAwesome.tags_solid),
                          title: const Text("Guía de Despacho"),
                          subtitle: Text(guide.guideNumber ?? "Sin definir"),
                        ),
                        const Divider(),
                        ListTile(
                          leading: AvatarIconTitleWidget(
                              icon: FontAwesome.file_pdf_solid),
                          title: const Text("Documento"),
                          subtitle: Text(guide.id.toString() ?? "Sin definir"),
                        ),
                        const Divider(),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon:
                                  const Icon(Icons.close, color: Colors.white),
                              label: const Text("Cerrar",
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: errorColorDark,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                await EasyLauncher.url(
                                    url: guide.getDocumentUrl!);
                              },
                              icon: const Icon(Icons.open_in_browser,
                                  color: Colors.white),
                              label: const Text("Abrir",
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: successColor,
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  showAddGuideNumber(
    BuildContext context,
    ServiceLineShowDto? line,
    StateSetter setStateGuide,
  ) {
    var guideNumberController = TextEditingController();
    var cameraFiles = <File>[];
    var explorerFiles = <File>[];
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateFiles) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SafeArea(
              child: Form(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.all(
                        Adaptive.px(10),
                      ),
                      child: ListTile(
                        trailing:
                            AvatarIconTitleWidget(icon: Icons.edit_outlined),
                        title: const Text("Agregar Guía de Despacho"),
                        dense: true,
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.all(Adaptive.px(10)),
                      child: TextFormField(
                        controller: guideNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Guía de Despacho",
                          prefixIcon: AvatarIconTitleWidget(
                              icon: FontAwesome.tags_solid),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: AsyncButtonBuilder(
                        child: Text(
                          "Adjuntar desde la cámara",
                          style: Get.theme.textTheme.titleSmall,
                        ),
                        onPressed: () async {
                          var result = await pickImage(ImageSource.camera);
                          if (result == null) return;
                          var file = await processFile(
                              file: result,
                              name: 'GD_${guideNumberController.text}');
                          if (file != null) {
                            setStateFiles(() {
                              cameraFiles.add(file);
                            });
                          }
                        },
                        builder: (context, child, callback, buttonState) {
                          return badges.Badge(
                            badgeContent: Text(
                              cameraFiles.length.toString(),
                              style: Get.theme.textTheme.titleSmall,
                            ),
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: secondaryColorDark,
                            ),
                            child: ElevatedButton.icon(
                              onPressed: callback,
                              label: child,
                              icon: Icon(
                                Mdi.cameraPlus,
                                color: Get.iconColor,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColorDark,
                                minimumSize: const Size.fromHeight(50),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: AsyncButtonBuilder(
                        child: Text(
                          "Adjuntar desde los archivos",
                          style: Get.theme.textTheme.titleSmall,
                        ),
                        onPressed: () async {
                          var result = await pickImage(ImageSource.gallery);
                          if (result == null) return;
                          var file = await processFile(
                              file: result,
                              name: 'GD_${guideNumberController.text}');
                          if (file != null) {
                            setStateFiles(() {
                              explorerFiles.add(file);
                            });
                          }
                        },
                        builder: (context, child, callback, buttonState) {
                          return badges.Badge(
                            badgeContent: Text(
                              explorerFiles.length.toString(),
                              style: Get.theme.textTheme.titleSmall,
                            ),
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: secondaryColorDark,
                            ),
                            child: ElevatedButton.icon(
                              onPressed: callback,
                              label: child,
                              icon: Icon(
                                Mdi.fileImagePlus,
                                color: Get.iconColor,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColorDark,
                                minimumSize: const Size.fromHeight(50),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close, color: Colors.white),
                          label: const Text("Cancelar",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: errorColorDark,
                          ),
                        ),
                        AsyncButtonBuilder(
                          child: const Text(
                            "Guardar",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            var files = cameraFiles + explorerFiles;
                            var create = GuideNumberCreateDto(
                                guideNumber: guideNumberController.text,
                                serviceLineId: line?.id);
                            await DispatchGuideService.createGuideNumber(
                                create, files);
                            Get.back();
                            setStateGuide(() {});
                          },
                          builder: (context, child, callback, buttonState) {
                            return ElevatedButton.icon(
                                onPressed: callback,
                                icon:
                                    const Icon(Icons.save, color: Colors.white),
                                label: child,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: successColor,
                                ));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  showAddDocuments(
    BuildContext context,
    ServiceLineShowDto? line,
    StateSetter setStateDocuments,
  ) {
    var guideNumberController = TextEditingController();
    var cameraFiles = <File>[];
    var explorerFiles = <File>[];
    DocumentTypeDto? documentTypeSelected;
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateFiles) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SafeArea(
              child: Form(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.all(
                        Adaptive.px(10),
                      ),
                      child: ListTile(
                        trailing:
                            AvatarIconTitleWidget(icon: Icons.edit_outlined),
                        title: const Text("Agregar Documentos"),
                        dense: true,
                      ),
                    ),
                    const Divider(),
                    selectDocumentTypes(
                        context: context,
                        onDtoChanged: (newDto) {
                          documentTypeSelected = newDto;
                        },
                        dto: documentTypeSelected),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: AsyncButtonBuilder(
                        child: Text(
                          "Adjuntar desde la cámara",
                          style: Get.theme.textTheme.titleSmall,
                        ),
                        onPressed: () async {
                          var result = await pickImage(ImageSource.camera);
                          if (result == null) return;
                          var file = await processFile(
                              file: result, name: path.basename(result.path));
                          if (file != null) {
                            setStateFiles(() {
                              cameraFiles.add(file);
                            });
                          }
                        },
                        builder: (context, child, callback, buttonState) {
                          return badges.Badge(
                            badgeContent: Text(
                              cameraFiles.length.toString(),
                              style: Get.theme.textTheme.titleSmall,
                            ),
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: secondaryColorDark,
                            ),
                            child: ElevatedButton.icon(
                              onPressed: callback,
                              label: child,
                              icon: Icon(
                                Mdi.cameraPlus,
                                color: Get.iconColor,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColorDark,
                                minimumSize: const Size.fromHeight(50),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: AsyncButtonBuilder(
                        child: Text(
                          "Adjuntar desde los archivos",
                          style: Get.theme.textTheme.titleSmall,
                        ),
                        onPressed: () async {
                          var result = await pickImage(ImageSource.gallery);
                          if (result == null) return;
                          var file = await processFile(
                              file: result, name: path.basename(result.path));
                          if (file != null) {
                            setStateFiles(() {
                              explorerFiles.add(file);
                            });
                          }
                        },
                        builder: (context, child, callback, buttonState) {
                          return badges.Badge(
                            badgeContent: Text(
                              explorerFiles.length.toString(),
                              style: Get.theme.textTheme.titleSmall,
                            ),
                            badgeStyle: badges.BadgeStyle(
                              badgeColor: secondaryColorDark,
                            ),
                            child: ElevatedButton.icon(
                              onPressed: callback,
                              label: child,
                              icon: Icon(
                                Mdi.fileImagePlus,
                                color: Get.iconColor,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColorDark,
                                minimumSize: const Size.fromHeight(50),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close, color: Colors.white),
                          label: const Text("Cancelar",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: errorColorDark,
                          ),
                        ),
                        AsyncButtonBuilder(
                          child: const Text(
                            "Guardar",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            var files = cameraFiles + explorerFiles;
                            var create = DocumentUploadCreateDto(
                              documentType: documentTypeSelected,
                              serviceLineId: line?.id,
                            );
                            await DocumentService.uploadCreate(create, files);
                            Get.back();
                            setStateDocuments(() {});
                          },
                          builder: (context, child, callback, buttonState) {
                            return ElevatedButton.icon(
                                onPressed: callback,
                                icon:
                                    const Icon(Icons.save, color: Colors.white),
                                label: child,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: successColor,
                                ));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget selectDocumentTypes(
      {BuildContext? context,
      DocumentTypeDto? dto,
      required Function(DocumentTypeDto?) onDtoChanged}) {
    return AsyncBuilder(
        future: DocumentTypeService.getDocumentTypes(),
        waiting: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
        builder: (context, list) {
          return SmartSelect.single(
            selectedValue: dto,
            choiceItems: choiceDocumentTypes(list),
            modalHeaderStyle: S2ModalHeaderStyle(
              centerTitle: true,
              textStyle: Get.theme.textTheme.titleSmall,
              actionsIconTheme: Get.theme.iconTheme,
              iconTheme: Get.theme.iconTheme,
            ),
            tileBuilder: (context, state) {
              return ListTile(
                leading: AvatarIconTitleWidget(icon: Mdi.file),
                title: dto != null
                    ? Text("Tipo de documento : ${dto!.name}")
                    : const Text("Tipo de documentos",
                        textAlign: TextAlign.start),
                dense: true,
                onTap: state.showModal,
                trailing: AvatarIconTitleWidget(icon: Icons.arrow_forward),
              );
            },
            title: "Seleccione un tipo de documento",
            modalFilter: true,
            modalFilterAuto: true,
            modalFilterHint: "Buscar",
            modalConfig: const S2ModalConfig(
              type: S2ModalType.bottomSheet,
            ),
            onChange: (value) async {
              onDtoChanged(value.value);
            },
          );
        });
  }

  showFinishBottomSheet(
      BuildContext context, ServiceShowMobileDto service) async {
    Get.bottomSheet(
        Wrap(
          children: [
            ListTile(
              leading: AvatarIconTitleWidget(icon: Mdi.truckCheckOutline),
              title: const Text("¿Desea Finalizar el viaje?"),
            ),
            const Divider(),
            const ListTile(
              title: Text("En caso contrario, deberá finalizar una"
                  " vez haya regresado al origen."),
            ),
            const Divider(),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                AsyncButtonBuilder(
                  child: const Text(
                    "No",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    var truckId = await UserPreferences.getInt('truckId');
                    var log = await createLog();
                    var destinyDone = ServiceDestinyDoneDto(
                        serviceId: service.id,
                        truckId: truckId,
                        destinyDoneLog: log);
                    await ServiceService.destinyDoneService(destinyDone);
                    setState(() {});
                  },
                  builder: (context, child, callback, buttonState) {
                    return ElevatedButton.icon(
                      onPressed: callback,
                      icon: AvatarIconTitleWidget(
                        icon: Icons.close,
                        color: Colors.white,
                      ),
                      label: child,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: errorColorDark,
                      ),
                    );
                  },
                ),
                AsyncButtonBuilder(
                  child: const Text(
                    "Si",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    var truckId = await UserPreferences.getInt('truckId');
                    var log = await createLog();
                    var finish = ServiceFinishDto(
                        serviceId: service.id,
                        truckId: truckId,
                        finishLog: log);
                    await ServiceService.finishService(finish);
                  },
                  builder: (context, child, callback, buttonState) {
                    return ElevatedButton.icon(
                      onPressed: callback,
                      icon: AvatarIconTitleWidget(
                        icon: Icons.save,
                        color: Colors.white,
                      ),
                      label: child,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: successColor,
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
        backgroundColor: Get.theme.dialogBackgroundColor);
  }

  showDocumentLine(BuildContext context, ServiceLineShowDto dto) {
    return AsyncBuilder(
      future: DocumentService.getDocuments(dto.id),
      waiting: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      builder: (context, value) {
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var document = value![index];
            return ListTile(
              leading: AvatarIconTitleWidget(icon: FontAwesome.file_pdf_solid),
              title: Text(document.name ?? "Sin definir"),
              subtitle: Text(document.id.toString()),
              onTap: () async {
                await EasyLauncher.url(url: document.getDocumentUrl!);
              },
            );
          },
          itemCount: value!.length,
        );
      },
    );
  }

  Future<File?> pickImage(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    if (image == null) return null;
    final imageTmp = File(image.path);

    return imageTmp;
  }

  Future<File?> processFile(
      {File? file, String name = '', String? eventReason = ''}) async {
    if (file == null) return null;
    if (eventReason == null) {
      name = "Evidencia";
    }
    if (name == '') {
      name = DateTime.now().toString();
    }
    String dir = path.dirname(file.path);
    String extension = path.extension(file.path);
    String newPath = path.join(dir, "$name$extension");

    File? newFile;
    if (['.jpg', '.jpeg', '.png'].contains(extension)) {
      var compressFile = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path, newPath,
          quality: 60);
      newFile = File(compressFile!.path);
    } else {
      newFile = file;
    }

    return File(newFile.path);
  }

  showAddEventReason(BuildContext context, ServiceShowMobileDto dto) {
    var eventReasonDto = EventReasonDto();
    var typeEventDto = TypeEventDto();
    TextEditingController observationController = TextEditingController();
    List<File> cameraFiles = <File>[];
    List<File> explorerFiles = <File>[];
    return StatefulBuilder(
      builder: (context, setStateReason) {
        return Wrap(
          children: [
            Card(
              elevation: 10,
              child: ListTile(
                leading: AvatarIconTitleWidget(icon: Mdi.truckCheckOutline),
                title: const Text("Registrar Evento/Comentario"),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: smartSelectTypeEvent(
                  context: context,
                  onDtoChanged: (TypeEventDto? dto) {
                    setStateReason(() {
                      typeEventDto = dto!;
                    });
                  },
                  dto: typeEventDto),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: smartSelectEventReason(
                  context: context,
                  onDtoChanged: (EventReasonDto? dto) {
                    setStateReason(() {
                      eventReasonDto = dto!;
                    });
                  },
                  dto: eventReasonDto),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: observationController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Comentario",
                  prefixIcon: AvatarIconTitleWidget(icon: Mdi.commentText),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: AsyncButtonBuilder(
                child: Text(
                  "Adjuntar desde la cámara",
                  style: Get.theme.textTheme.titleSmall,
                ),
                onPressed: () async {
                  var result = await pickImage(ImageSource.camera);
                  if (result == null) return;
                  var file = await processFile(
                      file: result, name: path.basename(result.path));
                  if (file != null) {
                    setStateReason(() {
                      cameraFiles.add(file);
                    });
                  }
                },
                builder: (context, child, callback, buttonState) {
                  return badges.Badge(
                    badgeContent: Text(
                      cameraFiles.length.toString(),
                      style: Get.theme.textTheme.titleSmall,
                    ),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: secondaryColorDark,
                    ),
                    child: ElevatedButton.icon(
                      onPressed: callback,
                      label: child,
                      icon: Icon(
                        Mdi.cameraPlus,
                        color: Get.iconColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColorDark,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: AsyncButtonBuilder(
                child: Text(
                  "Adjuntar desde los archivos",
                  style: Get.theme.textTheme.titleSmall,
                ),
                onPressed: () async {
                  var result = await pickImage(ImageSource.gallery);
                  if (result == null) return;
                  var file = await processFile(
                      file: result, name: path.basename(result.path));
                  if (file != null) {
                    setStateReason(() {
                      explorerFiles.add(file);
                    });
                  }
                },
                builder: (context, child, callback, buttonState) {
                  return badges.Badge(
                    badgeContent: Text(
                      explorerFiles.length.toString(),
                      style: Get.theme.textTheme.titleSmall,
                    ),
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: secondaryColorDark,
                    ),
                    child: ElevatedButton.icon(
                      onPressed: callback,
                      label: child,
                      icon: Icon(
                        Mdi.fileImagePlus,
                        color: Get.iconColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColorDark,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                AsyncButtonBuilder(
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    Get.back();
                  },
                  builder: (context, child, callback, buttonState) {
                    return ElevatedButton.icon(
                      onPressed: callback,
                      icon: AvatarIconTitleWidget(
                        icon: Icons.close,
                        color: Colors.white,
                      ),
                      label: child,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: errorColorDark,
                      ),
                    );
                  },
                ),
                AsyncButtonBuilder(
                  child: const Text(
                    "Guardar",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (typeEventDto.type == TypeEventEnum.CANCELLED) {
                      var log = await createLog();
                      var cancel = ServiceCancelDto(
                          reason: observationController.text,
                          cancelLog: log,
                          reasonId: eventReasonDto.id);
                      await ServiceService.cancelService(dto.id, cancel);
                    }
                    if (typeEventDto.type == TypeEventEnum.RELEASED) {
                      var log = await createLog();
                      var files = cameraFiles + explorerFiles;
                      var release = ServiceReleaseDto(
                          observation: observationController.text,
                          releaseLog: log,
                          eventReasonId: eventReasonDto.id);
                      await ServiceService.releaseService(
                          dto.id, release, files);
                    }
                  },
                  builder: (context, child, callback, buttonState) {
                    return ElevatedButton.icon(
                      onPressed: callback,
                      icon: AvatarIconTitleWidget(
                        icon: Icons.save,
                        color: Colors.white,
                      ),
                      label: child,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: successColor,
                      ),
                    );
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  smartSelectEventReason(
      {required BuildContext context,
      required Function(EventReasonDto?) onDtoChanged,
      EventReasonDto? dto}) {
    return AsyncBuilder(
      future: EventReasonService.getEventReasons(),
      waiting: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      builder: (context, value) {
        return SmartSelect.single(
          title: "Seleccione un motivo",
          selectedValue: dto,
          choiceItems: choiceEventReasons(value),
          modalHeaderStyle: S2ModalHeaderStyle(
            centerTitle: true,
            textStyle: Get.theme.textTheme.titleMedium,
            actionsIconTheme: Get.theme.iconTheme,
            iconTheme: Get.theme.iconTheme,
          ),
          tileBuilder: (context, state) {
            return ListTile(
              leading: AvatarIconTitleWidget(icon: Mdi.informationBox),
              title: dto != null && dto!.name != null
                  ? Text("Motivo de evento : ${dto!.name}")
                  : const Text("Motivo de evento", textAlign: TextAlign.start),
              dense: true,
              onTap: state.showModal,
              trailing: AvatarIconTitleWidget(icon: Icons.arrow_forward),
            );
          },
          modalConfig: const S2ModalConfig(
            type: S2ModalType.bottomSheet,
          ),
          onChange: (value) async {
            onDtoChanged(value.value);
          },
        );
      },
    );
  }

  smartSelectTypeEvent(
      {required BuildContext context,
      required Function(TypeEventDto?) onDtoChanged,
      TypeEventDto? dto}) {
    return AsyncBuilder(
      future: DocumentTypeService.getDocumentTypes(),
      waiting: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      builder: (context, value) {
        return SmartSelect.single(
          title: "Seleccione un tipo evento",
          selectedValue: dto,
          choiceItems: choiceTypeEvents(getTypesEventReason),
          modalHeaderStyle: S2ModalHeaderStyle(
            centerTitle: true,
            textStyle: Get.theme.textTheme.titleMedium,
            actionsIconTheme: Get.theme.iconTheme,
            iconTheme: Get.theme.iconTheme,
          ),
          modalConfig: const S2ModalConfig(
            type: S2ModalType.bottomSheet,
          ),
          tileBuilder: (context, state) {
            return ListTile(
              leading: AvatarIconTitleWidget(icon: Mdi.information),
              title: dto != null && dto!.name != null
                  ? Text("Tipo de evento : ${dto.name}")
                  : const Text("Tipo de evento", textAlign: TextAlign.start),
              dense: true,
              onTap: state.showModal,
              trailing: AvatarIconTitleWidget(icon: Icons.arrow_forward),
            );
          },
          onChange: (value) async {
            onDtoChanged(value.value);
          },
        );
      },
    );
  }
}
