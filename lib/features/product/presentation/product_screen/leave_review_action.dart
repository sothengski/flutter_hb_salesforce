import 'package:flutter/material.dart';
import 'package:flutter_hb_salesforce/constants/constants.dart';
import 'package:flutter_hb_salesforce/features/features.dart';
import 'package:flutter_hb_salesforce/router/app_router.dart';
import 'package:flutter_hb_salesforce/utils/utils.dart';
import 'package:flutter_hb_salesforce/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Simple widget to show the product purchase date along with a button to
/// leave a review.
class LeaveReviewAction extends ConsumerWidget {
  const LeaveReviewAction({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Read from data source
    final purchase = Purchase(orderId: 'abc', orderDate: DateTime.now());
    // ignore: unnecessary_null_comparison
    if (purchase != null) {
      final dateFormatted = ref
          .watch(dateFormatterProvider)
          .format(purchase.orderDate);
      return Column(
        children: [
          const Divider(),
          gapH8,
          ResponsiveTwoColumnLayout(
            spacing: Sizes.p16,
            breakpoint: 300,
            startFlex: 3,
            endFlex: 2,
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            rowCrossAxisAlignment: CrossAxisAlignment.center,
            columnCrossAxisAlignment: CrossAxisAlignment.center,
            startContent: Text('Purchased on $dateFormatted'),
            endContent: CustomTextButton(
              text: 'Leave a review',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Colors.green[700]),
              onPressed: () => context.goNamed(
                AppRoute.leaveReview.name,
                pathParameters: {'id': productId},
              ),
            ),
          ),
          gapH8,
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
