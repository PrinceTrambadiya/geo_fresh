import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_fresh/model/PostOffice.dart';
import 'package:geo_fresh/model/delivery_address_model.dart';
import 'package:geo_fresh/model/dropdown_data_model.dart';
import 'package:geo_fresh/model/farmer_notification_model.dart';
import 'package:geo_fresh/model/pickup_address_model.dart';
import 'package:geo_fresh/model/product_list_model.dart';
import 'package:geo_fresh/model/product_model.dart';
import 'package:geo_fresh/model/user_model.dart';
import 'package:geo_fresh/user_repository.dart';
import 'package:geo_fresh/utils/constant_data.dart';
import 'package:geo_fresh/utils/utils.dart';
import 'package:http/http.dart' as http;

class AuthHelper {
  //static final String _mainUrl = "http://hdtechsolution.com";
  // static final String _mainUrl = "http://192.168.0.133:8000";
  static final String _mainUrl = "https://apps.geo-fresh.com";
  static final String _versionUrl = "/api/";
  final String _baseUrl = _mainUrl + _versionUrl;

  Map<String, dynamic> getAuthHeaderWithOutToken() {
    var header = {"Content-Type": "application/json"};
    return header;
  }

  Future<Map<String, dynamic>> getAuthHeaderWithToken() async {
    String token = await UserRepository().readSecureValue(USER_ID);
    var header = {
      "Content-Type": "application/json",
      "Authorization": "Token " + token
    };
    return header;
  }

  Future<String> getUserId() async {
    String userId = await UserRepository().readSecureValue(USER_ID);
    return userId;
  }

  var header = {
    'Content-Type': 'application/json',
  };

