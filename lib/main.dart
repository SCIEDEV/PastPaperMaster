import 'package:flutter/material.dart';
import 'package:past_paper_master/colors.dart';
import 'package:past_paper_master/global.dart';
import 'package:past_paper_master/pages/filter.dart';
import 'package:past_paper_master/pages/sidebar.dart';
import 'package:past_paper_master/provider.dart';
import 'package:provider/provider.dart';

void main() {
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
      home: ChangeNotifierProvider(
        create: (context) => GeneralStates(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
          child: SidebarView(),
        ),
        Expanded(
          child: Container(
              color: MColors.grey.shade50,
              child: ListView(
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          top: 32, bottom: 48, left: 32, right: 32),
                      child: PaperFilterPage()),
                ],
              )),
        )
      ],
    ));
  }
}
