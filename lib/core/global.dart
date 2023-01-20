library ppm.globals;

import 'package:flutter/material.dart';

/// Global `BuildContext` used for retriving providers.
///
/// This should always be set to the `context` which `MaterialApp` lies in.
late BuildContext globalContext;

const String kAppStage = 'Alpha Version';
const String kAppStageShort = 'α ';
const int kMajorVersion = 0;
const int kMinorVersion = 1;
const int kPatchVersion = 0;
const int kBuildNumber = 13;
const int kDatabaseVersion = 1;
const String kLastCommitHash = 'c0c1ebcbe91fc8ba9fd36af42c6652e5ff248e91';

const String kBundledDataPath = 'assets/json/';
const String kLocalDataPath = '/json/';
late String appSupportPath;
