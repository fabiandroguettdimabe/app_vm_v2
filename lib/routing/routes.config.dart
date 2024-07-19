import 'package:app_vm/features/auth/presentation/login.screen.dart';
import 'package:app_vm/features/home/presentation/home.screen.dart';
import 'package:app_vm/features/services/presentation/new.service.screen.dart';
import 'package:app_vm/features/services/presentation/service.screen.dart';
import 'package:app_vm/features/trucks/presentation/screens/truck.screen.dart';
import 'package:app_vm/preferences/user.preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

appRoutes() => [
      GetPage(
        name: '/login',
        page: () => const LoginScreen(),
      ),
      GetPage(
        name: '/',
        page: () => const HomeScreen(),
      ),
      GetPage(
        name: '/select-truck',
        page: () => const TruckScreen(),
      ),
      GetPage(
        name: '/new-service',
        page: () => const NewServiceScreen(),
      ),
      GetPage(
        name: '/service',
        page: () => const ServiceScreen(),
      ),
    ];

class AppMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    var token = await UserPreferences.get('token');
    if (token == null || JwtDecoder.isExpired(token)) {
      return Get.rootDelegate.toNamed('/login');
    }

    return await super.redirectDelegate(route);
  }

  @override
  redirect(String? route) {
    var token = UserPreferences().getStringSync('token');
    var truck = UserPreferences().getIntSync('truckId');

    if (token == null && route != '/login') {
      return const RouteSettings(name: '/login');
    }
    if (truck == null && route != '/trucks') {
      return const RouteSettings(name: '/trucks');
    }
    if (token!.isNotEmpty && route == '/login') {
      return const RouteSettings(name: '/');
    }
    if (JwtDecoder.isExpired(token)) {
      return const RouteSettings(name: '/login');
    }
    if (truck != null && route == '/trucks') {
      return const RouteSettings(name: '/');
    }

    return super.redirect(route);
  }
}
