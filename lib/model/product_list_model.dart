import 'bid_model.dart';

class ProductListModel {
  BidModel bidArr;
  String area;
  String available_quantity;
  String bid;
  String bid_id;
  String checkbox;
  String content;
  String create_at;
  String crop_cat;
  String crop_veriety;
  String delivery_address;
  String district;
  String drop_area;
  String drop_district;
  String drop_pincode;
  String drop_state;
  String drop_taluka;
  String end_date;
  String farmer_id;
  String fromdate;
  String full_address;
  String id;
  List<String> img;
  String is_review;
  String landmark;
  String lat;
  String long;
  String no_of_bags;
  String pick_up_address;
  String pincode;
  String price;
  String price_type;
  String qc_id;
  String qc_image;
  String quantity;
  String ratting;
  String receipt;
  String return_comment;
  String start_date;
  String state;
  String status;
  String taluka;
  String title;
  String todate;
  String total_receipt_price;
  String weight_per_kg;

  ProductListModel(
      {this.bidArr,
      this.area,
      this.available_quantity,
      this.bid,
      this.bid_id,
      this.checkbox,
      this.content,
      this.create_at,
      this.crop_cat,
      this.crop_veriety,
      this.delivery_address,
      this.district,
      this.drop_area,
      this.drop_district,
      this.drop_pincode,
      this.drop_state,
      this.drop_taluka,
      this.end_date,
      this.farmer_id,
      this.fromdate,
      this.full_address,
      this.id,
      this.img,
      this.is_review,
      this.landmark,
      this.lat,
      this.long,
      this.no_of_bags,
      this.pick_up_address,
      this.pincode,
      this.price,
      this.price_type,
      this.qc_id,
      this.qc_image,
      this.quantity,
      this.ratting,
      this.receipt,
      this.return_comment,
      this.start_date,
      this.state,
      this.status,
      this.taluka,
      this.title,
      this.todate,
      this.total_receipt_price,
      this.weight_per_kg});

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      bidArr:
          json['bidArr'] != null ? BidModel?.fromJson(json['bidArr']) : null,
      area: json['area'],
      available_quantity: json['available_quantity'],
      bid: json['bid'],
      bid_id: json['bid_id'],
      checkbox: json['checkbox'],
      content: json['content'],
      create_at: json['create_at'],
      crop_cat: json['crop_cat'],
      crop_veriety: json['crop_veriety'],
      delivery_address: json['delivery_address'],
      district: json['district'],
      drop_area: json['drop_area'],
      drop_district: json['drop_district'],
      drop_pincode: json['drop_pincode'],
      drop_state: json['drop_state'],
      drop_taluka: json['drop_taluka'],
      end_date: json['end_date'],
      farmer_id: json['farmer_id'],
      fromdate: json['fromdate'],
      full_address: json['full_address'],
      id: json['id'],
      img: json['img'] != null ? new List<String>.from(json['img']) : null,
      is_review: json['is_review'],
      landmark: json['landmark'],
      lat: json['lat'],
      long: json['long'],
      no_of_bags: json['no_of_bags'],
      pick_up_address: json['pick_up_address'],
      pincode: json['pincode'],
      price: json['price'],
      price_type: json['price_type'],
      qc_id: json['qc_id'],
      qc_image: json['qc_image'],
      quantity: json['quantity'],
      ratting: json['ratting'],
      receipt: json['receipt'],
      return_comment: json['return_comment'],
      start_date: json['start_date'],
      state: json['state'],
      status: json['status'],
      taluka: json['taluka'],
      title: json['title'],
      todate: json['todate'],
      total_receipt_price: json['total_receipt_price'],
      weight_per_kg: json['weight_per_kg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area'] = this.area;
    data['available_quantity'] = this.available_quantity;
    data['bid'] = this.bid;
    data['bid_id'] = this.bid_id;
    data['checkbox'] = this.checkbox;
    data['content'] = this.content;
    data['create_at'] = this.create_at;
    data['crop_cat'] = this.crop_cat;
    data['crop_veriety'] = this.crop_veriety;
    data['delivery_address'] = this.delivery_address;
    data['district'] = this.district;
    data['drop_area'] = this.drop_area;
    data['drop_district'] = this.drop_district;
    data['drop_pincode'] = this.drop_pincode;
    data['drop_state'] = this.drop_state;
    data['drop_taluka'] = this.drop_taluka;
    data['end_date'] = this.end_date;
    data['farmer_id'] = this.farmer_id;
    data['fromdate'] = this.fromdate;
    data['full_address'] = this.full_address;
    data['id'] = this.id;
    data['is_review'] = this.is_review;
    data['landmark'] = this.landmark;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['no_of_bags'] = this.no_of_bags;
    data['pick_up_address'] = this.pick_up_address;
    data['pincode'] = this.pincode;
    data['price'] = this.price;
    data['price_type'] = this.price_type;
    data['qc_id'] = this.qc_id;
    data['qc_image'] = this.qc_image;
    data['quantity'] = this.quantity;
    data['ratting'] = this.ratting;
    data['receipt'] = this.receipt;
    data['return_comment'] = this.return_comment;
    data['start_date'] = this.start_date;
    data['state'] = this.state;
    data['status'] = this.status;
    data['taluka'] = this.taluka;
    data['title'] = this.title;
    data['todate'] = this.todate;
    data['total_receipt_price'] = this.total_receipt_price;
    data['weight_per_kg'] = this.weight_per_kg;
    if (this.img != null) {
      data['img'] = this.img;
    }
    return data;
  }
}
