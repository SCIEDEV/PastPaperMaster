import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:past_paper_master/core/global.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initDirectoryData() async {
  // Check if the directory and files exist, if not create it
  bool copied = false;
  List<String> files = [
    'alevel-subjects.json',
    'alevel.json',
    'igcse-subjects.json',
    'igcse.json',
  ];
  String bundledDataPath = 'assets/json/';
  appSupportPath = (await getApplicationSupportDirectory()).path;
  if (kDebugMode) {
    print('Application Support Directory: $appSupportPath');
  }
  String realDataPath = '$appSupportPath$kLocalDataPath';
  if (!await Directory(realDataPath).exists()) {
    await Directory(realDataPath).create();
  }
  for (String file in files) {
    // TODO: should retain data in the future for direct past paper list updates
    // if (!await File('$realDataPath$file').exists()) {
    copied = true;
    String data = await rootBundle.loadString('$bundledDataPath$file');
    File('$realDataPath$file').writeAsString(data);
    // }
  }

  if (copied) {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('databaseVersion', kDatabaseVersion);
  }
}
