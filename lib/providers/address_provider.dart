import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  String _fullAddress = "";
  String _landMark = "";
  String _pinCode = "";
  String _district = "";
  String _tehsil = "";
  String _state = "";
  String title = "";

  set fullAddress(String value) {
    _fullAddress = value;
    notifyListeners();
  }

  set landMark(String value) {
    _landMark = value;
    notifyListeners();
  }

  set pinCode(String value) {
    _pinCode = value;
    notifyListeners();
  }

  set district(String value) {
    _district = value;
    notifyListeners();
  }

  set tehsil(String value) {
    _tehsil = value;
    notifyListeners();
  }

  set state(String value) {
    _state = value;
    notifyListeners();
  }

  String get fullAddress => _fullAddress;
  String get landMark => _landMark;
  String get pinCode => _pinCode;
  String get district => _district;
  String get tehsil => _tehsil;
  String get state => _state;

  String getAddress() {
    if (fullAddress != '' &&
        landMark != '' &&
        pinCode != '' &&
        district != '' &&
        tehsil != '' &&
        state != '') {
      return fullAddress +
          " " +
          landMark +
          " " +
          tehsil +
          " " +
          district +
          " " +
          state +
          " " +
          pinCode;
    }
    return '';
  }

  setAllValueEmpty() {
    fullAddress = '';
    landMark = '';
    tehsil = '';
    district = '';
    state = '';
    pinCode = '';
  }
}
