import 'package:geo_fresh/model/PostOffice.dart';
import 'package:geo_fresh/model/bid_model.dart';

class FarmerProductModel {
  List<BidModel> bid;
  String bidId;
  String checkbox;
  String address = '';
  String landMark = '';
  String area = '';
  String pinCode = '';
  String content = '';
  String createAt = '';
  String cropCat = '';
  String cropVariety = '';
  String dates = '';
  String deliveryAddress = '';
  String district = '';
  String farmerId;
  String id;
  List<String> img;
  String isReview;
  String lat = '';
  String long = '';
  String pickUpAddress = '';
  String price = '';
  String priceType = '';
  String qcId;
  String ratting;
  String returnComment = '';
  String status;
  String taluka = '';
  String fromDate = '';
  String toDate = '';
  String title = '';
  String noOfBags = '';
  String weightPerBag = '';
  String quantity = '';
  List<PinCodeAddressModel> addressList;

  FarmerProductModel(
      {this.bid,
      this.bidId,
      this.checkbox,
      this.content,
      this.pinCode,
      this.area,
      this.address,
      this.landMark,
      this.addressList,
      this.createAt,
      this.cropCat,
      this.cropVariety,
      this.dates,
      this.deliveryAddress,
      this.district,
      this.farmerId,
      this.id,
      this.img,
      this.isReview,
      this.lat,
      this.long,
      this.pickUpAddress,
      this.price,
      this.priceType,
      this.qcId,
      this.ratting,
      this.returnComment,
      this.status,
      this.taluka,
      this.fromDate,
      this.toDate,
      this.noOfBags,
      this.quantity,
      this.weightPerBag,
      this.title});

  factory FarmerProductModel.fromJson(Map<String, dynamic> json) {
    return FarmerProductModel(
      bid: json['bid'] != null
          ? (json['bid'] as List).map((i) => BidModel.fromJson(i)).toList()
          : null,
      bidId: json['bid_id'],
      checkbox: json['checkbox'] != null ? json['checkbox'] : null,
      content: json['content'],
      createAt: json['create_at'],
      cropCat: json['crop_cat'] != null ? json['crop_cat'] : null,
      cropVariety: json['crop_veriety'] != null ? json['crop_veriety'] : null,
      dates: json['dates'] != null ? json['dates'] : null,
      deliveryAddress:
          json['delivery_address'] != null ? json['delivery_address'] : null,
      district: json['district'] != null ? json['district'] : null,
      farmerId: json['farmer_id'],
      id: json['id'],
      img: json['img'] != null ? new List<String>.from(json['img']) : null,
      isReview: json['is_review'],
      lat: json['lat'] != null ? json['lat'] : null,
      long: json['long'] != null ? json['long'] : null,
      pickUpAddress:
          json['pick_up_address'] != null ? json['pick_up_address'] : null,
      price: json['price'],
      priceType: json['price_type'],
      qcId: json['qc_id'],
      ratting: json['ratting'],
      returnComment: json['return_comment'],
      status: json['status'],
      taluka: json['taluka'] != null ? json['taluka'] : null,
      title: json['title'],
      fromDate: json['fromdate'],
      quantity: json['quantity'],
      toDate: json['todate'],
      weightPerBag: json['weight_per_kg'],
      noOfBags: json['no_of_bags'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bid_id'] = this.bidId;
    data['content'] = this.content;
    data['create_at'] = this.createAt;
    data['farmer_id'] = this.farmerId;
    data['id'] = this.id;
    data['is_review'] = this.isReview;
    data['price'] = this.price;
    data['price_type'] = this.priceType;
    data['qc_id'] = this.qcId;
    data['ratting'] = this.ratting;
    data['return_comment'] = this.returnComment;
    data['status'] = this.status;
    data['title'] = this.title;
    data['fromdate'] = this.fromDate;
    data['quantity'] = this.quantity;
    data['todate'] = this.toDate;
    data['weight_per_kg'] = this.weightPerBag;
    data['no_of_bags'] = this.noOfBags;
    if (this.bid != null) {
      data['bid'] = this.bid.map((v) => v.toJson()).toList();
    }
    if (this.checkbox != null) {
      data['checkbox'] = this.checkbox;
    }
    if (this.cropCat != null) {
      data['crop_cat'] = this.cropCat;
    }
    if (this.cropVariety != null) {
      data['crop_veriety'] = this.cropVariety;
    }
    if (this.dates != null) {
      data['dates'] = this.dates;
    }
    if (this.deliveryAddress != null) {
      data['delivery_address'] = this.deliveryAddress;
    }
    if (this.district != null) {
      data['district'] = this.district;
    }
    if (this.img != null) {
      data['img'] = this.img;
    }
    if (this.lat != null) {
      data['lat'] = this.lat;
    }
    if (this.long != null) {
      data['long'] = this.long;
    }
    if (this.pickUpAddress != null) {
      data['pick_up_address'] = this.pickUpAddress;
    }
    if (this.taluka != null) {
      data['taluka'] = this.taluka;
    }
    return data;
  }
}
