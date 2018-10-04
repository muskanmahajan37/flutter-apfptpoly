import 'package:apfptpoly/widgets/alert_message.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';

import '../../configs.dart';
import '../../model/group_lich.dart';
import '../../utils/app_settings.dart';
import '../../widgets/group_lich_item.dart';
import '../../widgets/lich_modal.dart';
import '../../widgets/loading.dart';
import 'lich_contract.dart';
import 'lich_presenter.dart';

class LichScreen extends StatefulWidget {
  LichScreen();

  @override
  State<StatefulWidget> createState() => _LichScreenState();
}

class _LichScreenState extends State<LichScreen> implements LichContract {
  LichPresenter _presenter;
  List<GroupLich> _dsGroupLich;

  @override
  void initState() {
    super.initState();

    _presenter = new LichPresenter(this);
  }

  @override
  void onLichReceived(List<GroupLich> dsGroupLich) {
    setState(() {
      _dsGroupLich = dsGroupLich;
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

  Widget _buildGroupLich() {
    return ListView.builder(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      padding: const EdgeInsets.all(4.0),
      itemCount: _dsGroupLich.length,
      itemBuilder: (_, index) {
        final groupLich = _dsGroupLich[index];

        return GroupLichItem(
          groupLich,
          onTap: (lichIndex) {
            showRoundedModalBottomSheet(
              context: context,
              color: Colors.white,
              radius: 12.0,
              builder: (_) => LichModal(groupLich.dsLich[lichIndex]),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _presenter.getLich(),
      child: Container(
          child: _dsGroupLich == null ? Loading() : _buildGroupLich(),
          decoration: kMainCardBoxDecoration),
    );
  }
}
