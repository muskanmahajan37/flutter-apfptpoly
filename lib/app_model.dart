import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'utils/app_settings.dart';
import 'utils/cookie_handler.dart';

class AppModel extends Model {
  final CookieHandler cookieHandler = CookieHandler();
  final AppSettings appSettings = AppSettings();

  static AppModel of(BuildContext context) => ScopedModel.of<AppModel>(context);
}
