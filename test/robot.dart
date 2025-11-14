import 'package:flutter_hb_salesforce/constants/test_products.dart';
import 'package:flutter_hb_salesforce/features/auth/auth.dart';
import 'package:flutter_hb_salesforce/features/home/home_features.dart';
import 'package:flutter_hb_salesforce/features/product/product_features.dart';
import 'package:flutter_hb_salesforce/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'features/auth/auth_robot.dart';

class Robot {
  Robot(this.tester) : auth = AuthRobot(tester);

  final WidgetTester tester;
  final AuthRobot auth;

  Future<void> pumpMyApp() async {
    // Override repositories
    final productsRepository = FakeProductsRepository(addDelay: false);
    final authRepository = FakeAuthRepository(addDelay: false);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          productsRepositoryProvider.overrideWithValue(productsRepository),
          authRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> openPopupMenu() async {
    final finder = find.byType(MoreMenuButton);
    final matches = finder.evaluate();
    // if an item is found, it means that we're running
    // on a small window and can tap to reveal the menu
    if (matches.isNotEmpty) {
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }
    // else no-op, as the items are already visible
  }

  Future<void> expectFindAllProductCards() async {
    // Wait for ProductCards to appear (products load asynchronously)
    await tester.pumpAndSettle();
    // Wait for products to load by pumping until ProductCards appear
    final finder = find.byType(ProductCard);
    var attempts = 0;
    while (finder.evaluate().isEmpty && attempts < 50) {
      await tester.pump(const Duration(milliseconds: 100));
      attempts++;
    }
    expect(finder, findsNWidgets(kTestProducts.length));
  }
}