  Future loginWithMobile(PhoneAuthCredential phoneAuthCredential) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      return user;
    } catch (FirebaseAuthException) {
      throw (FirebaseAuthException);
    }
  }

  Future<dynamic> loginUser(String mobileNumber) async {
    String url = _baseUrl + 'auth/login';
    debugPrint("url: $url");
    var map = new Map<String, dynamic>();
    map['mobile_number'] = mobileNumber;
    var response = await http.post(Uri.parse(url), body: map);
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return responseBody;
    } else {
      return Future.error(responseBody['message']);
    }
  }

  Future<Map<String, dynamic>> checkMobileNumber(String mobileNumber) async {
    String url = _baseUrl + 'checkMobileNumber';
    debugPrint("url: $url");
    var map = new Map<String, dynamic>();
    map['mobile_no'] = mobileNumber;
    var response = await http.post(Uri.parse(url), body: map);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = {
        "statusCode": response.statusCode,
      };
      return result;
    } else if (response.statusCode == 202) {
      Map<String, dynamic> result = {
        "statusCode": response.statusCode,
        "isRegistered": responseBody['data']['is_register'],
      };
      return result;
    } else {
      return Future.error(responseBody['message']);
    }
  }

  Future<dynamic> createNewUser(String mobileNumber) async {
    String url = _baseUrl + 'createNewRegistration';
    debugPrint("url: $url");
    var map = new Map<String, dynamic>();
    map['mobile_no'] = mobileNumber;
    var response = await http.post(Uri.parse(url), body: map);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return responseBody['data'];
    } else {
      return Future.error(responseBody['message']);
    }
  }

  Future<dynamic> setRole(String lan, String roles) async {
    String url = _baseUrl + 'setRoles';
    debugPrint("url: $url");
    String userId = await UserRepository().readSecureValue(USER_ID);
    var map = new Map<String, dynamic>();
    map['user_id'] = userId;
    map['lang'] = lan;
    map['roles'] = roles;
    var response = await http.post(Uri.parse(url), body: map);
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200 || response.statusCode == 202) {
      return responseBody;
    } else {
      return Future.error(responseBody['message']);
    }
  }

  Future<dynamic> addFarmerRegistration(UserModel userModel) async {
    String url = _baseUrl + 'saveFarmerDetails';
    debugPrint("url: $url");
    var map = userModel.toJsonFarmer();
    Map<String, String> headers = {'Content-Type': 'application/json'};
    // var response = await http.post(url, body: map);
    // var responseBody = jsonDecode(response.body);
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.headers.addAll(headers);
    map.forEach((k, v) {
      request.fields[k] = v.toString();
    });

    if (!userModel.scanCopy.contains("http")) {
      if (userModel.scanCopy != null && userModel.scanCopy != "") {
        request.files.add(
            await http.MultipartFile.fromPath("scan_copy", userModel.scanCopy));
      }
    }
    if (!userModel.passbookImage.contains("http")) {
      if (userModel.passbookImage != null && userModel.passbookImage != "") {
        request.files.add(await http.MultipartFile.fromPath(
            "passbook_photo", userModel.passbookImage));
      }
    }

    /* if (userModel.scanCopy != null) {
      request.files.add(
          await http.MultipartFile.fromPath("scan_copy", userModel.scanCopy));
    }
    if (userModel.passbookImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
          "passbook_photo", userModel.passbookImage));
    }*/

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    try {
      var json = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        return json['data'];
      } else {
        return Future.error(json['message']);
      }
    } catch (e) {
      return Future.error("Registration Exception $e");
    }
  }

  Future<dynamic> addBusinessmanRegistration(UserModel userModel) async {
    String url = _baseUrl + 'saveBusinessDetails';
    debugPrint("url: $url");
    userModel.userId = await getUserId();
    var map = userModel.toJsonBusinessman();

    // var response = await http.post(url, body: map);
    // var responseBody = jsonDecode(response.body);
    var request = http.MultipartRequest("POST", Uri.parse(url));
    map.forEach((k, v) {
      request.fields[k] = v.toString();
    });

    if (!userModel.scanCopy.contains("http")) {
      if (userModel.scanCopy != null && userModel.scanCopy != "") {
        request.files.add(
            await http.MultipartFile.fromPath("scan_copy", userModel.scanCopy));
      }
    }
    if (!userModel.passbookImage.contains("http")) {
      if (userModel.passbookImage != null && userModel.passbookImage != "") {
        request.files.add(await http.MultipartFile.fromPath(
            "passbook_photo", userModel.passbookImage));
      }
    }

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    var json = jsonDecode(responseBody);
    if (response.statusCode == 200) {
      return json['data'];
    } else {
      return Future.error(json['message']);
    }
  }

  Future<dynamic> getFarmerDetails() async {
    String userId = await getUserId();
    String url = _baseUrl + 'farmerDetails?id=$userId';
    debugPrint("url: $url");
    var response = await http.get(Uri.parse(url));
    var responseBody = jsonDecode(response.body);
    UserModel frameModel = responseBody['data'] != null
        ? UserModel.fromJson(responseBody['data'])
        : null;
    if (response.statusCode == 200) {
      return frameModel;
    } else {
      return Future.error(responseBody['message']);
    }
  }

  Future<dynamic> getBusinessManDetails() async {
    String userId = await getUserId();
    String url = _baseUrl + 'businessDetails?id=$userId';
    //debugPrint("url: $url");
    var response = await http.get(Uri.parse(url));
    var responseBody = jsonDecode(response.body);
    UserModel frameModel = responseBody['data'] != null
        ? UserModel.fromJson(responseBody['data'])
        : null;
    if (response.statusCode == 200) {
      return frameModel;
    } else {
      return Future.error(responseBody['message']);
    }
  }

  Future<dynamic> checkUserStatus() async {
    String userId = await getUserId();
    String url = _baseUrl + 'getUserStatus?user_id=$userId';
    debugPrint("url: $url");
    var response = await http.Client().get(Uri.parse(url));
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return responseBody['data'];
    } else {
      return Future.error(responseBody['message']);
    }
  }

  /* Future<dynamic> getPickUpAddress({String item_id}) async {
    String userId = await getUserId();
    String url = _baseUrl + 'getPickUpAddress?item_id=$item_id&user_id=$userId';
    var response = await http.Client().get(Uri.parse(url));
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return responseBody['data'];
    } else {
      return Future.error(responseBody['message']);
    }
  }*/

  Future<dynamic> addFarmerProduct(ProductModel productModel) async {
    String url = _baseUrl + 'saveNewItem';
    debugPrint("url: $url");
    productModel.userId = await getUserId();
    var map = productModel.toJson();
    var request = http.MultipartRequest("POST", Uri.parse(url));

    map.forEach((k, v) {
      request.fields[k] = v.toString();
    });

    for (int i = 0; i < productModel.images.length; i++) {
      request.files.add(await http.MultipartFile.fromPath(
          'image[]', productModel.images[i].path));
    }
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    var json = jsonDecode(responseBody);
    if (response.statusCode == 200) {
      return json['data'];
    } else {
      return Future.error(json['message']);
    }
  }

  Future<List<PinCodeAddressModel>> getPinCodeData(String pinCode) async {
    String url = "https://api.postalpincode.in/pincode/" + '$pinCode';
    var response = await http.get(Uri.parse(url));
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<PinCodeAddressModel> addressList =
          responseBody[0]['PostOffice'] != null
              ? (responseBody[0]['PostOffice'] as List)
                  .map((i) => PinCodeAddressModel.fromJson(i))
                  .toList()
              : null;
      return addressList;
    } else {
      return Future.error(responseBody['message']);
    }
  }

  Future<List<DropDownDataModel>> getProductTitle() async {
    String url = _baseUrl + 'productTitleList';
    //debugPrint("url: $url");
    var response = await http.get(Uri.parse(url));
    var responseBody = jsonDecode(response.body);
    List<DropDownDataModel> frameModel = responseBody['data'] != null
        ? (responseBody['data'] as List)
            .map((i) => DropDownDataModel.fromJson(i))
            .toList()
        : null;
    if (response.statusCode == 200) {
      return frameModel;
    } else {
      return Future.error(responseBody['message']);
    }
  }

