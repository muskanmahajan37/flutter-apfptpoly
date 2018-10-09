import 'package:apfptpoly/utils/app_settings.dart';
import 'package:apfptpoly/widgets/alert_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';

import '../../configs.dart';
import '../../model/bang_diem.dart';
import '../../widgets/diem_item.dart';
import '../../widgets/diem_modal.dart';
import '../../widgets/loading.dart';
import 'diem_contract.dart';
import 'diem_presenter.dart';

class DiemScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiemScreenState();
}

class _DiemScreenState extends State<DiemScreen> implements DiemContract {
  DiemPresenter _presenter;
  List<BangDiem> _dsBangDiem;

  @override
  void initState() {
    super.initState();

    _presenter = new DiemPresenter(this);
  }

  @override
  void onBangDiemReceived(List<BangDiem> dsBangDiem) {
    setState(() {
      _dsBangDiem = dsBangDiem;
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
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertMessage(
                title: "Lỗi",
                content: err.message,
              ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertMessage(
              title: "Lỗi",
              content: err.toString(),
            ),
      );
    }
  }

  Widget _buildBangDiem() {
    return ListView.builder(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      itemCount: _dsBangDiem.length,
      itemBuilder: (_, index) => DiemItem(
            diem: _dsBangDiem[index],
            onTap: () {
              showRoundedModalBottomSheet(
                context: context,
                color: Colors.white,
                radius: 12.0,
                builder: (_) => DiemModal(_dsBangDiem[index]),
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _presenter.getBangDiem(),
      child: Container(
        child: _dsBangDiem == null ? Loading() : _buildBangDiem(),
        decoration: kMainCardBoxDecoration,
      ),
    );
  }
}
