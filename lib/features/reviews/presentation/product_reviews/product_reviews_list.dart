import 'package:flutter/material.dart';
import 'package:flutter_hb_salesforce/constants/constants.dart';
import 'package:flutter_hb_salesforce/features/features.dart';
import 'package:flutter_hb_salesforce/widgets/widgets.dart';

/// Shows the list of reviews for a given product ID
class ProductReviewsList extends StatelessWidget {
  const ProductReviewsList({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source
    final reviews = <Review>[
      Review(
        date: DateTime(2022, 2, 12),
        score: 4.5,
        comment: 'Great product, would buy again!',
      ),
      Review(
        date: DateTime(2022, 2, 10),
        score: 4.0,
        comment: 'Looks great but the packaging was damaged.',
      ),
    ];
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => ResponsiveCenter(
          maxContentWidth: Breakpoints.tablet,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p16,
            vertical: Sizes.p8,
          ),
          child: ProductReviewCard(reviews[index]),
        ),
        childCount: reviews.length,
      ),
    );
  }
}
