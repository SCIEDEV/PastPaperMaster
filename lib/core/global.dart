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
const int kPatchVersion = 1;
const int kBuildNumber = 36;
const int kDatabaseVersion = 1;
const String kLastCommitHash = 'caab59aef5724564d3e8efa07f14bdca5dd29ae6';

const String kBundledDataPath = 'assets/json/';
const String kLocalDataPath = '/json/';
late String appSupportPath;

String kDownloadPath = '';
const int kMaxThreads = 3;
