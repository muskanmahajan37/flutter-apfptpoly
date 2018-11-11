import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../configs.dart';
import '../model/bang_diem.dart';
import '../model/bang_diem_danh.dart';
import '../model/lich.dart';
import '../model/sinh_vien.dart';
import '../model/term.dart';
import '../utils/app_settings.dart';
import '../utils/cookie_handler.dart';

class ApTask {
  static final kRegexDate = new RegExp(r"Slot (.+) \(từ (.+):00 đến (.+):00\)");
  static final kRegexDiemDanhTitle = new RegExp(r"(.+?) \((.+?)\) - (.+)");
  static final kRegexDiemTitle = new RegExp(r".+?: (.+?) \((.+?)\) - (.+)");

  AppSettings appSettings;
  final CookieHandler cookieHandler = new CookieHandler();
  final Dio dio = new Dio(new Options(
      followRedirects: true, connectTimeout: 9999999, receiveTimeout: 9999999));

  static ApTask _instance;

  static Future<ApTask> getInstance() async {
    if (_instance == null) {
      _instance = new ApTask();

      // Setup app settings
      _instance.appSettings = await AppSettings.getInstance();

      // Setup cookies handler
      await _instance.cookieHandler.setupStorage();

      // Setup dio
      CookieJar cookieJar = new CookieJar();
      cookieJar.saveFromResponse(Uri.parse("https://wwww.google.com"),
          _instance.cookieHandler.readCookiesList("https://wwww.google.com"));
      cookieJar.saveFromResponse(Uri.parse("http://ap.poly.edu.vn"),
          _instance.cookieHandler.readCookiesList("http://ap.poly.edu.vn"));
      _instance.dio.cookieJar = cookieJar;
    }

    return _instance;
  }

  static Future<String> registerAccount(String email, String cookies) async {
    // Push cookies info to server to push every 12-mins to AP
    // To increase the expired date of the cookies
    // You can check out the server's source code: https://github.com/scitbiz/apfptpoly-server
    ApTask apTask = await getInstance();
    Response<String> response = await apTask.dio
        .post(Urls.auth, data: {'username': email, 'cookie': cookies});
    return response.data;
  }

  static Future<SinhVien> getSinhVien() async {
    final ApTask apTask = await getInstance();

    final Response response =
        await apTask.dio.get("http://ap.poly.edu.vn/students/index.php");
    final String body = response.data;
    final Document document = parse(body);

    final eUserInfo = document.querySelector("#personal_info");
    final eTds = eUserInfo.querySelectorAll("#user_details table td");

    if (eTds.length >= 39) {
      final hoTen =
          "${eTds[3].text.trim()} ${eTds[5].text.trim()} ${eTds[7].text.trim()}";
      final SinhVien sinhVien = SinhVien(
          avatar: eUserInfo.querySelector("img").attributes["src"],
          tenDangNhap: eTds[1].text.trim(),
          hoTen: hoTen,
          maSinhVien: eTds[9].text.trim(),
          gioiTinh: eTds[11].text.trim(),
          ngaySinh: eTds[13].text.trim(),
          email: eTds[15].text.trim(),
          diaChi: eTds[17].text.trim(),
          khoa: eTds[19].text.trim(),
          nganh: eTds[21].text.trim(),
          chuyenNganh: eTds[23].text.trim(),
          noiDungDaoTao: eTds[25].text.trim(),
          cmnd: eTds[27].text.trim(),
          ngayCap: eTds[29].text.trim(),
          noiCap: eTds[31].text.trim(),
          ngayNhapHoc: eTds[33].text.trim(),
          heDaoTao: eTds[35].text.trim(),
          trangThai: eTds[37].text.trim(),
          kyThu: eTds[39].text.trim());

      apTask.appSettings.sinhVien = sinhVien;
      return sinhVien;
    }
    return SinhVien();
  }

  static Future<List<Lich>> getLich() async {
    ApTask apTask = await getInstance();
    final Response response = await apTask.dio.post(Urls.lich,
        options: Options(
          contentType: ContentType("application", "x-www-form-urlencoded"),
        ),
        data: {"num_of_day": apTask.appSettings.period});
    final String body = response.data;
    final Document document = parse(body);

    final eTrs = document.querySelectorAll("#example tbody tr");
    final eChiTiets = document.querySelectorAll("div[role=dialog]");

    final dsLich = eTrs.map((eTr) {
      final List<Element> eTds = eTr.querySelectorAll("td");
      final Element eChiTiet = eChiTiets[eTrs.indexOf(eTr)];

      if (eTds.length >= 8) {
        ChiTietLich chiTietLich = ChiTietLich();
        final String date = eTds[7].text.trim();
        final Match splittedDate = kRegexDate.allMatches(date).elementAt(0);

        if (eChiTiet.localName == "div") {
          final eDivs =
              eChiTiet.querySelectorAll("div[class='large-8 columns']");
          chiTietLich = ChiTietLich(
              noiDung: eDivs[0].text.trim(),
              nhiemVu: eDivs[1].text.trim(),
              hocLieu: eDivs[2].text.trim(),
              taiLieu: eDivs[3].text.trim());
        }

        return Lich(
            isTestDay: eTds[0].text.contains("(if not passed)"),
            ngay: eTds[0]
                .text
                .replaceAll("ngày ", "")
                .replaceAll(" (if not passed)", "")
                .trim(),
            phong: eTds[1].text.trim(),
            giangDuong: eTds[2].text.trim(),
            maMon: eTds[3].text.trim(),
            tenMon: eTds[4].text.trim(),
            lop: eTds[5].text.trim(),
            giangVien: eTds[6].text.trim(),
            slot: splittedDate[1],
            thoiGian: "${splittedDate[2]}-${splittedDate[3]}",
            chiTiet: chiTietLich);
      }

      return Lich();
    }).toList();

    apTask.appSettings.dsLich = dsLich;
    return dsLich;
  }

