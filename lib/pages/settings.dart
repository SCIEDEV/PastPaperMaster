import 'package:flutter/material.dart';
import 'package:past_paper_master/colors.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/textstyle.dart';
import 'package:past_paper_master/global.dart';

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
                onPressed: () {},
                title: 'Download path',
                iconName: 'download',
                placeholder: true,
              ),
            ),
            Expanded(flex: 1, child: Container())
          ],
        ),
      ],
    );
  }
}
