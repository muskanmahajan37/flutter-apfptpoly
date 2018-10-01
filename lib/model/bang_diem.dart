class BangDiem {
  final String tenMon;
  final String maMon;
  final String lop;
  final String trangThai;
  final String trungBinh;
  final List<Diem> dsDiem;

  const BangDiem({
    this.tenMon = "",
    this.trangThai = "",
    this.trungBinh = "",
    this.maMon = "",
    this.lop = "",
    this.dsDiem = const [],
  });

  BangDiem.fromJson(Map<String, dynamic> json)
    : tenMon = json["tenMon"],
      maMon = json["maMon"],
      lop = json["lop"],
      trangThai = json["trangThai"],
      trungBinh = json["trungBinh"],
      dsDiem = json["dsDiem"].map<Diem>((diem) => Diem.fromJson(diem)).toList();

  Map<String, dynamic> toJson() =>
      {
        "tenMon": tenMon,
        "maMon": maMon,
        "lop": lop,
        "trangThai": trangThai,
        "trungBinh": trungBinh,
        "dsDiem": dsDiem.map((diem) => diem.toJson()).toList(),
      };
}

class Diem {
  final String ten;
  final String trongSo;
  final String diem;
  final String ghiChu;

  const Diem({
    this.ten = "",
    this.trongSo = "",
    this.diem = "",
    this.ghiChu = "",
  });

  Diem.fromJson(Map<String, dynamic> json)
    : ten = json["ten"],
      trongSo = json["trongSo"],
      diem = json["diem"],
      ghiChu = json["ghiChu"];

  Map<String, dynamic> toJson() =>
      {
        "ten": ten,
        "trongSo": trongSo,
        "diem": diem,
        "ghiChu": ghiChu,
      };
}
