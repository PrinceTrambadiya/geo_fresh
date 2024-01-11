/*
class BusinessmanModel {
  String fullAddress;
  String companyName;
  String email;
  String fullName;
  String gender;
  String gstNo;
  String lastName;
  String panNo;
  String phoneNo;
  String productInterest;
  String userId;
  String passbookImage;
  String idProofImage;
  String otherRegistrationNo = '';
  String website = '';
  String dateOfBirth;
  String pinCode;
  String district;
  String tehsil;
  String state;
  String photoIdNo;
  String photoIdType;
  String companyRegAddress;
  String registrationType;
  String alternatePhoneNo;
  String accountName;
  String bankName;
  String accountNo;
  String ifscCode;

  BusinessmanModel({
    this.fullAddress = '',
    this.companyName = '',
    this.email = '',
    this.fullName = '',
    this.gender = 'male',
    this.gstNo = '',
    this.lastName = '',
    this.panNo = '',
    this.phoneNo = '',
    this.productInterest = '',
    this.userId = '',
    this.otherRegistrationNo = '',
    this.idProofImage,
    this.passbookImage,
    this.website = '',
    this.state = '',
    this.tehsil = '',
    this.district = '',
    this.companyRegAddress = '',
    this.alternatePhoneNo = '',
    this.photoIdType = '',
    this.pinCode = '',
    this.dateOfBirth = '',
    this.registrationType = 'seller',
    this.photoIdNo = '',
    this.accountName = '',
    this.accountNo = '',
    this.bankName = '',
    this.ifscCode = '',
  });

  factory BusinessmanModel.fromJson(Map<String, dynamic> json) {
    return BusinessmanModel(
      fullAddress: json['address'],
      companyName: json['business_name'],
      email: json['email'],
      fullName: json['first_name'],
      gender: json['gender'],
      gstNo: json['gst_no'],
      lastName: json['last_name'],
      panNo: json['pan_no'],
      phoneNo: json['phone_no'],
      productInterest: json['product_interest'],
      userId: json['user_id'],
      website: json['website'],
      idProofImage: json['logo1'],
      passbookImage: json['business_card1'],
      state: json['state'],
      tehsil: json['tehsil'],
      district: json['district'],
      companyRegAddress: json['companyReg'],
      alternatePhoneNo: json['alternatePhoneNo'],
      photoIdType: json['photoIdType'],
      pinCode: json['pinCode'],
      dateOfBirth: json['dateOfBirth'],
      registrationType: json['roles'],
      photoIdNo: json['photoIdNo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['registrationType'] = this.registrationType;
    data['first_name'] = this.fullName;
    data['gender'] = this.gender;
    data['address'] = this.fullAddress;
    data['dateOfBirth'] = this.dateOfBirth;
    data['pinCode'] = this.pinCode;
    data['district'] = this.district;
    data['tehsil'] = this.tehsil;
    data['state'] = this.state;
    data['photo_id'] = this.photoIdNo;
    data['photoIdType'] = this.photoIdType;
    data['phone_no'] = this.phoneNo;
    data['alternate_mobile'] = this.alternatePhoneNo;
    data['email'] = this.email;
    data['business_name'] = this.companyName;
    data['company_reg'] = this.companyRegAddress;
    data['gst_no'] = this.gstNo;
    data['pan_no'] = this.panNo;
    if (data['registrationno'] != null) {
      data['registrationno'] = this.otherRegistrationNo;
    }
    if (data['website'] != null) {
      data['website'] = this.website;
    }
    data['account_name'] = this.accountName;
    data['bankName'] = this.bankName;
    data['bank_account_number'] = this.accountNo;
    data['ifsc_code'] = this.ifscCode;
    data['passbook_photo'] = this.passbookImage;
    data['scan_copy'] = this.idProofImage;

    data['last_name'] = this.lastName;

    return data;
  }
}
*/
