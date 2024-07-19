import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AvatarIconTitleWidget extends StatelessWidget {
  IconData? icon;
  Color? color;

  AvatarIconTitleWidget({super.key, required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Adaptive.px(10)),
      child: Icon(
        icon,
        color: color ?? Get.theme.iconTheme.color,
      ),
    );
  }
}
