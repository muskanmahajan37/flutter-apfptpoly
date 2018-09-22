import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../configs.dart';
import '../model/term.dart';
import '../task/get_data.dart';
import '../utils/app_settings.dart';
import '../model/sinh_vien.dart';
import '../widgets/list_item.dart';

class CaiDatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CaiDatScreenState();
}

class _CaiDatScreenState extends State<CaiDatScreen> {
  final FlutterWebviewPlugin webview = FlutterWebviewPlugin();
  static const EdgeInsets _kCardMargin =
      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0);

  AppSettings appSettings;

  Period selectedPeriod;
  Term selectedTerm;

  bool autoGetData = false;
  bool showAds = true;

  @override
  void initState() {
    AppSettings.getInstance().then((settings) {
      appSettings = settings;

      setState(() {
        autoGetData = appSettings.isAutoGet;
        showAds = appSettings.isShowAds;
        selectedTerm = appSettings.selectedTerm;
        selectedPeriod = kPeriods.firstWhere(
            (period) => period.value == appSettings.period,
            orElse: () => kPeriods[0]);
      });
    });
    super.initState();
  }

  Widget _buildStudentInfoModal(SinhVien sinhVien) {
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

  Widget _buildPeriodModal() {
    return Container(
      height: 230.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: kPeriods.length,
        itemBuilder: (_, index) {
          final period = kPeriods[index];

          return Container(
            child: FlatButton(
              padding: EdgeInsets.all(16.0),
              child: Text(
                kPeriods[index].title,
                style: TextStyle(
                  color: period == selectedPeriod
                      ? Colors.deepOrange
                      : Colors.black54,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(index == 0 ? 12.0 : 0.0),
                ),
              ),
              onPressed: () {
                appSettings.period = period.value;

                setState(() {
                  selectedPeriod = period;
                });

                Navigator.pop(context);
              },
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTermModal(List<Term> terms) {
    return Container(
      height: 230.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: terms.length,
        itemBuilder: (_, index) {
          final term = terms[index];

          return Container(
            child: FlatButton(
              padding: EdgeInsets.all(16.0),
              child: Text(
                term.title,
                style: TextStyle(
                  color: term.value == selectedTerm.value
                      ? Colors.deepOrange
                      : Colors.black54,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(index == 0 ? 12.0 : 0.0),
                ),
              ),
              onPressed: () {
                appSettings.selectedTermValue = term.value;

                setState(() {
                  selectedTerm = term;
                });

                Navigator.pop(context);
              },
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard({
    IconData icon,
    String text,
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

  Widget _buildSinhVienLayout(SinhVien sinhVien, List<Term> terms) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      children: <Widget>[
        Center(
          child: Container(
            width: 160.0,
            height: 160.0,
            padding: EdgeInsets.all(6.0),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: CircleBorder(),
              shadows: kElevationToShadow[1],
            ),
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
                builder: (_) => _buildStudentInfoModal(sinhVien),
              );
            }),
        _buildCard(
            icon: Icons.whatshot,
            text: "Tin tức",
            onTap: () {
              Navigator.of(context).pushNamed("/news");
            }),
        _buildCard(
            icon: Icons.event,
            text: "Lịch học",
            trailing: Text(
              selectedPeriod.title,
              style: TextStyle(color: Colors.deepOrange),
            ),
            onTap: () {
              showRoundedModalBottomSheet(
                context: context,
                color: Colors.white,
                radius: 12.0,
                builder: (_) => _buildPeriodModal(),
              );
            }),
        _buildCard(
            icon: Icons.event_note,
            text: "Kỳ",
            trailing: Text(
              selectedTerm.title,
              style: TextStyle(color: Colors.deepOrange),
            ),
            onTap: () {
              showRoundedModalBottomSheet(
                context: context,
                color: Colors.white,
                radius: 12.0,
                builder: (_) => _buildTermModal(terms),
              );
            }),
        _buildCard(
          icon: Icons.refresh,
          text: "Tự động tải",
          trailing: Checkbox(
            value: autoGetData,
            onChanged: (val) {
              setState(() {
                autoGetData = val;
                appSettings.isAutoGet = val;
              });
            },
          ),
        ),
        _buildCard(
          icon: Icons.favorite,
          text: "Hiện quảng cáo",
          trailing: Checkbox(
            value: showAds,
            onChanged: (val) {
              setState(() {
                showAds = val;
                appSettings.isShowAds = val;
              });
            },
          ),
        ),
        _buildCard(
            icon: Icons.exit_to_app,
            text: "Đăng xuất",
            onTap: () {
              appSettings.isSignedIn = false;
              appSettings.terms = null;
              appSettings.selectedTermValue = null;
              Navigator.of(context).pushReplacementNamed("/auth");
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: Future.wait([
            ApTask.getSinhVien(),
            ApTask.getTerms(),
          ]),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                final SinhVien sinhVien = snapshot.data[0];
                final List<Term> terms = snapshot.data[1];

                if (selectedTerm == null) {
                  selectedTerm = appSettings.selectedTerm;
                }

                return _buildSinhVienLayout(sinhVien, terms);
              }
            }

            return Center(child: new CircularProgressIndicator());
          }),
      decoration: kMainCardBoxDecoration,
    );
  }
}
