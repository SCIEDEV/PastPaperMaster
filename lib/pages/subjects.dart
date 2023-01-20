import 'dart:convert';
import 'dart:io';
import '../core/global.dart';

List<String> igcseSubjects = [];

Future<void> updateIgcseSubjects() async {
  // read from application support
  String realDataPath = '$appSupportPath$kLocalDataPath';
  String data = await File('${realDataPath}igcse-subjects.json').readAsString();
  // parse json
  List<String> subjects = [];
  for (var subject in jsonDecode(data)) {
    subjects.add(subject);
  }
  igcseSubjects = subjects;
}

List<String> alevelSubjects = [];

Future<void> updateAlevelSubjects() async {
  // read from application support
  String realDataPath = '$appSupportPath$kLocalDataPath';
  String data =
      await File('${realDataPath}alevel-subjects.json').readAsString();
  // parse json
  List<String> subjects = [];
  for (var subject in jsonDecode(data)) {
    subjects.add(subject);
  }
  alevelSubjects = subjects;
}
