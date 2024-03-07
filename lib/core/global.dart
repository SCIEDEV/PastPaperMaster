library ppm.globals;

import 'package:flutter/material.dart';

/// Global `BuildContext` used for retrieving providers.
///
/// This should always be set to the `context` which `MaterialApp` lies in.
late BuildContext globalContext;

const String kAppStage = 'Beta Version';

const String kReleaseNotes = '''
- Adds update checker
  - Automatically checks for update
  - Release notes will be shown after updates
- Adds Clear Selection and Select All button to **Browse** page
- Fixes download item cancelling
- Fixes minor layout issues
  - Reverts to Material 2 design
  - Fixes subject search field
- Enhances app performance

See [full changelog](https://github.com/SCIEDEV/PastPaperMaster/releases) and [commit history](https://github.com/SCIEDEV/PastPaperMaster/commits/main/) for changes in previous versions.
''';

const String kAppStageShort = 'β ';
const String kVersionTag = 'v0.1.7-beta+72';
const int kMajorVersion = 0;
const int kMinorVersion = 1;
const int kPatchVersion = 7;
const int kBuildNumber = 72;
const int kDatabaseVersion = 1;
const String kLastCommitHash = '5ab01eb3cff5ecf0a569a528ac1a4bd00c774659';

const String kBundledDataPath = 'assets/json/';
const String kLocalDataPath = '/json/';
late String appSupportPath;

String kDownloadPath = '';
const int kMaxThreads = 3;
