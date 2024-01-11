class PinCodeAddressModel {
  String block;
  String branchType;
  String circle;
  String country;
  String deliveryStatus;
  String description;
  String district;
  String division;
  String name;
  String pinCode;
  String region;
  String state;

  PinCodeAddressModel(
      {this.block,
      this.branchType,
      this.circle,
      this.country,
      this.deliveryStatus,
      this.description,
      this.district,
      this.division,
      this.name,
      this.pinCode,
      this.region,
      this.state});

  factory PinCodeAddressModel.fromJson(Map<String, dynamic> json) {
    return PinCodeAddressModel(
      block: json['Block'],
      branchType: json['BranchType'],
      circle: json['Circle'],
      country: json['Country'],
      deliveryStatus: json['DeliveryStatus'],
      description: json['Description'] != null ? json['Description'] : null,
      district: json['District'],
      division: json['Division'],
      name: json['Name'],
      pinCode: json['Pincode'],
      region: json['Region'],
      state: json['State'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['block'] = this.block;
    data['branchType'] = this.branchType;
    data['circle'] = this.circle;
    data['country'] = this.country;
    data['deliveryStatus'] = this.deliveryStatus;
    data['district'] = this.district;
    data['division'] = this.division;
    data['name'] = this.name;
    data['pincode'] = this.pinCode;
    data['region'] = this.region;
    data['state'] = this.state;
    if (this.description != null) {
      data['description'] = this.description;
    }
    return data;
  }
}
