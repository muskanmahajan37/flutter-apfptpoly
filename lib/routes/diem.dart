import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';
import '../configs.dart';
import '../model/diem.dart';
import '../widgets/diem_item.dart';
import '../widgets/list_item.dart';

class DiemScreen extends StatefulWidget {
  const DiemScreen();

  @override
  State<StatefulWidget> createState() => _DiemScreenState();
}

class _DiemScreenState extends State<DiemScreen> {
  List<Diem> dsDiem = List<Diem>.generate(10, (index) {
    return const Diem(
      tenMon: "Lập trình Mobile đa nền tảng",
      trangThai: "PASSED",
      trungBinh: "9.2",
      maMon: "MOB306",
      lop: "PT12351-MOB",
      chiTiet: <ChiTietDiem>[
        ChiTietDiem(
          ten: "Đánh giá Assignment GĐ 1",
          trongSo: "10 %",
          diem: "9.5",
        ),
        ChiTietDiem(
          ten: "Đánh giá Assignment GĐ 2",
          trongSo: "10 %",
          diem: "9.5",
        ),
        ChiTietDiem(
          ten: "Lab 1",
          trongSo: "3.5 %",
          diem: "10.0",
        ),
        ChiTietDiem(
          ten: "Lab 2",
          trongSo: "3.5 %",
          diem: "10.0",
        ),
        ChiTietDiem(
          ten: "Lab 3",
          trongSo: "3.5 %",
          diem: "10.0",
        ),
        ChiTietDiem(
          ten: "Lab 4",
          trongSo: "3.5 %",
          diem: "10.0",
        ),
        ChiTietDiem(
          ten: "Lab 5",
          trongSo: "3.5 %",
          diem: "10.0",
        ),
        ChiTietDiem(
          ten: "Lab 6",
          trongSo: "3.5 %",
          diem: "10.0",
        ),
      ],
    );
  });

  Widget _buildDiemModal(Diem diem) {
    return Container(
      child: Column(
        children: <Widget>[
          ListItem(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text("Tên",
                      style: kModalTitleTextStyle),
                ),
                Expanded(
                  flex: 1,
                  child: Text("Trọng số",
                      textAlign: TextAlign.center,
                      style: kModalTitleTextStyle),
                ),
                Expanded(
                  flex: 1,
                  child: Text("Điểm",
                      textAlign: TextAlign.center,
                      style: kModalTitleTextStyle),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: diem.chiTiet.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                final chiTiet = diem.chiTiet[index];

                return ListItem(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          chiTiet.ten
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          chiTiet.trongSo,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(chiTiet.diem,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
        itemCount: dsDiem.length,
        itemBuilder: (_, index) => DiemItem(
          diem: dsDiem[index],
          onTap: () {
            showRoundedModalBottomSheet(
              context: context,
              color: Colors.white,
              radius: 12.0,
              builder: (_) => _buildDiemModal(dsDiem[index]),
            );
          },
        ),
      ),
      decoration: kMainCardBoxDecoration,
    );
  }
}
