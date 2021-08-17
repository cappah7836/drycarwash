class ServiceModel {
  final int? Branch_id;
   String Branch_name;
  final int? Branch_Code;
  final String? Branch_address;
  final String? Branch_contact_no;
  final String? Created_by;
  final String? Cretaion_date;
  final String? Last_updated_by;
  final String? Last_update_date;
  final int? COMPANY_ID;
  final bool? Show_Location;
  final String? Company;


  ServiceModel({this.Branch_id, required this.Branch_name, this.Branch_Code,
    this.Branch_address,this.Branch_contact_no,this.Created_by,this.Cretaion_date,this.Last_updated_by,this.Last_update_date,
    this.COMPANY_ID,this.Show_Location, this.Company});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      Branch_id: json["Branch_id"],
      Branch_name: json["Branch_name"],
      Branch_Code: json["Branch_Code"],
      Branch_address: json["Branch_address"],
      Branch_contact_no: json["Branch_contact_no"],
      Created_by: json["Created_by"],
      Cretaion_date: json["Cretaion_date"],
      Last_updated_by: json["Last_updated_by"],
      Last_update_date: json["Last_update_date"],
      COMPANY_ID: json["COMPANY_ID"],
      Show_Location: json["Show_Location"],
      Company: json["Company"],
    );
  }

  static List<ServiceModel> fromJsonList(List list) {
    return list.map((item) => ServiceModel.fromJson(item)).toList();
  }

  @override
  String toString() => "$Branch_name";

  @override
  operator ==(o) => o is ServiceModel && o.Branch_id == Branch_id;

  @override
  int get hashCode => Branch_id.hashCode ^ Branch_name.hashCode;
}