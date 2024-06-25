import 'package:flutter/material.dart';

/// Global `BuildContext` used for retrieving providers.
///
/// This should always be set to the `context` which `MaterialApp` lies in.
late BuildContext globalContext;

const String kAppStage = 'Beta Version';

const String kReleaseNotes = '''
- Special theme added.

**Note:** Past Paper Master is still in beta test, and there are still many features to be added and bugs to be fixed. Please report any issues you encounter to SCIE.DEV. Thank you for your support!

See [full changelog](https://github.com/SCIEDEV/PastPaperMaster/releases) and [commit history](https://github.com/SCIEDEV/PastPaperMaster/commits/main/) for changes in previous versions.
''';

const String kAppStageShort = 'β ';
const String kVersionTag = 'v0.2.3-beta+90';
const int kMajorVersion = 0;
const int kMinorVersion = 2;
const int kPatchVersion = 3;
const int kBuildNumber = 90;
const int kDatabaseVersion = 1;
const String kLastCommitHash = '7dd0dc3cfe71c109b13e3ef85f3cbd7b6c98c861';

const String kBundledDataPath = 'assets/json/';
const String kLocalDataPath = '/json/';
late String appSupportPath;

String kDownloadPath = '';

const Map<String, String> kSearchSubjects = {
  "All Subjects": "",
  "Accounting": "accounting",
  "Agriculture": "agriculture",
  "Art & Design": "artdesign",
  "Bangladesh Studies": "bangladeshstudies",
  "Biblical Studies": "biblicalstudies",
  "Biology": "biology",
  "Business Studies": "businessstudies",
  "Chemistry": "chemistry",
  "Classical Studies": "classicalstudies",
  "Commerce": "commerce",
  "Computer Science": "computerscience",
  "Design & Technology": "designtechnology",
  "Design & Textiles": "designtextiles",
  "Design and Communication": "designcommunication",
  "Development Studies": "developmentstudies",
  "Digital Media & Design": "digitalmediadesign",
  "Divinity": "divinity",
  "Drama": "drama",
  "Economics": "economics",
  "English": "english",
  "Enterprise": "enterprise",
  "Environmental Management": "environmentalmanagement",
  "Food & Nutrition": "foodnutrition",
  "Fashion & Textiles": "fashiontextiles",
  "Geography": "geography",
  "Global Perspectives & Research": "globalperspectivesresearch",
  "Hinduism": "hinduism",
  "History": "history",
  "Information & Communication Technology":
      "informationcommunicationtechnology",
  "Information Technology": "informationtechnology",
  "Islamic Studies": "islamicstudies",
  "Islamiyat": "islamiyat",
  "Physics": "physics",
  "Psychology": "psychology",
  "Science (Combined)": "sciencecombined",
  "Sciences (Co-ordinated)": "sciencescoordinated",
  "Sociology": "sociology",
  "Statistics": "statistics",
  "Thinking Skills": "thinkingskills",
  "Law": "law",
  "Marine Science": "marinescience",
  "Mathematics": "mathematics",
  "Media Studies": "mediastudies",
  "Music": "music",
  "Pakistan Studies": "pakistanstudies",
  "Physical Education": "physicaleducation",
  "Physical Science": "physicalscience",
  "Religious Studies": "religiousstudies",
  "Sport and Physical Education": "sportphysicaleducation",
  "Travel & Tourism": "traveltourism",
  "World Literature": "worldliterature",
};
