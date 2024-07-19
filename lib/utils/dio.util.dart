import 'package:app_vm/constants/constants.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import '../preferences/user.preferences.dart';

class DioUtil {
  static final dio = createDio();

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(days: 1),
      receiveTimeout: const Duration(days: 1),
    ));
    dio.interceptors.add(AppInterceptor(dio));
    dio.interceptors.add(TalkerDioLogger());
    return dio;
  }
}

class AppInterceptor extends Interceptor {
  Dio dio;

  AppInterceptor(this.dio);

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var byPass = [endpointAuth, endpointRefreshToken];
    if (!byPass.contains(options.path)) {
      var token = await UserPreferences.get('token');
      if (token != null && JwtDecoder.isExpired(token)) {
        var refreshToken = await UserPreferences.get('refreshToken');
        if (refreshToken != null) {
          try {
            var response = await dio.post(
              endpointRefreshToken,
              data: {
                'refreshToken': refreshToken,
              },
            );
            if (response.statusCode == 200) {
              await UserPreferences.set('token', response.data['token']);
              await UserPreferences.set(
                  'refreshToken', response.data['refreshToken']);
              options.headers['Authorization'] =
                  'Bearer ${response.data['token']}';
            }
          } catch (e) {
            print(e);
          }
        }
      } else {
        options.headers.addAll({
          "Authorization": "Bearer $token",
        });
      }
    }
    super.onRequest(options, handler);
  }
}
