import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';
import '../../configs.dart';
import '../../model/bang_diem.dart';
import '../../task/get_data.dart';
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
    _presenter.getBangDiem();
  }

  @override
  void onBangDiemReceived(List<BangDiem> dsBangDiem) {
    setState(() {
      _dsBangDiem = dsBangDiem;
    });
  }

  Widget _buildBangDiem() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
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
    return Container(
      child: _dsBangDiem == null
          ? Loading()
          : _buildBangDiem(),
      decoration: kMainCardBoxDecoration,
    );
  }
}
