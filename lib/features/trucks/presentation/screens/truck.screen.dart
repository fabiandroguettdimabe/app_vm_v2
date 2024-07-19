import 'package:app_vm/constants/widgets/avatar.icon.title.widget.dart';
import 'package:app_vm/features/trucks/application/truck.service.dart';
import 'package:app_vm/features/trucks/domain/truck.dto.dart';
import 'package:app_vm/preferences/user.preferences.dart';
import 'package:app_vm/theme/color.config.dart';
import 'package:app_vm/utils/choice.util.dart';
import 'package:async_builder/async_builder.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_select_clone/flutter_awesome_select.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TruckScreen extends StatefulWidget {
  const TruckScreen({super.key});

  @override
  State<TruckScreen> createState() => _TruckScreenState();
}

class _TruckScreenState extends State<TruckScreen> {
  TruckDto? truckSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seleccione un camion')),
      body: truckBody(context),
    );
  }

  Widget truckBody(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        child: Container(
          width: Adaptive.w(90),
          height: Adaptive.px(450),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const ListTile(
                  leading: Icon(Icons.local_shipping),
                  title: Text(
                    "Seleccione un camion",
                    textAlign: TextAlign.center,
                  )),
              const Divider(),
              SizedBox(
                height: Adaptive.px(10),
              ),
              Padding(
                padding: EdgeInsets.all(
                  Adaptive.px(10),
                ),
                child: selectTruck(context),
              ),
              Padding(
                  padding: EdgeInsets.all(
                    Adaptive.px(10),
                  ),
                  child: AsyncButtonBuilder(
                    child: const Text(
                      "Escanear QR",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      String qrCode = await FlutterBarcodeScanner.scanBarcode(
                        "#ff6666",
                        "Cancelar",
                        true,
                        ScanMode.QR,
                      );
                      if (qrCode == "-1") {
                        Get.snackbar(
                          "Error",
                          "No se pudo escanear el codigo",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      try {
                        var result =
                            await TruckService.getTruckByPatent(qrCode);
                        if (result != null) {
                          Get.bottomSheet(Wrap(children: [
                            ListTile(
                              leading: AvatarIconTitleWidget(
                                  icon: Icons.local_shipping),
                              title: Text(
                                  "Camion: ${result.truckNumber} encontrado"),
                              subtitle: Text("Patente: ${result.patent}"),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: [
                                AsyncButtonBuilder(
                                  child: const Text("Seleccionar"),
                                  onPressed: () async {
                                    await UserPreferences.set(
                                        'truckId', result.id);
                                    await UserPreferences.set(
                                        'truckPatent', result.patent);
                                    Get.offNamed('/');
                                  },
                                  builder:
                                      (context, child, callback, buttonState) {
                                    return TextButton(
                                      onPressed: callback,
                                      child: child,
                                    );
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Cancelar"),
                                ),
                              ],
                            )
                          ]));
                        }
                      } catch (e) {
                        Get.showSnackbar(GetSnackBar(
                          title: "Error",
                          message: e.toString(),
                          snackPosition: SnackPosition.BOTTOM,
                        ));
                      }
                    },
                    builder: (context, child, callback, buttonState) {
                      return ElevatedButton.icon(
                        icon: const Icon(
                          Icons.qr_code,
                          color: Colors.white,
                        ),
                        onPressed: callback,
                        label: child,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColorDark,
                          minimumSize: Size.fromHeight(Adaptive.px(50)),
                        ),
                      );
                    },
                  )),
              const Divider(),
              Padding(
                padding: EdgeInsets.all(
                  Adaptive.px(10),
                ),
                child: AsyncButtonBuilder(
                  child: const Text(
                    "Asignar Camion",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (truckSelected == null) {
                      Get.snackbar(
                        "Error",
                        "Seleccione un camion",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }
                    await UserPreferences.set('truckId', truckSelected?.id);
                    await UserPreferences.set(
                        'truckPatent', truckSelected?.patent);
                    await UserPreferences.set(
                        'truckNumber', truckSelected?.truckNumber);
                    Get.offNamed('/');
                  },
                  builder: (context, child, callback, buttonState) {
                    return ElevatedButton.icon(
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: callback,
                      label: child,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: successColor,
                        minimumSize: Size.fromHeight(Adaptive.px(50)),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget selectTruck(BuildContext context) {
    return FutureBuilder<List<TruckDto>?>(
      future: TruckService.getTrucks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return buildSmartSelect(snapshot.data);
        }
      },
    );
  }

  Widget buildSmartSelect(List<TruckDto>? trucks) {
    return SmartSelect.single(
      selectedValue: truckSelected,
      choiceItems: choiceTrucks(trucks),
      modalHeaderStyle: S2ModalHeaderStyle(
        centerTitle: true,
        textStyle: Get.theme.textTheme.titleSmall,
        actionsIconTheme: Get.theme.iconTheme,
        iconTheme: Get.theme.iconTheme,
      ),
      tileBuilder: (context, state) {
        return ListTile(
          leading: AvatarIconTitleWidget(icon: Icons.local_shipping),
          title: Text(
            truckSelected?.patent ?? "Seleccione un camion",
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            truckSelected?.truckNumber ?? "",
            textAlign: TextAlign.center,
          ),
          dense: true,
          onTap: state.showModal,
          trailing: AvatarIconTitleWidget(icon: Icons.arrow_forward),
        );
      },
      title: "Seleccione un camion",
      modalFilter: true,
      modalFilterAuto: true,
      modalFilterHint: "Buscar",
      modalConfig: const S2ModalConfig(
        type: S2ModalType.bottomSheet,
      ),
      onChange: (value) {
        setState(() {
          truckSelected = value.value;
        });
      },
    );
  }
}
