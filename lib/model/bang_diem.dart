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
}
