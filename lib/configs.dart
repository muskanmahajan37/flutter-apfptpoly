import 'model/campus.dart';

const kBorderRadius = 999.0;
const kUserAgent = "Mozilla/5.0 (Linux; Android 7.0; SM-G930V Build/NRD90M) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36";

const kCampuses = <Campus>[
  Campus(id: 1, name: 'Hà Nội'),
  Campus(id: 2, name: 'Đà Nẵng'),
  Campus(id: 3, name: 'HCM'),
  Campus(id: 4, name: 'T.Nguyên'),
  Campus(id: 10, name: 'C.Thơ')
];

class LoginStatus {
  static const finishedChoosingCampus = "http://ap.poly.edu.vn/index.php";
  static const startLogin = "https://accounts.google.com/o/oauth2/auth?client_id=";
  static const loginFailed = "msg=Login%20failed!";
  static const wrongAccount = "msg=You%20are%20not%20connected%20to%20Google%20with%20account%20fpt.edu.vn%20%20or%20your%20session%20has%20expired";
  static const authDone = "http://ap.poly.edu.vn/hybridauth/?hauth.done=Google";
  static const loginSuccess = "http://ap.poly.edu.vn/students/index.php";
}