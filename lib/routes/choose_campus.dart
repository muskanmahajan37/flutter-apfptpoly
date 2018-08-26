import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../configs.dart';
import '../model/campus.dart';
import '../widgets/logo.dart';
import '../widgets/visible.dart';

class ChooseCampusScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChooseCampusScreenState();
}


class _ChooseCampusScreenState extends State<ChooseCampusScreen> {
  final FlutterWebviewPlugin webview = new FlutterWebviewPlugin();

  Campus _selectedCampus = kCampuses[0];
  bool _loading = false;

  @override
  void initState() {
    webview.close();
    webview.onStateChanged.listen(_onWebviewStateChanged);

    super.initState();
  }

  @override
  void dispose() {
    webview.dispose();

    super.dispose();
  }

  _onLoginPress() {
    setState(() {
      _loading = true;
    });
//    webview.launch(
//        "http://ap.poly.edu.vn/choose_campus.php?campus_id=${_selectedCampus.id}",
//        userAgent: kUserAgent,
//        hidden: true,
//        withJavascript: true,
//        withLocalStorage: true
//    );
  }

  _onWebviewStateChanged(WebViewStateChanged state) {
    print(state.type.toString() + " - " + state.url);

    final type = state.type;
    final url = state.url;

    switch (type) {
      case WebViewState.startLoad:
        if (url.startsWith(LoginStatus.authDone)) {
          webview.hide();
          print("Login in");
          setState(() {
            _loading = true;
          });
//          showDialog(
//            barrierDismissible: false,
//            context: context,
//            child: new AlertDialog(
//              content: Container(
//                color: Colors.white,
//                child: Row(
//                  children: <Widget>[
//                    CircularProgressIndicator(
//                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
//                      backgroundColor: Colors.deepOrange,
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
//                      child: Text(
//                        "Đăng nhập...",
//                        style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          fontSize: 16.0
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            )
//          );
        }
        break;

      case WebViewState.finishLoad:
        if (url == LoginStatus.finishedChoosingCampus) {
          webview.close();
          webview.launch(
              "http://ap.poly.edu.vn/hlogin.php?provider=Google",
              userAgent: kUserAgent,
              withJavascript: true,
              withLocalStorage: true
          );
        } else if (url.contains(LoginStatus.wrongAccount)) {
          webview.hide();
          print('wrong account');
        } else if (url.contains(LoginStatus.loginFailed)) {
          webview.hide();

          print('login failed');
        } else if (url.contains(LoginStatus.loginSuccess)) {
          print('login completed');
        }
        break;

      case WebViewState.shouldStart:
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(flex: 3, child: Logo(loading: _loading,)),
            Visible(
              visible: !_loading,
              child: CampusButtonGroup(
                campuses: kCampuses,
                selectedCampus: _selectedCampus,
                onSelectCampus: (Campus campus) => setState(() { _selectedCampus = campus; }),
              ),
            ),
            Visible(
              visible: !_loading,
              child: RaisedButton(
                padding: EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999.0)),
                color: Colors.white,
                elevation: 0.0,
                highlightElevation: 0.0,
                child: Text(
                  'ĐĂNG NHẬP',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _onLoginPress,
              ),
            )
          ],
        ),
      ),
    );
  }
}


class CampusButtonGroup extends StatelessWidget {
  CampusButtonGroup({
    @required this.campuses,
    @required this.selectedCampus,
    @required this.onSelectCampus
  });

  final List<Campus> campuses;
  final Campus selectedCampus;
  final Function onSelectCampus;

  Widget _buildButton(Campus campus) {
    return Flexible(
      child: InkWell(
        onTap: () => onSelectCampus(campus),
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius)
          ),
          child: Center(
            child: Text(
              campus.name,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: campus == selectedCampus
                    ? Colors.deepOrange
                    : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.deepOrange[800],
        borderRadius: BorderRadius.circular(kBorderRadius)
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints contrains) {
          return Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: Duration(milliseconds: 160),
                curve: Curves.ease,
                left: contrains.maxWidth / campuses.length * campuses.indexOf(selectedCampus),
                top: 0.0,
                bottom: 0.0,
                child: Container(
                  width: contrains.maxWidth / campuses.length,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(kBorderRadius)
                  ),
                ),
              ),
              Row(
                children: campuses.map(_buildButton).toList(),
              ),
            ],
          );
        }
      ),
    );
  }
}
