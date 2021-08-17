class VehicleModel {
  final int? id;
  String name;
  final String? code;

  VehicleModel({this.id,  required this.name, this.code});

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json["Id"],
      name: json["Name"],
      code: json["Code"],
    );
  }

  static List<VehicleModel> fromJsonList(List list) {
    return list.map((item) => VehicleModel.fromJson(item)).toList();
  }

  @override
  String toString() => "$name";

  @override
  operator ==(o) => o is VehicleModel && o.id == id;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ code.hashCode;
}