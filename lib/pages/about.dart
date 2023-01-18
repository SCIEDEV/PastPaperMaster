import 'package:flutter/material.dart';
import 'package:past_paper_master/components/badge.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/global.dart';
import 'package:past_paper_master/textstyle.dart';
import 'package:past_paper_master/colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Past Paper Master',
          style: MTextStyles.dsmMdGrey900,
        ),
        const SizedBox(height: 36),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/appicon-rounded.png',
              width: 128,
              height: 128,
            ),
            const SizedBox(height: 16, width: double.infinity),
            Text(
              'Past Paper Master',
              style: MTextStyles.dxsMdGrey900,
            ),
            const SizedBox(height: 16),
            const MBadge(
                title:
                    '$kAppStage $kMajorVersion.$kMinorVersion.$kPatchVersion'),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Created by ', style: MTextStyles.smRgGrey900),
                Image.asset(
                  'assets/images/micfong.png',
                  height: 12,
                ),
                Text(' as a part of', style: MTextStyles.smRgGrey900),
                Text(' SCIE.DEV', style: MTextStyles.smSbGrey900),
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
                    child: Text(
                      'Version information',
                      style: MTextStyles.smMdGrey700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Version number',
                          style: MTextStyles.smRgGrey500,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Build number',
                          style: MTextStyles.smRgGrey500,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Database version',
                          style: MTextStyles.smRgGrey500,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Last commit',
                          style: MTextStyles.smRgGrey500,
                        ),
                      ]),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$kAppStageShort$kMajorVersion.$kMinorVersion.$kPatchVersion',
                          style: MTextStyles.smRgGrey900,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$kBuildNumber',
                          style: MTextStyles.smRgGrey900,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$kDatabaseVersion',
                          style: MTextStyles.smRgGrey900,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          kLastCommitHash,
                          style: MTextStyles.smRgGrey900,
                        ),
                      ]),
                ),
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
                    child: Text(
                      'Sponsor me',
                      style: MTextStyles.smMdGrey700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MButton(onPressed: () {}, title: 'Open Collective'),
                        const SizedBox(width: 8),
                        MButton(onPressed: () {}, title: 'WeChat'),
                        const SizedBox(width: 8),
                        MButton(onPressed: () {}, title: 'Alipay'),
                      ]),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
