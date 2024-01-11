import 'package:geo_fresh/utils/constant_data.dart';

class UserModel {
  String fullAddress;
  String fullName;
  String gender;
  String lastName;
  String dateOfBirth;
  String pinCode;
  String district;
  String tehsil;
  String state;
  String photoIdNo;
  String photoIdType;
  String companyName;
  String companyRegAddress;
  String registrationType;
  String registrationCategory;
  String phoneNo;
  String alternatePhoneNo;
  String userId;
  String email;
  String passbookImage;
  String scanCopy;
  String accountName;
  String bankName;
  String accountNo;
  String ifscCode;
  String gstNo;
  String panNo;
  String productInterest;
  String idProofImage;
  String otherRegistrationNo = '';
  String website = '';

  UserModel({
    this.fullAddress = '',
    this.fullName = '',
    this.gender = 'male ',
    this.lastName = '',
    this.photoIdNo = '',
    this.phoneNo = '',
    this.state = '',
    this.pinCode = '',
    this.district = '',
    this.companyName = '',
    this.companyRegAddress = '',
    this.dateOfBirth = '',
    this.photoIdType = '',
    this.tehsil = '',
    this.email = '',
    this.registrationCategory = FARMER,
    this.registrationType = 'seller',
    this.alternatePhoneNo = '',
    this.userId,
    this.scanCopy,
    this.passbookImage,
    this.ifscCode,
    this.accountNo,
    this.bankName,
    this.accountName,
    this.gstNo = '',
    this.panNo = '',
    this.productInterest = '',
    this.otherRegistrationNo = '',
    this.idProofImage,
    this.website = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullAddress: json['address'].toString(),
      fullName: json['first_name'].toString(),
      gender: json['gender'].toString(),
      phoneNo: json['phone_no'].toString(),
      userId: json['user_id'].toString(),
      pinCode: json['pincode'].toString(),
      district: json['district'].toString(),
      companyName: json['company_name'].toString(),
      companyRegAddress: json['company_reg'].toString(),
      dateOfBirth: json['dob'].toString(),
      photoIdType: json['photo_id_type'].toString(),
      tehsil: json['tehsil'].toString(),
      email: json['email'].toString(),
      registrationCategory: json['register_category'].toString(),
      registrationType: json['register_type'].toString(),
      alternatePhoneNo: json['alternate_mobile'].toString(),
      state: json['state'].toString(),
      scanCopy: json['scan_copy'].toString(),
      passbookImage: json['passbook_photo'].toString(),
      accountName: json['account_name'].toString(),
      accountNo: json['bank_account_number'].toString(),
      bankName: json['bank_name'].toString(),
      ifscCode: json['ifsc_code'].toString(),
      photoIdNo: json['photo_id'].toString(),
      gstNo: json['gst_no'].toString(),
      lastName: json['last_name'].toString(),
      panNo: json['pan_no'].toString(),
      productInterest: json['product_interest'].toString(),
      website: json['website'].toString(),
      idProofImage: json['logo1'].toString(),
      otherRegistrationNo: json['registrationno'].toString(),
    );
  }

  Map<String, dynamic> toJsonFarmer() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['register_type'] = this.registrationType;
    data['register_category'] = this.registrationCategory;
    data['first_name'] = this.fullName;
    data['last_name'] = this.fullName;
    data['gender'] = this.gender;
    data['address'] = this.fullAddress;
    data['dob'] = this.dateOfBirth;
    data['pincode'] = this.pinCode;
    data['district'] = this.district;
    data['tehsil'] = this.tehsil;
    data['state'] = this.state;
    data['photo_id'] = this.photoIdNo;
    data['photo_id_type'] = this.photoIdType;
    data['phone_no'] = this.phoneNo;
    data['alternate_mobile'] = this.alternatePhoneNo;
    data['email'] = this.email;
    data['company_name'] = this.companyName;
    data['company_reg'] = this.companyRegAddress;
    data['account_name'] = this.accountName;
    data['bank_name'] = this.bankName;
    data['bank_account_number'] = this.accountNo;
    data['ifsc_code'] = this.ifscCode;
    data['adhar_no'] = "";
    data['pan_no'] = "";
    data["area"] = "";
    data['passbook_photo'] = this.passbookImage;
    data['scan_copy'] = this.scanCopy;
    data['registrationno'] = this.otherRegistrationNo;

    // data['last_name'] = this.lastName;
    // data['pan_no'] = this.photoIdNo;

    return data;
  }

  // user_id: 255
  // register_type: seller
  // register_category: group
  // first_name: test test
  // last_name: test test
  // gender: male
  // address: wgwgs hshs
  // dob: 1999-05-05
  // pincode: 382350
  // district: Ahmedabad
  // tehsil: Ahmedabad City
  // state: Gujarat
  // photo_id: brtiojshsn
  // photo_id_type: hahagab
  // phone_no: +919998333150
  // alternate_mobile: 123456789
  // email: tegegs@gmail.com
  // company_name: test hahab
  // company_reg: test
  // account_name: hshahab
  // bank_name: jahahah
  // bank_account_number: 12345
  // ifsc_code: 11
  // adhar_no:
  // pan_no:

  Map<String, dynamic> toJsonBusinessman() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['register_type'] = this.registrationType;
    data['first_name'] = this.fullName;
    data['last_name'] = this.fullName;
    data['gender'] = this.gender;
    data['address'] = this.fullAddress;
    data['dob'] = this.dateOfBirth;
    data['pincode'] = this.pinCode;
    data['district'] = this.district;
    data['tehsil'] = this.tehsil;
    data['state'] = this.state;
    data['photo_id'] = this.photoIdNo;
    data['photo_id_type'] = this.photoIdType;
    data['phone_no'] = this.phoneNo;
    data['alternate_mobile'] = this.alternatePhoneNo;
    data['email'] = this.email;
    data['company_name'] = this.companyName;
    data['company_reg'] = this.companyRegAddress;
    data['gst_no'] = this.gstNo;
    data['pan_no'] = this.panNo;
    if (this.otherRegistrationNo != null) {
      data['registrationno'] = this.otherRegistrationNo;
    }
    if (this.website != null) {
      data['website'] = this.website;
    }
    data['account_name'] = this.accountName;
    data['bank_name'] = this.bankName;
    data['bank_account_number'] = this.accountNo;
    data['ifsc_code'] = this.ifscCode;
    data['passbook_photo'] = this.passbookImage;
    data['scan_copy'] = this.idProofImage;
    data["area"] = "";
    return data;
  }
}
