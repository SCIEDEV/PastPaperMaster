import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/global.dart';
import 'package:past_paper_master/core/provider.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:past_paper_master/pages/about.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: MTextStyles.dsmMdGrey900,
        ),
        const SizedBox(height: 36),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Version updates',
                      style: MTextStyles.smMdGrey700,
                    ),
                    Text(
                      'Check for updates to receive the latest features and bug fixes.',
                      style: MTextStyles.smRgGrey500,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MButton(
                        onPressed: () {
                          context.read<SettingsCN>().checkForUpdates();
                        },
                        disabled: context.watch<SettingsCN>().checkingUpdates,
                        title: 'Check for updates',
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current version: $kVersionTag',
                            style: MTextStyles.smRgGrey500,
                          ),
                          if (context.watch<SettingsCN>().checkUpdatesFailed)
                            Text(
                              'Failed to check for updates.',
                              style: MTextStyles.smMdAccent700,
                            )
                          else if (context.watch<SettingsCN>().checkingUpdates)
                            Text(
                              'Checking for updates...',
                              style: MTextStyles.smRgGrey500,
                            )
                          else if (context
                                  .watch<SettingsCN>()
                                  .updateAvailable ==
                              true)
                            Text(
                              'Latest version: ${context.watch<SettingsCN>().latestVersion}',
                              style: MTextStyles.smMdGrey700,
                            )
                          else if (context
                                  .watch<SettingsCN>()
                                  .updateAvailable ==
                              false)
                            Text(
                              'You are up to date.',
                              style: MTextStyles.smRgGrey500,
                            )
                          else
                            Text(
                              'Updates unchecked.',
                              style: MTextStyles.smRgGrey500,
                            ),
                        ],
                      ),
                    ],
                  ),
                  if (context.watch<SettingsCN>().updateAvailable == true) ...[
                    Divider(
                      color: MColors.grey.shade300,
                      height: 60,
                    ),
                    Row(
                      children: [
                        Text(
                          'A newer release is available!',
                          style: MTextStyles.smMdGrey700,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${DateFormat('yyyy-MM-dd').format(context.watch<SettingsCN>().latestReleaseDate)})',
                          style: MTextStyles.smRgGrey500,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Check out release notes on Github to see what's new.",
                      style: MTextStyles.smRgGrey500,
                    ),
                    const SizedBox(height: 8),
                    MButton(
                      onPressed: () {
                        safeLaunchUrl(
                          context.read<SettingsCN>().latestReleaseUrl,
                        );
                      },
                      title:
                          'Download ${context.watch<SettingsCN>().latestVersion} on GitHub',
                      primary: true,
                    ),
                  ],
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        Divider(
          color: MColors.grey.shade300,
          height: 60,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Download path',
                      style: MTextStyles.smMdGrey700,
                    ),
                    Text(
                      'Path where papers are downloaded to.',
                      style: MTextStyles.smRgGrey500,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: MLongButton(
                onPressed: () async {
                  final String? selectedDirectory = await FilePicker.platform
                      .getDirectoryPath(dialogTitle: "Select download path");
                  if (selectedDirectory != null) {
                    // ignore: use_build_context_synchronously
                    globalContext.read<DownloadCN>().downloadPath =
                        selectedDirectory;
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('downloadPath', selectedDirectory);
                  }
                },
                title: context.watch<DownloadCN>().downloadPath == ''
                    ? 'Download path'
                    : context.read<DownloadCN>().downloadPath,
                iconName: 'download',
                placeholder: context.read<DownloadCN>().downloadPath == '',
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        Divider(
          color: MColors.grey.shade300,
          height: 60,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme selection',
                      style: MTextStyles.smMdGrey700,
                    ),
                    if (context.watch<SettingsCN>().specialTheme) ...[
                      Text(
                        'Happy birthday, my friend.',
                        style: MTextStyles.smRgGrey500,
                      ),
                    ] else ...[
                      Text(
                        'Choose a theme that suits you.',
                        style: MTextStyles.smRgGrey500,
                      ),
                    ]
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: MButtonGroup(
                titles: const ['Default', 'Surtr'],
                selected: context.watch<SettingsCN>().specialTheme ? 1 : 0,
                onPressed: (context, index) {
                  context.read<SettingsCN>().specialTheme = index == 1;
                },
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        if (context.watch<SettingsCN>().specialTheme) ...[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme background',
                          style: MTextStyles.smMdGrey700,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: MButtonGroup(
                    titles: const ['#01', '#02', '#03', '#04', '#05'],
                    selected: context.watch<SettingsCN>().specialThemeBg,
                    onPressed: (context, index) {
                      context.read<SettingsCN>().specialThemeBg = index;
                    },
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Divider(
            color: MColors.grey.shade300,
            height: 60,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Happy birthday to ',
                      style: MTextStyles.smMdGrey700,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/jkl-avatar.jpg',
                        width: 128,
                        height: 128,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        safeLaunchUrl(
                            'https://steamcommunity.com/profiles/76561198405632554/');
                      },
                      textColor: MColors.accent.shade700,
                      child: Text(
                        '@jkl',
                        style: MTextStyles.smMdAccent700,
                      ),
                    ),
                    Text(
                      'on 2024-06-16',
                      style: MTextStyles.smMdGrey500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
