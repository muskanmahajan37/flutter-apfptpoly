import 'package:flutter/material.dart';

import '../model/sinh_vien.dart';
import 'list_item.dart';

class SinhVienModal extends StatelessWidget {
  final SinhVien sinhVien;

  const SinhVienModal(this.sinhVien);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          ListItem(
            title: "Tên Đăng Nhập",
            subtitle: sinhVien.tenDangNhap,
          ),
          ListItem(
            title: "Họ Tên",
            subtitle: sinhVien.hoTen,
          ),
          ListItem(
            title: "Mã Sinh Viên",
            subtitle: sinhVien.maSinhVien,
          ),
          ListItem(
            title: "Giới Tính",
            subtitle: sinhVien.gioiTinh,
          ),
          ListItem(
            title: "Ngày Sinh",
            subtitle: sinhVien.ngaySinh,
          ),
          ListItem(
            title: "Email",
            subtitle: sinhVien.email,
          ),
          ListItem(
            title: "Điạ Chỉ",
            subtitle: sinhVien.diaChi,
          ),
          ListItem(
            title: "Khóa",
            subtitle: sinhVien.khoa,
          ),
          ListItem(
            title: "Ngành",
            subtitle: sinhVien.nganh,
          ),
          ListItem(
            title: "Chuyên Ngành",
            subtitle: sinhVien.chuyenNganh,
          ),
          ListItem(
            title: "Nội Dung Đào Tạo",
            subtitle: sinhVien.noiDungDaoTao,
          ),
          ListItem(
            title: "CMDN",
            subtitle: sinhVien.cmnd,
          ),
          ListItem(
            title: "Ngày Cấp",
            subtitle: sinhVien.ngayCap,
          ),
          ListItem(
            title: "Nơi Cấp",
            subtitle: sinhVien.noiCap,
          ),
          ListItem(
            title: "Ngày Nhập Học",
            subtitle: sinhVien.ngayNhapHoc,
          ),
          ListItem(
            title: "Hệ Đào Tạo",
            subtitle: sinhVien.heDaoTao,
          ),
          ListItem(
            title: "Trạng Thái",
            subtitle: sinhVien.trangThai,
          ),
          ListItem(
            title: "Kỳ Thứ",
            subtitle: sinhVien.kyThu,
          ),
        ],
      ),
    );
  }
}