import 'package:app_vm/features/auth/application/auth.service.dart';
import 'package:app_vm/features/auth/domain/login.dto.dart';
import 'package:app_vm/preferences/user.preferences.dart';
import 'package:app_vm/theme/color.config.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var _passwordVisible = false;
  var _userController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: Adaptive.px(100),
              ),
              SizedBox(
                height: Adaptive.px(30),
              ),
              Card(
                elevation: 10,
                child: Container(
                  width: Adaptive.w(90),
                  padding: EdgeInsets.all(Adaptive.px(40)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Adaptive.px(20),
                    ),
                  ),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        const ListTile(
                            title: Text(
                          "Iniciar Sesión",
                          textAlign: TextAlign.center,
                        )),
                        const Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: Adaptive.px(20),
                        ),
                        TextFormField(
                          controller: _userController,
                          decoration: const InputDecoration(
                            labelText: 'Usuario',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.badge),
                            counterText: '',
                          ),
                          maxLength: 10,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'El usuario es requerido';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: Adaptive.px(20),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            border: const OutlineInputBorder(),
                            labelText: 'Contraseña',
                            hintText: 'Contraseña',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Adaptive.px(20),
                        ),
                        AsyncButtonBuilder(
                          child: const Text(
                            'Ingresar',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            var loginData = LoginRequestDto(
                                vat: _userController.text,
                                password: _passwordController.text);
                            var result = await AuthService.login(loginData);
                            if (result) {
                              Get.offNamed('/select-truck');
                            }
                          },
                          builder: (context, child, callback, buttonState) {
                            var buttonColor = buttonState.when(
                                idle: () => successColor,
                                loading: () => successColor,
                                success: () => successColor,
                                error: (error, stackTrace) =>
                                    secondaryColorDark);
                            return ElevatedButton.icon(
                              icon: const Icon(
                                Icons.login,
                                color: Colors.white,
                              ),
                              onPressed: callback,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                minimumSize: const Size.fromHeight(50),
                              ),
                              label: child,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AsyncButtonBuilder(
                          child: const Text("Ingresar con QR",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            String barcode =
                                await FlutterBarcodeScanner.scanBarcode(
                                    "#ECEFF1",
                                    "Cancelar",
                                    true,
                                    ScanMode.BARCODE);
                            bool result = await AuthService.loginQR(barcode);
                            if (result) {
                              Get.offNamed('/select-truck');
                            }

                          },
                          builder: (context, child, callback, buttonState) {
                            var buttonColor = buttonState.when(
                                idle: () => primaryColorDark,
                                loading: () => primaryColorDark,
                                success: () => primaryColorDark,
                                error: (error, stackTrace) =>
                                    secondaryColorDark);
                            return ElevatedButton.icon(
                              icon: const Icon(
                                Icons.qr_code,
                                color: Colors.white,
                              ),
                              onPressed: callback,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                minimumSize: const Size.fromHeight(50),
                              ),
                              label: child,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