  static Future<List<BangDiemDanh>> getDsBangDiemDanh() async {
    ApTask apTask = await getInstance();
    final requestData = apTask.appSettings.selectedTermValue == null
        ? null
        : {"term_id": apTask.appSettings.selectedTermValue};

    final Response response =
        await apTask.dio.get(Urls.diemDanh, data: requestData);
    final String body = response.data;
    final Document document = parse(body);

    final eDsTenMonHoc = document.querySelectorAll("h5.subheader");
    final eDsBang = document.querySelectorAll("table");

    final dsBangDiemDanh = eDsBang.map((eBang) {
      final tenMonHoc = eDsTenMonHoc[eDsBang.indexOf(eBang)];
      final eTrs = eBang.querySelectorAll("tbody tr");
      final eFoot = eBang.querySelectorAll("th font[color=red]");

      final Match monHoc =
          kRegexDiemDanhTitle.allMatches(tenMonHoc.text.trim()).elementAt(0);

      if (monHoc != null && monHoc.groupCount >= 3) {
        final List<DiemDanh> dsDiemDanh = eTrs.map((eTr) {
          final eTds = eTr.querySelectorAll("td");

          return eTds.length >= 7
              ? DiemDanh(
                  baiHoc: eTds[0].text.trim(),
                  ngay: eTds[1].text.split(" - ")[0].trim(),
                  ca: eTds[2].text.trim(),
                  nguoiDiemDanh: eTds[3].text.trim(),
                  moTa: eTds[4].text.trim(),
                  trangThai: eTds[5].text.trim(),
                  ghiChu: eTds[6].text.trim(),
                )
              : DiemDanh();
        }).toList();

        return BangDiemDanh(
          tenMon: monHoc[1].trim(),
          maMon: monHoc[2].trim(),
          lop: monHoc[3].trim(),
          tongVang: eFoot[0].text.split(" ")[0].trim(),
          phanTramVang: eFoot[0].text.split(" ")[1].trim(),
          dsDiemDanh: dsDiemDanh,
        );
      }

      return BangDiemDanh();
    }).toList();

    apTask.appSettings.dsBangDiemDanh = dsBangDiemDanh;
    return dsBangDiemDanh;
  }

  static Future<List<BangDiem>> getDsBangDiem() async {
    ApTask apTask = await getInstance();
    final requestData = apTask.appSettings.selectedTermValue == null
        ? null
        : {"term_id": apTask.appSettings.selectedTermValue};
    final Response response =
        await apTask.dio.get(Urls.diem, data: requestData);
    final String body = response.data;
    final Document document = parse(body);

    final eDsTenMonHoc = document.querySelectorAll("h5.subheader");
    final eDsBang = document.querySelectorAll("table");

    final dsBangDiem = eDsBang.map((eBang) {
      final tenMonHoc = eDsTenMonHoc[eDsBang.indexOf(eBang)];
      final eTrs = eBang.querySelectorAll("tbody tr");
      final eFoot = eBang.querySelector("tfoot");

      final Match monHoc =
          kRegexDiemTitle.allMatches(tenMonHoc.text.trim()).elementAt(0);

      if (monHoc != null && monHoc.groupCount >= 3) {
        final List<Diem> dsDiem = eTrs.map((eTr) {
          final eTds = eTr.querySelectorAll("td");

          return eTds.length >= 5
              ? Diem(
                  ten: eTds[1].text.trim(),
                  trongSo: eTds[2].text.trim(),
                  diem: eTds[3].text.trim(),
                  ghiChu: eTds[4].text.trim(),
                )
              : Diem();
        }).toList();

        return BangDiem(
          tenMon: monHoc[1].trim(),
          maMon: monHoc[2].trim(),
          lop: monHoc[3].trim(),
          trungBinh: eFoot.querySelector("th b font").text.trim(),
          trangThai: eFoot.querySelector("th font b").text.trim(),
          dsDiem: dsDiem,
        );
      }

      return BangDiem();
    }).toList();
    apTask.appSettings.dsBangDiem = dsBangDiem;
    return dsBangDiem;
  }

  static Future<List<Term>> getTerms() async {
    ApTask apTask = await getInstance();
    final requestData = apTask.appSettings.selectedTermValue == null
        ? null
        : {"term_id": apTask.appSettings.selectedTermValue};
    final Response response =
        await apTask.dio.get(Urls.diemDanh, data: requestData);
    final String body = response.data;
    final Document document = parse(body);

    final eTerms = document.querySelectorAll("#term_id option");
    final currentTerm =
        document.querySelector("#term_id option[selected]").attributes["value"];

    final List<Term> terms = eTerms.reversed.map((term) {
      return Term(int.parse(term.attributes["value"]), term.text);
    }).toList();

    apTask.appSettings.terms = terms;
    if (apTask.appSettings.selectedTermValue == null) {
      apTask.appSettings.selectedTermValue = int.parse(currentTerm);
    }

    return terms;
  }
}
