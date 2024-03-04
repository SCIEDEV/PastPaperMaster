library ppm.globals;

import 'package:flutter/material.dart';

/// Global `BuildContext` used for retrieving providers.
///
/// This should always be set to the `context` which `MaterialApp` lies in.
late BuildContext globalContext;

const String kAppStage = 'Beta Version';
const String kAppStageShort = 'β ';
const int kMajorVersion = 0;
const int kMinorVersion = 1;
const int kPatchVersion = 5;
const int kBuildNumber = 62;
const int kDatabaseVersion = 1;
const String kLastCommitHash = '2de6960169c8cee952e5895a1fadf238ef4f3bc4';

const String kBundledDataPath = 'assets/json/';
const String kLocalDataPath = '/json/';
late String appSupportPath;

String kDownloadPath = '';
const int kMaxThreads = 3;
