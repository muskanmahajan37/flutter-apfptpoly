import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';
import '../configs.dart';
import '../model/bang_diem_danh.dart';
import '../task/get_data.dart';
import '../widgets/diem_danh_item.dart';
import '../widgets/list_item.dart';

class DiemDanhScreen extends StatefulWidget {
  const DiemDanhScreen();

  @override
  State<StatefulWidget> createState() => _DiemDanhScreenState();
}

class _DiemDanhScreenState extends State<DiemDanhScreen> {

  Widget _buildDiemDanhModal(BangDiemDanh bangDiemDanh) {
    return Container(
      child: Column(
        children: <Widget>[
          ListItem(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text("Ngày",
                      textAlign: TextAlign.center, style: kModalTitleTextStyle),
                ),
                Expanded(
                  child: Text("Ca",
                      textAlign: TextAlign.center, style: kModalTitleTextStyle),
                ),
                Expanded(
                  flex: 3,
                  child: Text("Mô tả",
                      textAlign: TextAlign.center, style: kModalTitleTextStyle),
                ),
                Expanded(
                  flex: 2,
                  child: Text("Trạng thái",
                      textAlign: TextAlign.center, style: kModalTitleTextStyle),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: bangDiemDanh.dsDiemDanh.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                final chiTiet = bangDiemDanh.dsDiemDanh[index];
                final trangThaiColor = chiTiet.trangThai == "Present"
                    ? Colors.green
                    : chiTiet.trangThai == "Absent"
                        ? Colors.red
                        : Colors.black38;

                return ListItem(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(chiTiet.ngay, textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text(chiTiet.ca, textAlign: TextAlign.center),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(chiTiet.moTa, textAlign: TextAlign.center),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          chiTiet.trangThai,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: trangThaiColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBangDiemDanhLayout(List<BangDiemDanh> dsBangDiemDanh) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      itemCount: dsBangDiemDanh.length,
      itemBuilder: (_, index) => DiemDanhItem(
        bangDiemDanh: dsBangDiemDanh[index],
        onTap: () {
          showRoundedModalBottomSheet(
            context: context,
            color: Colors.white,
            radius: 12.0,
            builder: (_) => _buildDiemDanhModal(dsBangDiemDanh[index]),
          );
        },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: ApTask.getDanhSachDiemDanh(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              final List<BangDiemDanh> dsBangDiemDanh = snapshot.data;
              return _buildBangDiemDanhLayout(dsBangDiemDanh);
            }
          }

          return Center(child: new CircularProgressIndicator());
        },
      ),
      decoration: kMainCardBoxDecoration,
    );
  }
}
