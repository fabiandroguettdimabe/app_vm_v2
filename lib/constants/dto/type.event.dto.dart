class TypeEventDto {
  int? id;
  String? name;
  TypeEventEnum? type;

  TypeEventDto({
    this.id,
    this.name,
    this.type,
  });
}

enum TypeEventEnum {
  CANCELLED,
  RELEASED,
  OBSERVATION,
}