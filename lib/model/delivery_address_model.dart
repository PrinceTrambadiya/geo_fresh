class DeliverAddressModel {
  String userId;
  String itemId;
  String deliveryAddress;
  String landmark;
  String pincode;
  String district;
  String taluka;
  String state;

  DeliverAddressModel({
    this.userId,
    this.itemId,
    this.deliveryAddress,
    this.landmark,
    this.pincode,
    this.district,
    this.taluka,
    this.state,
  });

  factory DeliverAddressModel.fromJson(Map<String, dynamic> json) {
    return DeliverAddressModel(
      userId: json["user_id"],
      itemId: json["item_id"],
      deliveryAddress: json["delivery_address"],
      landmark: json["landmark"],
      pincode: json["pincode"],
      district: json["district"],
      taluka: json["taluka"],
      state: json["state"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["user_id"] = this.userId;
    data["item_id"] = this.itemId;
    data["delivery_address"] = this.deliveryAddress;
    data["landmark"] = this.landmark;
    data["pincode"] = this.pincode;
    data["district"] = this.district;
    data["taluka"] = this.taluka;
    data["state"] = this.state;
  }
}
