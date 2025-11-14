import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hb_salesforce/constants/app_sizes.dart';
import 'package:flutter_hb_salesforce/features/features.dart';
import 'package:flutter_hb_salesforce/utils/utils.dart';
import 'package:flutter_hb_salesforce/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget that shows an [ItemQuantitySelector] along with a [PrimaryButton]
/// to add the selected quantity of the item to the cart.
class AddToCartWidget extends ConsumerWidget {
  const AddToCartWidget({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<int>>(
      addToCartControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final availableQuantity = ref.watch(itemAvailableQuantityProvider(product));
    final state = ref.watch(addToCartControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quantity:'),
            ItemQuantitySelector(
              quantity: state.value!,
              // quantity: state.value ?? 1,
              // let the user choose up to the available quantity or
              // 10 items at most
              maxQuantity: min(availableQuantity, 10),
              onChanged: state.isLoading
                  ? null
                  : (quantity) => ref
                        .read(addToCartControllerProvider.notifier)
                        .updateQuantity(quantity),
            ),
          ],
        ),
        gapH8,
        const Divider(),
        gapH8,
        PrimaryButton(
          isLoading: state.isLoading,
          // only enable the button if there is enough stock
          onPressed: availableQuantity > 0
              ? () => ref
                    .read(addToCartControllerProvider.notifier)
                    .addItem(product.id)
              : null,
          text: availableQuantity > 0 ? 'Add to Cart' : 'Out of Stock',
        ),
        if (product.availableQuantity > 0 && availableQuantity == 0) ...[
          gapH8,
          Text(
            'Already added to cart',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
