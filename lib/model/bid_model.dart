class BidModel {
  String businessName;
  String createAt;
  int id;
  int itemId;
  String title;
  String prices;
  int userId;
  int status;

  BidModel(
      {this.businessName,
      this.createAt,
      this.id,
      this.title,
      this.itemId,
      this.prices,
      this.userId,
      this.status});

  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
        businessName: json['business_name'],
        createAt: json['create_at'],
        id: json['id'],
        itemId: json['item_id'],
        prices: json['prices'],
        userId: json['user_id'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_name'] = this.businessName;
    data['create_at'] = this.createAt;
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['prices'] = this.prices;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    return data;
  }
}
