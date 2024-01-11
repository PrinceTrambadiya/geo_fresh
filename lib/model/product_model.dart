import 'dart:io';

import 'package:geo_fresh/model/PostOffice.dart';
import 'package:geo_fresh/model/dropdown_data_model.dart';

class ProductModel {
  String body = '';
  String checkbox = '';
  String cropCat = '';
  String cropVariety = '';
  String dates = '';
  List<File> images;
  String price = '';
  String priceType = '';
  String taluka = '';
  String area = '';
  String district = '';
  String fromDate = '';
  String toDate = '';
  String title = '';
  String userId = '';
  String quantity = '';
  String bags = '';
  String bagsWeight = '';
  String landMark = '';
  String pinCode = '';
  String cropId = '';
  List<DropDownDataModel> cropTitleModel;
  List<DropDownDataModel> cropVarietyModel;
  List<DropDownDataModel> cropCategoryModel;
  List<PinCodeAddressModel> addressList;
  List<String> pers;

  ProductModel(
      {this.body = '',
      this.checkbox = '',
      this.cropCat = '',
      this.cropVariety = '',
      this.dates = '',
      this.images,
      this.price = '',
      this.priceType = '',
      this.pinCode = '',
      this.taluka = '',
      this.area = '',
      this.district = '',
      this.fromDate = '',
      this.toDate = '',
      this.title = '',
      this.quantity = '',
      this.bags = '',
      this.bagsWeight = '',
      this.landMark = '',
      this.cropVarietyModel,
      this.cropCategoryModel,
      this.cropTitleModel,
      this.addressList,
      this.pers,
      this.userId = '',
      this.cropId = ''});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      body: json['body'],
      checkbox: json['checkbox'],
      cropCat: json['crop_cat'],
      cropVariety: json['crop_veriety'],
      price: json['price'],
      priceType: json['price_type'],
      taluka: json['taluka'],
      area: json['area'],
      landMark: json['landMark'],
      district: json['district'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      title: json['title'],
      userId: json['user_id'],
      quantity: json['quantity'],
      bags: json['no_of_bags'],
      bagsWeight: json['weight_per_kg'],
      pinCode: json['pincode'],
      cropId: json['crop_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['checkbox'] = this.checkbox;
    data['crop_cat'] = this.cropCat;
    data['crop_veriety'] = this.cropVariety;
    data['price'] = this.price;
    data['price_type'] = this.priceType;
    data['taluka'] = this.taluka;
    data['area'] = this.area;
    data['pincode'] = this.pinCode;
    data['landMark'] = this.landMark;
    data['district'] = this.district;
    data['fromdate'] = this.fromDate;
    data['todate'] = this.toDate;
    data['title'] = this.title;
    data['user_id'] = this.userId;
    data['quantity'] = this.quantity;
    data['no_of_bags'] = this.bags;
    data['weight_per_kg'] = this.bagsWeight;
    data['status'] = 0;
    data['crop_id'] = this.cropId;
    return data;
  }
}
