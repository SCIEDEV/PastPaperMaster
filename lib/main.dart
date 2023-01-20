import 'dart:io';
import 'package:past_paper_master/core/dirinit.dart';
import 'package:past_paper_master/pages/about.dart';
import 'package:past_paper_master/pages/download.dart';
import 'package:past_paper_master/pages/pseudocode.dart';
import 'package:past_paper_master/pages/question.dart';
import 'package:past_paper_master/pages/settings.dart';
import 'package:past_paper_master/pages/subjects.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/global.dart';
import 'package:past_paper_master/pages/checkout.dart';
import 'package:past_paper_master/pages/filter.dart';
import 'package:past_paper_master/pages/sidebar.dart';
import 'package:past_paper_master/pages/browse.dart';
import 'package:past_paper_master/core/provider.dart';
import 'package:provider/provider.dart';

void main() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      title: 'Past Paper Master',
      size: Size(1024, 800),
      minimumSize: Size(990, 645),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  await initDirectoryData();
  await updateIgcseSubjects();
  await updateAlevelSubjects();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return MaterialApp(
        title: 'Past Paper Master',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: MColors.accent, fontFamily: 'Inter'),
// TODO: [Micfong] restrict each provider's scope to its own page for better performance
//       however I'm too lazy to do this now :D
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => GeneralCN()),
            ChangeNotifierProvider(create: (_) => FilterCN()),
          ],
          child: const MyHomePage(),
        ));
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
    const PseudocodeRunnerPage(),
    const SettingsPage(),
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Container(
          width: 312,
          decoration: BoxDecoration(
            border: Border(
                right: BorderSide(color: MColors.grey.shade200, width: 1)),
            color: MColors.white,
          ),
          child: const SidebarView(),
        ),
        Expanded(
          child: Container(
              color: MColors.grey.shade50,
              child: ListView(
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                          top: 32, bottom: 48, left: 32, right: 32),
                      child: _pages[context.watch<GeneralCN>().selectedTab]),
                ],
              )),
        )
      ],
    ));
  }
}
