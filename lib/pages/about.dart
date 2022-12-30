import 'package:flutter/material.dart';
import 'package:past_paper_master/components/badge.dart';
import 'package:past_paper_master/components/button.dart';
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
          style: MTextStyles.dsm_md_grey_900,
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
              style: MTextStyles.dxs_md_grey_900,
            ),
            const SizedBox(height: 16),
            MBadge(title: 'Alpha Version 0.1.0'),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Created with ❤️ by', style: MTextStyles.sm_rg_grey_900),
                Text(' Micfong ', style: MTextStyles.sm_sb_grey_900),
                Text('as a part of', style: MTextStyles.sm_rg_grey_900),
                Text(' SCIE.DEV', style: MTextStyles.sm_sb_grey_900),
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
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Text(
                      'Version information',
                      style: MTextStyles.sm_md_grey_700,
                    ),
                  ),
                  flex: 4,
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Version number',
                          style: MTextStyles.sm_rg_grey_500,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Build number',
                          style: MTextStyles.sm_rg_grey_500,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Database version',
                          style: MTextStyles.sm_rg_grey_500,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Last commit',
                          style: MTextStyles.sm_rg_grey_500,
                        ),
                      ]),
                  flex: 4,
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'α 0.1.0',
                          style: MTextStyles.sm_rg_grey_900,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '12',
                          style: MTextStyles.sm_rg_grey_900,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '1',
                          style: MTextStyles.sm_rg_grey_900,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '9baadb3ad75209244ded5b636f2bd624c3890a91',
                          style: MTextStyles.sm_rg_grey_900,
                        ),
                      ]),
                  flex: 7,
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
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Text(
                      'Sponsor me',
                      style: MTextStyles.sm_md_grey_700,
                    ),
                  ),
                  flex: 4,
                ),
                Expanded(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MButton(onPressed: () {}, title: 'Open Collective'),
                        SizedBox(width: 8),
                        MButton(onPressed: () {}, title: 'WeChat'),
                        SizedBox(width: 8),
                        MButton(onPressed: () {}, title: 'Alipay'),
                      ]),
                  flex: 10,
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
