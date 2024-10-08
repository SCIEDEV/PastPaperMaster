import 'dart:async';
import 'dart:io';

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
                    mainAxisAlignment: MainAxisAlignment.end,
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
                      const SizedBox(
                        width: 8,
                      )
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
          ],
        ),
        Divider(
          color: MColors.grey.shade300,
          height: 60,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ],
        ),
        Divider(color: MColors.grey.shade300, height: 60),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Automatic concurrent download count',
                      style: MTextStyles.smMdGrey700,
                    ),
                    Text(
                      context.read<SettingsCN>().concurrentDownloads == null
                          ? "PastPaperMaster will automatically determine the number of concurrent downloads"
                          : "",
                      style: MTextStyles.smRgGrey500,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Switch(
                  value: context.read<SettingsCN>().concurrentDownloads == null,
                  onChanged: (automaticConcurrentDownloadCount) {
                    final settingsCN = context.read<SettingsCN>();
                    if (automaticConcurrentDownloadCount) {
                      settingsCN.concurrentDownloads = null;
                    } else {
                      settingsCN.concurrentDownloads =
                          settingsCN.defaultConcurrentDownloads;
                    }
                  }),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Concurrent download count',
                      style: globalContext
                                  .read<SettingsCN>()
                                  .concurrentDownloads !=
                              null
                          ? MTextStyles.smMdGrey700
                          : MTextStyles.smMdGrey500,
                    ),
                    Text(
                      'How many papers to download at once',
                      style: globalContext
                                  .read<SettingsCN>()
                                  .concurrentDownloads !=
                              null
                          ? MTextStyles.smRgGrey500
                          : MTextStyles.smRgGrey300,
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(flex: 1, child: ConcurrentDownloadSettingForm())
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

class ConcurrentDownloadSettingForm extends StatefulWidget {
  const ConcurrentDownloadSettingForm({super.key});

  @override
  ConcurrentDownloadSettingFormState createState() {
    return ConcurrentDownloadSettingFormState();
  }
}

class ConcurrentDownloadSettingFormState
    extends State<ConcurrentDownloadSettingForm> {
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController(
      text: globalContext.read<SettingsCN>().concurrentDownloads?.toString());
  Timer? _debounceTimer;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () {
        if (_debounceTimer?.isActive == true) {
          _debounceTimer?.cancel();
        }
        _debounceTimer = Timer(const Duration(milliseconds: 500), () {
          if (_formKey.currentState!.validate()) {
            setConcurrentDownloadCountAndShowSnackbar(context);
          }
        });
      },
      child: Column(
        children: <Widget>[
          Consumer<SettingsCN>(builder: (context, settings, child) {
            return TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.number,
                controller: _textFieldController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MColors.grey.shade300)),
                    isDense: true,
                    suffixText: "/${Platform.numberOfProcessors}"),
                enabled: settings.concurrentDownloads != null,
                onEditingComplete: () {
                  if (_formKey.currentState!.validate()) {
                    // Cancel the debounce timer so that it doesn't trigger the snackbar a second time.
                    _debounceTimer?.cancel();
                    setConcurrentDownloadCountAndShowSnackbar(context);
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return "A number of concurrent downloads is required";
                  }
                  int? parsedValue = int.tryParse(value);
                  if (parsedValue == null) {
                    return "Provide a number of concurrent downloads";
                  }

                  if (parsedValue > Platform.numberOfProcessors) {
                    return "Max supported number of concurrent downloads on your device is ${Platform.numberOfProcessors}";
                  }

                  return null;
                });
          })
        ],
      ),
    );
  }

  void setConcurrentDownloadCountAndShowSnackbar(BuildContext context) {
    final concurrentDownloadCount = int.parse(_textFieldController.text);
    globalContext.read<SettingsCN>().concurrentDownloads =
        concurrentDownloadCount;
    final snackBar = SnackBar(
      content:
          Text("Concurrent download count set to: $concurrentDownloadCount"),
      duration: const Duration(seconds: 1),
    );
    // Remove the current snackbar, so the user isn't flooded with confirmations about having changed the concurrent download count.
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
}
