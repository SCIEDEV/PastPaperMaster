import 'package:flutter/material.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:past_paper_master/core/global.dart';

class MAlertDialogNoDownloadPath extends StatelessWidget {
  const MAlertDialogNoDownloadPath({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MColors.white,
      titleTextStyle: MTextStyles.lgMdGrey900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Text("No download path selected"),
      content: Text("Please select a download path in the settings page.",
          style: MTextStyles.smRgGrey500),
      actions: [
        MButton(
          title: 'Dismiss',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

Future<dynamic> showReleaseNotesDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: MColors.white,
      titleTextStyle: MTextStyles.lgMdGrey900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Text(
          "Past Paper Master updated to $kAppStageShort$kMajorVersion.$kMinorVersion.$kPatchVersion (build $kBuildNumber)"),
      content: const MarkdownBlock(data: kReleaseNotes),
      actions: [
        MButton(
          title: 'Dismiss',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
