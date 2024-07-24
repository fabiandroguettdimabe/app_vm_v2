import 'package:app_vm/constants/dto/response.dto.dart';
import 'package:app_vm/constants/endpoint.data.dart';
import 'package:app_vm/features/event_reasons/domain/event.reason.dto.dart';
import 'package:app_vm/utils/dio.util.dart';
import 'package:dio/dio.dart';

class EventReasonService {
  static Future<List<EventReasonDto>?> getEventReasons() async {
    try {
      var res = await DioUtil.dio.get(endpointEventReasons);
      if (res.statusCode != 200) return [];
      var apiResponse = ResponseListDto.fromJson(res.data);
      if (apiResponse.statusCode != 200) return [];
      return apiResponse.data!.map((e) => EventReasonDto.fromJson(e!)).toList();
    } on DioException catch (e) {
      return [];
    } catch (e) {
      return [];
    }
  }
}
