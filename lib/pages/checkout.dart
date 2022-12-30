import 'package:flutter/material.dart';
import 'package:past_paper_master/colors.dart';
import 'package:past_paper_master/textstyle.dart';
import 'package:rive/rive.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Checkout',
          style: MTextStyles.dsm_md_grey_900,
        ),
        const SizedBox(height: 36),
        Container(
          decoration: BoxDecoration(
              color: MColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: MColors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                    color: Color(0x19101828),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: -2),
                BoxShadow(
                    color: Color(0x10101828),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: -2),
              ]),
          child: Column(
            children: [
              CheckoutTableHeader(),
              NoCheckoutPlaceholder(),
            ],
          ),
        ),
      ],
    );
  }
}

class CheckoutTableHeader extends StatelessWidget {
  const CheckoutTableHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MColors.grey.shade50,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Row(children: [
        Expanded(
            child: Text(
              'Document name',
              style: MTextStyles.xs_md_grey_500,
            ),
            flex: 1),
        Expanded(
            child: Text(
              'Document type',
              style: MTextStyles.xs_md_grey_500,
            ),
            flex: 1),
      ]),
    );
  }
}

class NoCheckoutPlaceholder extends StatelessWidget {
  const NoCheckoutPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: MColors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          border: Border.all(
              color: MColors.grey.shade200,
              width: 1,
              strokeAlign: StrokeAlign.outside),
        ),
        padding: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              child: RiveAnimation.asset(
                'assets/rive/empty_folder.riv',
                artboard: 'empty checkout',
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 8,
              width: double.infinity,
            ),
            Text(
              'Nothing to checkout',
              style: MTextStyles.md_md_grey_900,
            ),
            SizedBox(
              height: 4,
              width: double.infinity,
            ),
            Text(
              'Seems like you haven\'t added any documents to checkout.',
              style: MTextStyles.sm_rg_grey_500,
            ),
          ],
        ));
  }
}
