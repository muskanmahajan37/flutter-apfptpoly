class DiemDanh {
  final String tenMon;
  final String tongVang;
  final String phanTramVang;
  final String maMon;
  final String lop;
  final List<ChiTietDiemDanh> chiTiet;

  const DiemDanh({ this.tenMon, this.tongVang, this.phanTramVang, this.maMon, this.lop, this.chiTiet });
}

class ChiTietDiemDanh {
  final String baiHoc;
  final String ngay;
  final String ca;
  final String nguoiDiemDanh;
  final String moTa;
  final String trangThai;
  final String ghiChu;

  const ChiTietDiemDanh({ this.baiHoc, this.ngay, this.ca, this.nguoiDiemDanh, this.moTa, this.trangThai, this.ghiChu });
}