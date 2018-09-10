import 'package:flutter/material.dart';
import 'package:rounded_modal/rounded_modal.dart';
import '../configs.dart';
import '../model/diem_danh.dart';
import '../widgets/diem_danh_item.dart';
import '../widgets/list_item.dart';

class DiemDanhScreen extends StatefulWidget {
  const DiemDanhScreen();

  @override
  State<StatefulWidget> createState() => _DiemDanhScreenState();
}

class _DiemDanhScreenState extends State<DiemDanhScreen> {

  List<DiemDanh> dsDiemDanh = List<DiemDanh>.generate(10, (index) {
    return const DiemDanh(
        tenMon: "Mobile Marketing",
        tongVang: "3/17",
        phanTramVang: "24",
        maMon: "MOB307",
        lop: "MOB307.2",
        chiTiet: const <ChiTietDiemDanh>[
          ChiTietDiemDanh(
              ngay: "09/07/2018",
              baiHoc: "1",
              ca: "1",
              nguoiDiemDanh: "duongpt2",
              moTa: "Lý thuyết",
              trangThai: "Present",
              ghiChu: ""),
          ChiTietDiemDanh(
              ngay: "09/07/2018",
              baiHoc: "1",
              ca: "1",
              nguoiDiemDanh: "duongpt2",
              moTa: "Lý thuyết",
              trangThai: "Present",
              ghiChu: ""),
          ChiTietDiemDanh(
              ngay: "09/07/2018",
              baiHoc: "1",
              ca: "1",
              nguoiDiemDanh: "duongpt2",
              moTa: "Lý thuyết",
              trangThai: "Present",
              ghiChu: ""),
          ChiTietDiemDanh(
              ngay: "09/07/2018",
              baiHoc: "1",
              ca: "1",
              nguoiDiemDanh: "duongpt2",
              moTa: "Lý thuyết",
              trangThai: "Present",
              ghiChu: ""),
          ChiTietDiemDanh(
              ngay: "09/07/2018",
              baiHoc: "1",
              ca: "1",
              nguoiDiemDanh: "duongpt2",
              moTa: "Lý thuyết",
              trangThai: "Present",
              ghiChu: ""),
          ChiTietDiemDanh(
              ngay: "09/07/2018",
              baiHoc: "1",
              ca: "1",
              nguoiDiemDanh: "duongpt2",
              moTa: "Lý thuyết",
              trangThai: "Present",
              ghiChu: ""),
          ChiTietDiemDanh(
              ngay: "09/07/2018",
              baiHoc: "1",
              ca: "1",
              nguoiDiemDanh: "duongpt2",
              moTa: "Lý thuyết",
              trangThai: "Present",
              ghiChu: ""),
          ChiTietDiemDanh(
              ngay: "09/07/2018",
              baiHoc: "1",
              ca: "1",
              nguoiDiemDanh: "duongpt2",
              moTa: "Lý thuyết",
              trangThai: "Present",
              ghiChu: ""),
        ]);
  });

  Widget _buildDiemDanhModal(DiemDanh diemDanh) {
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
                  flex: 2,
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
              itemCount: diemDanh.chiTiet.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                final chiTiet = diemDanh.chiTiet[index];
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
                        flex: 2,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          itemCount: dsDiemDanh.length,
          itemBuilder: (_, index) => DiemDanhItem(
                diemDanh: dsDiemDanh[index],
                onTap: () {
                  showRoundedModalBottomSheet(
                    context: context,
                    color: Colors.white,
                    radius: 12.0,
                    builder: (_) => _buildDiemDanhModal(dsDiemDanh[index]),
                  );
                },
              )),
      decoration: kMainCardBoxDecoration,
    );
  }
}
