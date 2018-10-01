class Lich {
  final String slot;
  final String thoiGian;
  final String ngay;
  final String phong;
  final String lop;
  final String giangDuong;
  final String maMon;
  final String tenMon;
  final String giangVien;
  final ChiTietLich chiTiet;

  const Lich({
    this.ngay = "",
    this.giangDuong = "",
    this.maMon = "",
    this.giangVien = "",
    this.slot = "",
    this.thoiGian = "",
    this.tenMon = "",
    this.phong = "",
    this.lop = "",
    this.chiTiet = const ChiTietLich(),
  });

  Lich.fromJson(Map<String, dynamic> json)
      : slot = json["slot"],
        thoiGian = json["thoiGian"],
        ngay = json["ngay"],
        phong = json["phong"],
        lop = json["lop"],
        giangDuong = json["giangDuong"],
        maMon = json["maMon"],
        tenMon = json["tenMon"],
        giangVien = json["giangVien"],
        chiTiet = ChiTietLich.fromJson(json["chiTiet"]);

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "thoiGian": thoiGian,
        "ngay": ngay,
        "phong": phong,
        "lop": lop,
        "giangDuong": giangDuong,
        "maMon": maMon,
        "tenMon": tenMon,
        "giangVien": giangVien,
        "chiTiet": chiTiet.toJson(),
      };
}

class ChiTietLich {
  final String noiDung;
  final String nhiemVu;
  final String hocLieu;
  final String taiLieu;

  const ChiTietLich({
    this.noiDung = "",
    this.nhiemVu = "",
    this.hocLieu = "",
    this.taiLieu = "",
  });

  ChiTietLich.fromJson(Map<String, dynamic> json)
      : noiDung = json["noiDung"],
        nhiemVu = json["nhiemVu"],
        hocLieu = json["hocLieu"],
        taiLieu = json["taiLieu"];

  Map<String, dynamic> toJson() => {
        "noiDung": noiDung,
        "nhiemVu": nhiemVu,
        "hocLieu": hocLieu,
        "taiLieu": taiLieu,
      };
}
