import 'package:apfptpoly/utils/app_settings.dart';
import 'package:apfptpoly/widgets/alert_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';

import '../../configs.dart';
import '../../model/bang_diem_danh.dart';
import '../../widgets/diem_danh_item.dart';
import '../../widgets/diem_danh_modal.dart';
import '../../widgets/loading.dart';
import 'diem_danh_contract.dart';
import 'diem_danh_presenter.dart';

class DiemDanhScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiemDanhScreenState();
}

class _DiemDanhScreenState extends State<DiemDanhScreen>
    implements DiemDanhContract {
  DiemDanhPresenter _presenter;
  List<BangDiemDanh> _dsBangDiemDanh;

  @override
  void initState() {
    super.initState();

    _presenter = new DiemDanhPresenter(this);
  }

  @override
  void onBangDiemDanhReceived(List<BangDiemDanh> dsBangDiemDanh) {
    setState(() {
      _dsBangDiemDanh = dsBangDiemDanh;
    });
  }

  @override
  void onError(message, err) {
    if (err is DioError) {
      final int statusCode = err.response.statusCode;
      if (statusCode == 404 || statusCode == 403) {
        AppSettings.getInstance().then((settings) {
          settings.resetSettings();
          Navigator.of(context).pushReplacementNamed("/auth");
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertMessage(
              title: "Lỗi",
              content: message,
            ),
      );
    }
  }

  Widget _buildBangDiemDanh() {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
        itemCount: _dsBangDiemDanh.length,
        itemBuilder: (_, index) => DiemDanhItem(
              bangDiemDanh: _dsBangDiemDanh[index],
              onTap: () {
                showRoundedModalBottomSheet(
                  context: context,
                  color: Colors.white,
                  radius: 12.0,
                  builder: (_) => DiemDanhModal(_dsBangDiemDanh[index]),
                );
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _dsBangDiemDanh == null ? Loading() : _buildBangDiemDanh(),
      decoration: kMainCardBoxDecoration,
    );
  }
}
