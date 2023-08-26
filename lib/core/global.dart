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
const int kPatchVersion = 3;
const int kBuildNumber = 47;
const int kDatabaseVersion = 1;
const String kLastCommitHash = '1d6e86cf6b09329f80bb6a85ec45b1c39f64cca6';

const String kBundledDataPath = 'assets/json/';
const String kLocalDataPath = '/json/';
late String appSupportPath;

String kDownloadPath = '';
const int kMaxThreads = 3;
