import 'package:flutter/material.dart';
import 'package:past_paper_master/components/badge.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/components/dialogs.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/global.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:url_launcher/url_launcher.dart';

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
          children: [
            const ColumnAboutPageLeading(),
            Divider(
              color: MColors.grey.shade300,
              height: 60,
            ),
            const RowVersionInformation(),
            Divider(
              color: MColors.grey.shade300,
              height: 60,
            ),
            const RowNewInThisVersion(),
            Divider(
              color: MColors.grey.shade300,
              height: 60,
            ),
            const RowSponsorshipSupport(),
          ],
        ),
      ],
    );
  }
}

class ColumnAboutPageLeading extends StatelessWidget {
  const ColumnAboutPageLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          title: '$kAppStage $kMajorVersion.$kMinorVersion.$kPatchVersion',
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Created by ', style: MTextStyles.smRgGrey900),
            Text('Micfong', style: MTextStyles.smSbGrey900),
            Text(' as a part of', style: MTextStyles.smRgGrey900),
            Text(' SCIE.DEV', style: MTextStyles.smSbGrey900),
          ],
        ),
      ],
    );
  }
}

class RowNewInThisVersion extends StatelessWidget {
  const RowNewInThisVersion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Text(
              'Release notes',
              style: MTextStyles.smMdGrey700,
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MButton(
                onPressed: () {
                  showReleaseNotesDialog(context);
                },
                title:
                    'Open $kAppStageShort$kMajorVersion.$kMinorVersion.$kPatchVersion Release Notes',
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}

class RowSponsorshipSupport extends StatelessWidget {
  const RowSponsorshipSupport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Text(
              'Sponsorship & Support',
              style: MTextStyles.smMdGrey700,
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MButton(
                onPressed: () {
                  safeLaunchUrl('https://github.com/SCIEDEV/PastPaperMaster');
                },
                title: 'GitHub',
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}

class RowVersionInformation extends StatelessWidget {
  const RowVersionInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
            ],
          ),
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
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> safeLaunchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw 'Could not launch $uri';
  }
}
