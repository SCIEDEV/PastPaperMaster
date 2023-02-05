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
const int kPatchVersion = 0;
const int kBuildNumber = 27;
const int kDatabaseVersion = 1;
const String kLastCommitHash = '8df49bed091880366d969cbf26e8ddcff2af8ad7';

const String kBundledDataPath = 'assets/json/';
const String kLocalDataPath = '/json/';
late String appSupportPath;

String kDownloadPath = '';
