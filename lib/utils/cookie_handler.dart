import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CookieHandler {
  Directory cookieDir;

  CookieHandler() {
    setupStorage();
  }

  /// Setup cookie directory in the cache folder of the phone
  void setupStorage() async {
    Directory cacheDir = await getTemporaryDirectory();
    cookieDir = Directory(cacheDir.path + "/cookies");
    if (!cookieDir.existsSync()) {
      cookieDir.createSync();
    }
  }

  /// Convert url to a valid file name
  ///
  /// For example: https://www.google.com => wwwgooglecom
  String getCookieFileName(String url) =>
      url.replaceAll(RegExp(r"(https|http|:\/\/|\.)"), "");

  /// Get the cookie file base on url
  File getFile(String url) {
    String filename = getCookieFileName(url);
    File file = File("${cookieDir.path}/$filename");

    if (!file.existsSync()) {
      file.createSync();
    }
    return file;
  }

  /// Save cookies (as map) of an url to file
  void saveCookies(String url, Map<String, String> cookies) {
    File file = getFile(url);

    String cookieString = cookies.keys
        .map((key) => "$key=${cookies[key]}".replaceAll("\"", ""))
        .join("; ");

    file.writeAsStringSync(cookieString);
  }

  /// Save cookies (as string) of an url to file
  void saveCookiesString(String url, String cookies) {
    File file = getFile(url);

    file.writeAsStringSync(cookies);
  }

  /// Get cookies (as string) of an url from file
  String readCookies(String url) {
    File file = getFile(url);

    return file.readAsStringSync();
  }

  /// Get cookies (as list) of an url from file
  List<Cookie> readCookiesList(String url) {
    final String cookieString = readCookies(url) ?? "";
    List<Cookie> cookies = [];

    if (cookieString.isNotEmpty) {
      cookies = cookieString
          .split(RegExp(r";[\n\r\s]+", multiLine: true))
          .map((cookie) => cookie.split("="))
          .toList()
          .map((cookie) => Cookie(cookie[0], cookie[1]))
          .toList();
    }

    return cookies;
  }
}
