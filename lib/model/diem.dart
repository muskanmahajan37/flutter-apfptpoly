class Diem {
  final String tenMon;
  final String trangThai;
  final String trungBinh;
  final String maMon;
  final String lop;
  final List<ChiTietDiem> chiTiet;

  const Diem({ this.tenMon, this.trangThai, this.trungBinh, this.maMon, this.lop, this.chiTiet });
}

class ChiTietDiem {
  final String ten;
  final String trongSo;
  final String diem;
  final String ghiChu;

  const ChiTietDiem({ this.ten, this.trongSo, this.diem, this.ghiChu });
}