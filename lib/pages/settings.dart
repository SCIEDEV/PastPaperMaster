import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:past_paper_master/core/global.dart';
import 'package:provider/provider.dart';
import 'package:past_paper_master/core/provider.dart';
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
                    ]),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    MButton(onPressed: () {}, title: 'Check for updates'),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your version: $kAppStageShort$kMajorVersion.$kMinorVersion.$kPatchVersion ($kBuildNumber-$kDatabaseVersion)',
                          style: MTextStyles.smRgGrey500,
                        ),
                        Text(
                          'Lastest version: α 0.1.0 (13-2)',
                          style: MTextStyles.smRgGrey500,
                        ),
                      ],
                    ),
                  ]),
                  Divider(
                    color: MColors.grey.shade300,
                    height: 60,
                  ),
                  Text('A newer database is available!',
                      style: MTextStyles.smMdGrey700),
                  const SizedBox(height: 8),
                  Text('This database update includes papers until June 2022.',
                      style: MTextStyles.smRgGrey500),
                  const SizedBox(height: 8),
                  MButton(
                    onPressed: () {},
                    title: 'Update now',
                    primary: true,
                  ),
                  Divider(
                    color: MColors.grey.shade300,
                    height: 60,
                  ),
                  Text('A newer release is available!',
                      style: MTextStyles.smMdGrey700),
                  const SizedBox(height: 8),
                  Text(
                      'This release includes minor bug fixes and improvements.',
                      style: MTextStyles.smRgGrey500),
                  const SizedBox(height: 8),
                  MButton(
                    onPressed: () {},
                    title: 'Download v0.2.0',
                    primary: true,
                  ),
                ],
              ),
            ),
            Expanded(flex: 1, child: Container())
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
                    ]),
              ),
            ),
            Expanded(
              flex: 7,
              child: MLongButton(
                onPressed: () async {
                  String? selectedDirectory = await FilePicker.platform
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
            Expanded(flex: 1, child: Container())
          ],
        ),
      ],
    );
  }
}
