// ignore_for_file: use_colored_box

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:once/once.dart';
import 'package:past_paper_master/components/dialogs.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/dirinit.dart';
import 'package:past_paper_master/core/global.dart';
import 'package:past_paper_master/core/provider.dart';
import 'package:past_paper_master/core/subjects.dart';
import 'package:past_paper_master/pages/about.dart';
import 'package:past_paper_master/pages/browse.dart';
import 'package:past_paper_master/pages/checkout.dart';
import 'package:past_paper_master/pages/download.dart';
import 'package:past_paper_master/pages/filter.dart';
import 'package:past_paper_master/pages/question.dart';
import 'package:past_paper_master/pages/settings.dart';
import 'package:past_paper_master/pages/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    const WindowOptions windowOptions = WindowOptions(
      title: 'Past Paper Master',
      size: Size(1024, 800),
      minimumSize: Size(990, 645),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  final prefs = await SharedPreferences.getInstance();
  Once.clearAll();
  await prefs.remove('downloadPath');
  final String? downloadPath = prefs.getString('downloadPath');
  if (downloadPath != null) {
    kDownloadPath = downloadPath;
  } else {
    prefs.setString('downloadPath', '');
  }
  await initDirectoryData();
  await updateIgcseSubjects();
  await updateAlevelSubjects();
  await updateIgcseSubjectsMap();
  await updateAlevelSubjectsMap();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Past Paper Master',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MColors.accent,
        fontFamily: 'Inter',
        useMaterial3: false,
        brightness: Brightness.light,
      ),

      // TODO: [Micfong] restrict each provider's scope to its own page for better performance
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GeneralCN()),
          ChangeNotifierProvider(create: (_) => FilterCN()),
          ChangeNotifierProvider(create: (_) => BrowseCN()),
          ChangeNotifierProvider(create: (_) => CheckoutCN()),
          ChangeNotifierProvider(create: (_) => DownloadCN()),
          ChangeNotifierProvider(create: (_) => SettingsCN()),
          ChangeNotifierProvider(create: (_) => QuestionsCN()),
        ],
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static final List<Widget> _pages = [
    const PaperFilterPage(),
    const BrowsePage(),
    const CheckoutPage(),
    const DownloadsPage(),
    const SearchQuestionsPage(),
    const SettingsPage(),
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    globalContext = context;

    Future.delayed(
      Duration.zero,
      () => Once.runOnEveryNewBuild(
        callback: () => showReleaseNotesDialog(context),
      ),
    );

    Future.delayed(
      Duration.zero,
      () => Once.runEvery12Hours(
        'PPMAutoUpdateCheck',
        callback: () async {
          await context.read<SettingsCN>().checkForUpdates();
          if (!context.mounted) return;
          if (context.read<SettingsCN>().updateAvailable == true) {
            showUpdateDialog(
              context,
              '${context.read<SettingsCN>().latestVersion} (${DateFormat('yyyy-MM-dd').format(context.read<SettingsCN>().latestReleaseDate)})',
            );
          }
        },
      ),
    );

    final int selectedTab = context.watch<GeneralCN>().selectedTab;

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 312,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: MColors.grey.shade200),
              ),
              color: MColors.white,
            ),
            child: const SidebarView(),
          ),
          Expanded(
            child: Container(
              color: MColors.grey.shade50,
              child: selectedTab != 4
                  ? ListView(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            top: 32,
                            bottom: 48,
                            left: 32,
                            right: 32,
                          ),
                          child: _pages[selectedTab],
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.only(
                        top: 32,
                        left: 32,
                        right: 32,
                      ),
                      child: _pages[selectedTab],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
