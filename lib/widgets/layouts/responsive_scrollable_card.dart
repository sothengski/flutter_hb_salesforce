import 'package:flutter/material.dart';
import 'package:flutter_hb_salesforce/constants/constants.dart';
import 'package:flutter_hb_salesforce/widgets/layouts/responsive_center.dart';

/// A scrollable, responsive card with padding and max width.
/// Ideal for login, register, settings, forms, etc.
///
/// Features:
/// - Scrollable on small screens
/// - Centered with max width on large screens
/// - Consistent card + padding
/// - Uses loose constraints (Center + SizedBox)
class ResponsiveScrollableCard extends StatelessWidget {
  const ResponsiveScrollableCard({
    super.key,
    required this.child,
    this.maxContentWidth = Breakpoints.tablet,
    this.padding = const EdgeInsets.all(Sizes.p16),
  });

  final Widget child;
  final double maxContentWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Keyboard safe
      ),
      child: ResponsiveCenter(
        maxContentWidth: maxContentWidth,
        padding: padding,
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p24),
            child: child,
          ),
        ),
      ),
    );
  }
}

class ResponsiveSliverScrollableCard extends StatelessWidget {
  const ResponsiveSliverScrollableCard({
    super.key,
    required this.child,
    this.maxContentWidth = Breakpoints.tablet,
  });

  final Widget child;
  final double maxContentWidth;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ResponsiveScrollableCard(
        maxContentWidth: maxContentWidth,
        child: child,
      ),
    );
  }
}
