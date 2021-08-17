class PackageModel {
  final int? pID;
   String pName;
  final String? iDesc;
  final int? Item_Id;
  final double Price;
  final int? Qty;
  final double Discounted_Rate;
  final double? Amount;
  final double? Package_Discount;

  PackageModel({this.pID,  required this.pName, this.iDesc,this.Item_Id,required this.Price,this.Qty,required this.Discounted_Rate,this.Amount,this.Package_Discount,});

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      pID: json["PackageID"],
      pName: json["PackageName"],
      iDesc: json["Item_Desc"],
      Item_Id: json["Item_Id"],
      Price: json["Price"],
      Qty: json["Qty"],
      Discounted_Rate: json["Discounted_Rate"],
      Amount: json["Amount"],
      Package_Discount: json["Package_Discount"],
    );
  }

  static List<PackageModel> fromJsonList(List list) {
    return list.map((item) => PackageModel.fromJson(item)).toList();
  }

  @override
  String toString() => "$pName";


  @override
  operator ==(o) => o is PackageModel && o.pID == pID;

  @override
  int get hashCode => Price.hashCode ^ pName.hashCode ^ Discounted_Rate.hashCode;
}