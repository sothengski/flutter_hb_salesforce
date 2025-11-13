import 'package:flutter/material.dart';
import 'package:flutter_hb_salesforce/widgets/widgets.dart';

/// Button used to initiate the payment flow.
class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key});

  Future<void> _pay(BuildContext context) async {
    // TODO: Implement
    showNotImplementedAlertDialog(context: context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: error handling
    // TODO: loading state
    return PrimaryButton(
      text: 'Pay',
      isLoading: false,
      onPressed: () => _pay(context),
    );
  }
}
