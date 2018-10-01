class SinhVien {
  final String avatar;
  final String tenDangNhap;
  final String hoTen;
  final String maSinhVien;
  final String gioiTinh;
  final String ngaySinh;
  final String email;
  final String diaChi;
  final String khoa;
  final String nganh;
  final String chuyenNganh;
  final String noiDungDaoTao;
  final String cmnd;
  final String ngayCap;
  final String noiCap;
  final String ngayNhapHoc;
  final String heDaoTao;
  final String trangThai;
  final String kyThu;

  const SinhVien({
    this.avatar = "",
    this.tenDangNhap = "",
    this.hoTen = "",
    this.maSinhVien = "",
    this.gioiTinh = "",
    this.ngaySinh = "",
    this.email = "",
    this.diaChi = "",
    this.khoa = "",
    this.nganh = "",
    this.chuyenNganh = "",
    this.noiDungDaoTao = "",
    this.cmnd = "",
    this.ngayCap = "",
    this.noiCap = "",
    this.ngayNhapHoc = "",
    this.heDaoTao = "",
    this.trangThai = "",
    this.kyThu = "",
  });

  SinhVien.fromJSON(Map<String, dynamic> json)
      : avatar = json["avatar"],
        tenDangNhap = json["tenDangNhap"],
        hoTen = json["hoTen"],
        maSinhVien = json["maSinhVien"],
        gioiTinh = json["gioiTinh"],
        ngaySinh = json["ngaySinh"],
        email = json["email"],
        diaChi = json["diaChi"],
        khoa = json["khoa"],
        nganh = json["nganh"],
        chuyenNganh = json["chuyenNganh"],
        noiDungDaoTao = json["noiDungDaoTao"],
        cmnd = json["cmnd"],
        ngayCap = json["ngayCap"],
        noiCap = json["noiCap"],
        ngayNhapHoc = json["ngayNhapHoc"],
        heDaoTao = json["heDaoTao"],
        trangThai = json["trangThai"],
        kyThu = json["kyThu"];

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "tenDangNhap": tenDangNhap,
        "hoTen": hoTen,
        "maSinhVien": maSinhVien,
        "gioiTinh": gioiTinh,
        "ngaySinh": ngaySinh,
        "email": email,
        "diaChi": diaChi,
        "khoa": khoa,
        "nganh": nganh,
        "chuyenNganh": chuyenNganh,
        "noiDungDaoTao": noiDungDaoTao,
        "cmnd": cmnd,
        "ngayCap": ngayCap,
        "noiCap": noiCap,
        "ngayNhapHoc": ngayNhapHoc,
        "heDaoTao": heDaoTao,
        "trangThai": trangThai,
        "kyThu": kyThu,
      };
}