/*  Future<dynamic> getProductCategory() async {
    String url = _baseUrl + 'productVarietyList';
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    List<DropDownDataModel> frameModel = responseBody['data'] != null
        ? (responseBody['data'] as List)
            .map((i) => DropDownDataModel.fromJson(i))
            .toList()
        : null;
    if (response.statusCode == 200) {
      return frameModel;
    } else {
      return Future.error(responseBody['message']);
    }
  }*/

  /* Future<dynamic> getProductVariety() async {
    String url = _baseUrl + 'productCatList';
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);
    List<DropDownDataModel> frameModel = responseBody['data'] != null
        ? (responseBody['data'] as List)
            .map((i) => DropDownDataModel.fromJson(i))
            .toList()
        : null;
    if (response.statusCode == 200) {
      return frameModel;
    } else {
      return Future.error(responseBody['message']);
    }
  }*/

  Future<List<ProductListModel>> getAllProductListForBusinessman() async {
    String userId = await getUserId();
    String url = _baseUrl + 'allItems?user_id=$userId';
    debugPrint("url: $url");
    var response = await http.get(Uri.parse(url));
    var responseBody = jsonDecode(response.body);
    List<ProductListModel> frameModel = responseBody['data'] != null
        ? (responseBody['data'] as List)
            .map((i) => ProductListModel.fromJson(i))
            .toList()
        : null;
    if (response.statusCode == 200) {
      return frameModel;
    } else {
      return Future.error(responseBody['message']);
    }
  }

  Future<dynamic> createBid(String itemId, String bidPrice) async {
    String url = _baseUrl + 'createBid';
    debugPrint("url: $url");
    String userId = await UserRepository().readSecureValue(USER_ID);
    var map = new Map<String, dynamic>();
    map['user_id'] = userId;
    map['item_id'] = itemId;
    map['bid_price'] = bidPrice;

    http.Response response = await http.post(Uri.parse(url), body: map);
    var responseBody = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      showToast(message: "Bid Success");
      return responseBody;
    } else {
      //showErrorToastBottom(msg: "You have already bid");
      return Future.error(responseBody['message']);
    }
  }

  Future<List<FarmerProductModel>> getFarmerItems() async {
    String userId = await getUserId();
    String url = _baseUrl + 'farmerItems?user_id=$userId';
    debugPrint("url: $url");
    var response = await http.get(Uri.parse(url));

    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List<FarmerProductModel> frameModel = responseBody['data'] != null
          ? (responseBody['data'] as List)
              .map((i) => FarmerProductModel.fromJson(i))
              .toList()
          : null;
      return frameModel;
    } else {
      return Future.error(responseBody['message']);
    }
  }

  Future<PickUpAddressModel> addEditAddress(Map<String, dynamic> data) async {
    String url = _baseUrl + "addEditPickUpAddress";
    var map = new Map<String, dynamic>();
    var headers = getAuthHeaderWithOutToken();
    var _data = jsonEncode(data);
    //debugPrint("Data ==> $_data");
    final response =
        await http.post(Uri.parse(url), body: _data, headers: headers);

    //debugPrint("Response: $response");
    if (response.statusCode == 200) {
      //debugPrint("Status Code ==> ${response.statusCode}");
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      PickUpAddressModel addressModel =
          PickUpAddressModel.fromJson(responseBody['data']);
      return addressModel;
    }
  }

  Future<DeliverAddressModel> addDeliveryAddress(
      Map<String, dynamic> data) async {
    String url = _baseUrl + "addEditDeliveryAddress";
    var headers = getAuthHeaderWithOutToken();
    var _data = jsonEncode(data);
    debugPrint("Data ==> $_data");
    final response =
        await http.post(Uri.parse(url), body: _data, headers: headers);

    debugPrint("Response: $response");

    if (response.statusCode == 200) {
      debugPrint("Status Code ==> ${response.statusCode}");
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      DeliverAddressModel addressModel =
          DeliverAddressModel.fromJson(responseBody['data']);
      return addressModel;
    }
  }

  /* Future<dynamic> getQCCertificateDetail() async {
   // String itemId = await getItemId();
    String url = _baseUrl + 'getCertificate?id=$itemId';
    var response = await http.get(Uri.parse(url));
    var responseBody = jsonDecode(response.body);
    QcCerificateModel qcCerificateModel = responseBody['data'] != null
        ? QcCerificateModel.fromJson(responseBody['data'])
        : null;
    if (response.statusCode == 200) {
      return qcCerificateModel;
    } else {
      return Future.error(responseBody['message']);
    }
  }*/
}
