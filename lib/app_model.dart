import 'package:apfptpoly/utils/cookie_handler.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  final CookieHandler cookieHandler = CookieHandler();

  static AppModel of(BuildContext context) => ScopedModel.of<AppModel>(context);
}
