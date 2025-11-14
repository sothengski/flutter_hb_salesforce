import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Sign in and sign out flow', (tester) async {
    final r = Robot(tester);
    await r.pumpMyApp();
    // r.products.expectFindAllProductCards();
    // await r.openPopupMenu();
    // await r.auth.openEmailPasswordSignInScreen();
    await r.auth.signInWithEmailAndPassword();
    r.expectFindAllProductCards();
    await r.openPopupMenu();
    await r.auth.openAccountScreen();
    await r.auth.tapLogoutButton();
    await r.auth.tapDialogLogoutButton();
    // Wait for logout to complete and navigation to login screen
    await tester.pumpAndSettle();
    await r.auth.signInWithEmailAndPassword();
    // r.expectFindAllProductCards();
  });
}
