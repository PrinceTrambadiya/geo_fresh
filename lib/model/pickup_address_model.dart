class PickUpAddressModel {
  String userId;
  String itemId;
  String pickUpAddress;
  String landmark;
  String pincode;
  String district;
  String taluka;
  String state;

  PickUpAddressModel(
      {this.userId,
      this.itemId,
      this.pickUpAddress,
      this.landmark,
      this.pincode,
      this.district,
      this.taluka,
      this.state});

  factory PickUpAddressModel.fromJson(Map<String, dynamic> json) {
    return PickUpAddressModel(
        userId: json['user_id'],
        itemId: json['item_id'],
        pickUpAddress: json['pick_up_address'],
        landmark: json['landmark'],
        pincode: json['pincode'],
        taluka: json['taluka'],
        state: json['state']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['user_id'] = this.userId;
    data['item_id'] = this.itemId;
    data['pick_up_address'] = this.pickUpAddress;
    data['landmark'] = this.landmark;
    data['pincode'] = this.pincode;
    data['taluka'] = this.taluka;
    data['state'] = this.state;
    return data;
  }
}
