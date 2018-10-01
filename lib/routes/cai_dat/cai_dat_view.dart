import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';

import '../../configs.dart';
import '../../model/sinh_vien.dart';
import '../../model/term.dart';
import '../../utils/app_settings.dart';
import '../../widgets/loading.dart';
import '../../widgets/select_list_modal.dart';
import '../../widgets/sinh_vien_modal.dart';
import 'cai_dat_contract.dart';
import 'cai_dat_presenter.dart';

class CaiDatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CaiDatScreenState();
}

class _CaiDatScreenState extends State<CaiDatScreen> implements CaiDatContract {
  static const EdgeInsets _kCardMargin =
      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0);

  CaiDatPresenter _presenter;

  SinhVien _sinhVien;
  List<Term> _terms;
  Period _selectedPeriod;
  Term _selectedTerm;
  bool _autoGetData = false;
  bool _showAds = true;

  @override
  void initState() {
    super.initState();

    _presenter = CaiDatPresenter(this);
    _presenter.getSinhVien();
  }

  @override
  void onAutoGetChanged(bool value) {
    setState(() {
      _autoGetData = value;
    });
  }

  @override
  void onSelectedPeriodChanged(Period period) {
    setState(() {
      _selectedPeriod = period;
    });
  }

  @override
  void onSelectedTermChanged(Term term) {
    setState(() {
      _selectedTerm = term;
    });
  }

  @override
  void onShowAdsChanged(bool value) {
    setState(() {
      _showAds = value;
    });
  }

  @override
  void onSinhVienReceived(SinhVien sinhVien) {
    setState(() {
      _sinhVien = sinhVien;
    });
  }

  @override
  void onTermsReceived(List<Term> terms) {
    setState(() {
      _terms = terms;
    });
  }

  @override
  void closeModal() {
    Navigator.of(context).pop();
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

  Widget _buildSinhVien() {
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
              backgroundImage: NetworkImage(_sinhVien.avatar),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Center(
          child: Text(
            _sinhVien.hoTen,
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
            _sinhVien.email,
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
                builder: (_) => SinhVienModal(_sinhVien),
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
              _selectedPeriod.title,
              style: TextStyle(color: Colors.deepOrange),
            ),
            onTap: () {
              showRoundedModalBottomSheet(
                context: context,
                color: Colors.white,
                radius: 12.0,
                builder: (_) => SelectListModal(
                      selected: kPeriods.indexOf(_selectedPeriod),
                      items: kPeriods.map((period) => period.title).toList(),
                      onItemTap: (index) =>
                          _presenter.saveSelectedPeriod(kPeriods[index]),
                    ),
              );
            }),
        _buildCard(
            icon: Icons.event_note,
            text: "Kỳ",
            trailing: Text(
              _selectedTerm?.title ?? "",
              style: TextStyle(color: Colors.deepOrange),
            ),
            onTap: () {
              showRoundedModalBottomSheet(
                context: context,
                color: Colors.white,
                radius: 12.0,
                builder: (_) => SelectListModal(
                      selected: _terms.indexWhere(
                          (term) => term.value == _selectedTerm.value),
                      items: _terms.map((term) => term.title).toList(),
                      onItemTap: (index) =>
                          _presenter.saveSelectedTerm(_terms[index]),
                    ),
              );
            }),
        _buildCard(
          icon: Icons.refresh,
          text: "Tự động tải",
          trailing: Checkbox(
            value: _autoGetData,
            onChanged: (val) => _presenter.saveAutoGet(val),
          ),
        ),
        _buildCard(
          icon: Icons.favorite,
          text: "Hiện quảng cáo",
          trailing: Checkbox(
            value: _showAds,
            onChanged: (val) => _presenter.saveShowAds(val),
          ),
        ),
        _buildCard(
          icon: Icons.exit_to_app,
          text: "Đăng xuất",
          onTap: () {
            AppSettings.getInstance().then((settings) {
              settings.resetSettings();
              Navigator.of(context).pushReplacementNamed("/auth");
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _sinhVien == null && _terms == null ? Loading() : _buildSinhVien(),
      decoration: kMainCardBoxDecoration,
    );
  }
}
