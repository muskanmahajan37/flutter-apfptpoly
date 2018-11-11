import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CookieHandler {
  Directory cookieDir;

  Future<Directory> setupStorage() async {
    final cacheDir = await getTemporaryDirectory();
    cookieDir = new Directory(cacheDir.path + "/cookies");
    if (!cookieDir.existsSync()) {
      cookieDir.createSync();
    }
    return cookieDir;
  }

  File getFile(String url) {
    final String filename =
        url.replaceAll(new RegExp(r"(https|http|:\/\/|\.)"), "");
    File file = new File("${cookieDir.path}/$filename");
    if (!file.existsSync()) {
      file.createSync();
    }
    return file;
  }

  void saveCookies(String url, Map<String, String> cookies) {
    final File file = getFile(url);
    final String content = cookies.keys
        .map((key) =>
            "${key.replaceAll("\"", "")}=${cookies[key].replaceAll("\"", "")}")
        .join("; ");
    file.writeAsStringSync(content);
  }

  void saveCookiesString(String url, String cookies) {
    final File file = getFile(url);
    file.writeAsStringSync(cookies);
  }

  String readCookies(String url) {
    File file = getFile(url);
    return file.readAsStringSync();
  }

  List<Cookie> readCookiesList(String url) {
    String cookieString = readCookies(url);
    final cookies = <Cookie>[];

    if (cookieString?.isNotEmpty == true) {
      cookieString
          .split(new RegExp(r";[\n\r\s]+", multiLine: true))
          .forEach((String cookie) {
        final splited = cookie.split('=');
        cookies.add(new Cookie(splited[0], splited[1]));
      });
    }

    return cookies;
  }
}

// Don't know why i cannot use PersistCookieJar, so use default cookie and save to file
