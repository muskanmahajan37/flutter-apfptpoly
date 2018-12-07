import 'dart:convert';

class BangDiemDanh {
  final String tenMon;
  final String tongVang;
  final String phanTramVang;
  final String maMon;
  final String lop;
  final List<DiemDanh> dsDiemDanh;

  const BangDiemDanh({
    this.tenMon = "",
    this.tongVang = "",
    this.phanTramVang = "",
    this.maMon = "",
    this.lop = "",
    this.dsDiemDanh = const [],
  });

  BangDiemDanh.fromJson(Map<String, dynamic> json)
      : tenMon = json["tenMon"],
        tongVang = json["tongVang"],
        phanTramVang = json["phanTramVang"],
        maMon = json["maMon"],
        lop = json["lop"],
        dsDiemDanh = json["dsDiemDanh"]
            .map<DiemDanh>((diemDanh) => DiemDanh.fromJson(diemDanh))
            .toList();

  Map<String, dynamic> toJson() => {
        "tenMon": tenMon,
        "tongVang": tongVang,
        "phanTramVang": phanTramVang,
        "maMon": maMon,
        "lop": lop,
        "dsDiemDanh": dsDiemDanh.map((diemDanh) => diemDanh.toJson()).toList(),
      };

  static List<BangDiemDanh> toList(String dsBangDiemDanh) {
    try {
      final dsBangDiemDanhJson = json.decode(dsBangDiemDanh);
      return dsBangDiemDanhJson
          .map((jsonLich) => BangDiemDanh.fromJson(jsonLich))
          .toList();
    } catch (error) {
      print("BangDiemDanh - " + error.toString());
      return <BangDiemDanh>[];
    }
  }

  static String toListString(List<BangDiemDanh> dsBangDiemDanh) {
    try {
      final dsBangDiemDanhJson =
          dsBangDiemDanh.map((lich) => lich.toJson()).toList();
      return json.encode(dsBangDiemDanhJson);
    } catch (error) {
      print("BangDiemDanh - " + error.toString());
      return "";
    }
  }
}

class DiemDanh {
  final String baiHoc;
  final String ngay;
  final String ca;
  final String nguoiDiemDanh;
  final String moTa;
  final String trangThai;
  final String ghiChu;

  const DiemDanh({
    this.baiHoc = "",
    this.ngay = "",
    this.ca = "",
    this.nguoiDiemDanh = "",
    this.moTa = "",
    this.trangThai = "",
    this.ghiChu = "",
  });

  DiemDanh.fromJson(Map<String, dynamic> json)
      : baiHoc = json["baiHoc"],
        ngay = json["ngay"],
        ca = json["ca"],
        nguoiDiemDanh = json["nguoiDiemDanh"],
        moTa = json["moTa"],
        trangThai = json["trangThai"],
        ghiChu = json["ghiChu"];

  Map<String, dynamic> toJson() => {
        "baiHoc": baiHoc,
        "ngay": ngay,
        "ca": ca,
        "nguoiDiemDanh": nguoiDiemDanh,
        "moTa": moTa,
        "trangThai": trangThai,
        "ghiChu": ghiChu,
      };
}
