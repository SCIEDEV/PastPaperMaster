library ppm.globals;

import 'package:flutter/material.dart';

/// Global `BuildContext` used for retriving providers.
///
/// This should always be set to the `context` which `MaterialApp` lies in.
late BuildContext globalContext;

const String kAppStage = 'Beta Version';
const String kAppStageShort = 'β ';
const int kMajorVersion = 0;
const int kMinorVersion = 1;
const int kPatchVersion = 2;
const int kBuildNumber = 39;
const int kDatabaseVersion = 1;
const String kLastCommitHash = 'c3930e0d8c0814fc34ad672a8ff17ea7dd533da2';

const String kBundledDataPath = 'assets/json/';
const String kLocalDataPath = '/json/';
late String appSupportPath;

String kDownloadPath = '';
const int kMaxThreads = 3;
