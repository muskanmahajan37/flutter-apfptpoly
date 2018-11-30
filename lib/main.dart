import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'app_model.dart';
import 'ap_fpt_poly.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: AppModel(),
      child: ApFptPoly(),
    );
  }
}
