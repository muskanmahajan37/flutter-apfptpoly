import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';
import '../configs.dart';
import '../model/sinh_vien.dart';
import '../widgets/list_item.dart';

class CaiDatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CaiDatScreenState();
}

class _CaiDatScreenState extends State<CaiDatScreen> {
  static const EdgeInsets _kCardMargin =
      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0);

  SinhVien sinhVien = SinhVien(
    avatar:
        "https://scontent.fhan2-2.fna.fbcdn.net/v/t1.0-9/14055088_835216616580439_407796087641692406_n.jpg?_nc_cat=0&oh=41a6d064f4e67b7d9b04226b240e6aad&oe=5BF052C8",
    tenDangNhap: "hungpsph04930",
    hoTen: "Phạm Sỹ Hưng",
    maSinhVien: "PH04930",
    gioiTinh: "Nam",
    ngaySinh: "25/09/1997",
    email: "hungpsph04930@fpt.edu.vn",
    diaChi: "abcxyz",
    khoa: "12.3",
    nganh: "Công nghệ thông tin",
    chuyenNganh: "Lập trình máy tính(Lập trình máy tính - Thiết bị di động)",
    noiDungDaoTao: "Lập trình máy tính - Lập trình mobile",
    cmnd: "013507259",
    ngayCap: "10/02/2012",
    noiCap: "Hà Nội",
    ngayNhapHoc: "30/08/2016",
    heDaoTao: "Cao đẳng",
    trangThai: "HDI ( Học đi )",
    kyThu: "7",
  );

  Widget _buildThongTinCaNhanModal() {
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

  Widget _buildNgayModal() {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: kPeriods.length,
        itemBuilder: (_, index) {
          return Container(
            child: FlatButton(
              padding: EdgeInsets.all(16.0),
              child: Text(kPeriods[index].title),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(index == 0 ? 12.0 : 0.0))
              ),
              onPressed: () {},
            ),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12))
            )
          );
        },
      ),
    );
  }

  Widget _buildKyModal() {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: kPeriods.length,
        itemBuilder: (_, index) {
          return Container(
              child: FlatButton(
                padding: EdgeInsets.all(16.0),
                child: Text(kPeriods[index].title),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(index == 0 ? 12.0 : 0.0))
                ),
                onPressed: () {},
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12))
              )
          );
        },
      ),
    );
  }

  Widget _buildCard({
    @required IconData icon,
    @required String text,
    Function onTap,
    Widget trailing,
  }) {
    return Card(
      margin: _kCardMargin,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepOrange,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(text),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 160.0,
              height: 160.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage(sinhVien.avatar),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: Text(
              sinhVien.hoTen,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26.0,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Center(
            child: Text(
              sinhVien.email,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _buildCard(
              icon: Icons.person,
              text: "Thông tin cá nhân",
              onTap: () {
                showRoundedModalBottomSheet(
                  context: context,
                  color: Colors.white,
                  radius: 12.0,
                  builder: (_) => _buildThongTinCaNhanModal(),
                );
              }),
          _buildCard(
            icon: Icons.whatshot,
            text: "Tin tức",
            onTap: () {
              Navigator.of(context).pushNamed("/news");
            }
          ),
          _buildCard(
            icon: Icons.event,
            text: "Lịch học",
            trailing: const Text(
              "14 ngày tới",
              style: TextStyle(color: Colors.deepOrange),
            ),
            onTap: () {
              showRoundedModalBottomSheet(
                context: context,
                color: Colors.white,
                radius: 12.0,
                builder: (_) => _buildNgayModal(),
              );
            }
          ),
          _buildCard(
            icon: Icons.event_note,
            text: "Kỳ",
            trailing: const Text(
              "Summer 2018",
              style: TextStyle(color: Colors.deepOrange),
            ),
            onTap: () {
              showRoundedModalBottomSheet(
                context: context,
                color: Colors.white,
                radius: 12.0,
                builder: (_) => _buildKyModal(),
              );
            }
          ),
          _buildCard(
            icon: Icons.refresh,
            text: "Tự động tải",
            trailing: Checkbox(
              value: true,
              onChanged: (val) {},
            ),
          ),
          _buildCard(
            icon: Icons.favorite,
            text: "Hiện quảng cáo",
            trailing: Checkbox(
              value: true,
              onChanged: (val) {},
            ),
          ),
        ],
      ),
      decoration: kMainCardBoxDecoration,
    );
  }
}
