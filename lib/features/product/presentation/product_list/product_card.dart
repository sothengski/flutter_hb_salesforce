import 'package:flutter/material.dart';
import 'package:flutter_hb_salesforce/constants/constants.dart';
import 'package:flutter_hb_salesforce/features/product/product_features.dart';
import 'package:flutter_hb_salesforce/utils/currency_formatter.dart';
import 'package:flutter_hb_salesforce/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Used to show a single product inside a card.
class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product, this.onPressed});
  final Product product;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const productCardKey = Key('product-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceFormatted = ref
        .watch(currencyFormatterProvider)
        .format(product.price);
    return Card(
      child: InkWell(
        key: productCardKey,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomImage(imageUrl: product.imageUrl),
              gapH8,
              const Divider(),
              gapH8,
              Text(
                product.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (product.numRatings >= 1) ...[
                gapH8,
                // ProductAverageRating(product: product),
              ],
              gapH24,
              Text(
                priceFormatted,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              gapH4,
              Text(
                product.availableQuantity <= 0
                    ? 'Out of Stock'
                    : 'Quantity: ${product.availableQuantity}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
