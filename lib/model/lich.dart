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
    this.ngay,
    this.giangDuong,
    this.maMon,
    this.giangVien,
    this.slot,
    this.thoiGian,
    this.tenMon,
    this.phong,
    this.lop,
    this.chiTiet
  });
}

class ChiTietLich {
  final String noiDung;
  final String nhiemVu;
  final String hocLieu;
  final String taiLieu;

  const ChiTietLich({ this.noiDung, this.nhiemVu, this.hocLieu, this.taiLieu });
}
