import 'package:flutter/material.dart';
import 'model/campus.dart';

const kUserAgent = "Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) "
    "AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/59.0.3071.125 Mobile Safari/537.36";

const Duration kSplashTimeout = Duration(seconds: 1);

class Urls {
  static const ap = "http://ap.poly.edu.vn";
  static const main = "$ap/students/index.php";
  static const chooseCampus = "$ap/choose_campus.php";
  static const login = "$ap/hlogin.php?provider=Google";

  static const authServer = "http://apfptpoly.herokuapp.com";
  static const auth = "$authServer/auth";

  static const thongTinSinhVien = main;
  static const lich = "$main?router=lichhoc";
  static const diemDanh = "$main?router=diemdanh";
  static const diem = "$main?router=diemtheoky";
}

class LoginStatus {
  static const finishedChoosingCampus = "${Urls.ap}/index.php";
  static const startLogin =
      "https://accounts.google.com/signin/oauth/identifier?client_id";
  static const loginFailed = "msg=Login%20failed!";
  static const wrongAccount =
      "msg=You%20are%20not%20connected%20to%20Google%20with%20account%20fpt.edu.vn%20%20or%20your%20session%20has%20expired";
  static const authDone = "${Urls.ap}/hybridauth/?hauth.done=Google";
  static const loginSuccess = Urls.main;
  static const feedback = "${Urls.ap}/feedback";
}

const kBorderRadius = 999.0;

const kMainCardBoxDecoration = BoxDecoration(
  color: Color.fromRGBO(0, 0, 0, 0.1),
  borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
);

final TextStyle kModalTitleTextStyle =
    TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6), fontWeight: FontWeight.bold);

const kCampuses = <Campus>[
  Campus(id: 1, name: 'Hà Nội'),
  Campus(id: 2, name: 'Đà Nẵng'),
  Campus(id: 3, name: 'HCM'),
  Campus(id: 4, name: 'T.Nguyên'),
  Campus(id: 10, name: 'C.Thơ')
];

const kPeriods = <Period>[
  Period(title: "7 ngày tới", value: 7),
  Period(title: "14 ngày tới", value: 14),
  Period(title: "30 ngày tới", value: 30),
  Period(title: "90 ngày tới", value: 90),
  Period(title: "7 ngày trước", value: -7),
  Period(title: "14 ngày trước", value: -14),
  Period(title: "30 ngày trước", value: -30),
  Period(title: "90 ngày trước", value: -90),
];

class Period {
  final String title;
  final int value;

  const Period({this.title, this.value});
}
