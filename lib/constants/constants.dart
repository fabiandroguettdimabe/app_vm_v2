import 'package:app_vm/constants/dto/type.event.dto.dart';

const String apiUrl = String.fromEnvironment('API_URL');
const String baseUrl = "$apiUrl/api/v1";

const List<int> qtyContainer = [0, 1, 2, 3, 4];

const List<String> allowedFiles = [
  'pdf',
  'xlsx',
  'xls',
  'doc',
  'docx',
  'jpg',
  'jpeg',
  'png'
];

List<TypeEventDto>? getTypesEventReason = [
  TypeEventDto(id: 1, name: "Cancelar", type: TypeEventEnum.CANCELLED),
  TypeEventDto(id: 2, name: "Liberar", type: TypeEventEnum.RELEASED),
  TypeEventDto(id: 3, name: "Observacion", type: TypeEventEnum.OBSERVATION),
];
