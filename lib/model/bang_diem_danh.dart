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
}
