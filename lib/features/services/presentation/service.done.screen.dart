import 'package:app_vm/constants/widgets/avatar.icon.title.widget.dart';
import 'package:app_vm/features/services/application/service.service.dart';
import 'package:app_vm/features/services/domain/service.dto.dart';
import 'package:app_vm/theme/color.config.dart';
import 'package:async_builder/async_builder.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:getwidget/getwidget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ServiceDoneScreen extends StatefulWidget {
  const ServiceDoneScreen({super.key});

  @override
  State<ServiceDoneScreen> createState() => _ServiceDoneScreenState();
}

class _ServiceDoneScreenState extends State<ServiceDoneScreen> {
  int? month;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    month = DateTime.now().month;
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder(
      future: ServiceService.getFinishedService(month),
      waiting: (context) => const Center(child: CircularProgressIndicator()),
      error: (context, error, stackTrace) =>
          Center(child: Text('Error: $error')),
      builder: (context, data) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Servicios finalizados'),
          ),
          body: ListView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              AsyncButtonBuilder(
                child: const Text(
                  "Seleccione por periodo",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  var result = await showMonthPicker(
                    context: context,
                    initialDate: DateTime.now(),
                    dismissible: true,
                    locale: const Locale('es'),
                  );
                  if (result == null) return;
                  setState(() {
                    month = result.month;
                  });
                },
                builder: (context, child, callback, buttonState) {
                  return Padding(
                    padding: EdgeInsets.all(Adaptive.px(10)),
                    child: ElevatedButton(
                      onPressed: callback,
                      style: TextButton.styleFrom(
                          backgroundColor: secondaryColorDark,
                          minimumSize: const Size.fromHeight(50)),
                      child: child,
                    ),
                  );
                },
              ),
              if (data == null)
                const Center(
                  child: Text('No hay servicios finalizados'),
                )
              else
                _buildList(data as List<ServiceFinishedDto>)
            ],
          ),
        );
      },
    );
  }

  Widget _buildList(List<ServiceFinishedDto>? data) {
    return ListView.builder(
      itemCount: data?.length,
      shrinkWrap: true,
      controller: _scrollController,
      itemBuilder: (context, index) {
        var service = data?[index];
        return Column(
          children: [
            buildServiceCard(service!),
          ],
        );
      },
    );
  }

  Card buildServiceCard(ServiceFinishedDto service) {
    return Card(
      elevation: 0,
      child: Wrap(
        children: [
          ListTile(
            leading:
                AvatarIconTitleWidget(icon: FontAwesome.truck_moving_solid),
            title: Text("Servicio : N° ${service.id}" ?? "",
                style: TextStyle(
                    color: primaryColorLight, fontWeight: FontWeight.bold)),
            dense: true,
            subtitle: Text(service.description ?? ""),
          ),
          GFCard(
            padding: const EdgeInsets.all(0),
            elevation: 0,
            title: const GFListTile(
                avatar: Icon(Icons.info), title: Text("Detalle del servicio")),
            content: buildServiceDetails(service),
          ),
        ],
      ),
    );
  }

  Wrap buildServiceDetails(ServiceFinishedDto service) {
    return Wrap(
      children: [
        buildServiceDetail(
            service.clientName ?? "", FontAwesome.building, "Cliente: "),
        buildServiceDetail(service.collectionMethodName ?? "", Mdi.accountCash,
            "¿Que traslada?: "),
        buildServiceDetail(
            service.journeyTypeName ?? "", Mdi.trainCar, "Tipo de viaje : "),
      ],
    );
  }

  Padding buildServiceDetail(String detail, IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ListTile(
        leading: AvatarIconTitleWidget(icon: icon),
        dense: true,
        title: Text(title),
        subtitle: Text(detail),
      ),
    );
  }
}
