import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock.dart';
import '../../auth_robot.dart';
import 'package:flutter_hb_salesforce/features/features.dart';

void main() {
  // testWidgets('Cancel logout', (tester) async {
  //   // pump
  //   await tester.pumpWidget(
  //     const ProviderScope(child: MaterialApp(home: AccountScreen())),
  //   );
  //   // find logout button and tap it
  //   final logoutButton = find.text('Logout');
  //   expect(logoutButton, findsOneWidget);
  //   await tester.tap(logoutButton);
  //   await tester.pump();

  //   // expect that the logout dialog is presented
  //   final dialogTitle = find.text('Are you sure?');
  //   expect(dialogTitle, findsOneWidget);

  //   // find cancel button and tap it
  //   final cancelButton = find.text('Cancel');
  //   expect(cancelButton, findsOneWidget);
  //   await tester.tap(cancelButton);
  //   await tester.pump();

  //   // expect that the logout dialog is no longer visible
  //   expect(dialogTitle, findsNothing);
  // });
  testWidgets('Cancel logout', (tester) async {
    final r = AuthRobot(tester);
    await r.pumpAccountScreen();
    await r.tapLogoutButton();
    r.expectLogoutDialogFound();
    await r.tapCancelButton();
    r.expectLogoutDialogNotFound();
  });
  testWidgets('Confirm logout, success', (tester) async {
    final r = AuthRobot(tester);
    // Use FakeAuthRepository with no delay to avoid pending timer issues
    // final authRepository = FakeAuthRepository(addDelay: false);

    // final authRepository =
    //     MockAuthRepository(); //FakeAuthRepository(addDelay: false);
    // when(
    //   () => authRepository.signOut(),
    // ).thenAnswer((_) => Future.delayed(const Duration(seconds: 1)));
    await r.pumpAccountScreen();
    await r.tapLogoutButton();
    r.expectLogoutDialogFound();
    await r.tapDialogLogoutButton();
    // Wait for dialog to close and the signOut async operation to complete
    await tester.pumpAndSettle();
    r.expectLogoutDialogNotFound();
    r.expectErrorAlertNotFound();
    // authRepository.dispose();
  });
  testWidgets('Confirm logout, failure', (tester) async {
    final r = AuthRobot(tester);
    final authRepository = MockAuthRepository();
    final exception = Exception('Connection Failed');
    when(() => authRepository.signOut()).thenThrow(exception);
    when(() => authRepository.authStateChanges).thenAnswer(
      (_) => Stream.value(const AppUser(uid: '123', email: 'test@test.com')),
    );
    await r.pumpAccountScreen(authRepository: authRepository);
    await r.tapLogoutButton();
    r.expectLogoutDialogFound();
    await r.tapDialogLogoutButton();
    r.expectErrorAlertFound();
  });
  testWidgets('Confirm logout, loading state 1', (tester) async {
    final r = AuthRobot(tester);
    final authRepository = MockAuthRepository();
    when(
      () => authRepository.signOut(),
    ).thenAnswer((_) => Future.delayed(const Duration(seconds: 1)));
    when(() => authRepository.authStateChanges).thenAnswer(
      (_) => Stream.value(const AppUser(uid: '123', email: 'test@test.com')),
    );
    await r.pumpAccountScreen(authRepository: authRepository);
    await tester.runAsync(() async {
      await r.tapLogoutButton();
      r.expectLogoutDialogFound();
      await r.tapDialogLogoutButton();
    });
    r.expectCircularProgressIndicator();
  });
  testWidgets('Confirm logout, loading state 2 same as 1', (tester) async {
    final r = AuthRobot(tester);
    final authRepository = MockAuthRepository();
    when(
      () => authRepository.signOut(),
    ).thenAnswer((_) => Future.delayed(const Duration(seconds: 1)));
    when(() => authRepository.authStateChanges).thenAnswer(
      (_) => Stream.value(const AppUser(uid: '123', email: 'test@test.com')),
    );
    await r.pumpAccountScreen(authRepository: authRepository);
    await r.tapLogoutButton();
    r.expectLogoutDialogFound();
    await r.tapDialogLogoutButton();
    // Pump frames to allow the async operation to start and loading state to appear
    await tester.pump();
    await tester.pump(); // Additional pump to ensure state update is processed
    r.expectCircularProgressIndicator();
    // Advance fake time so the mocked delay completes and no timers remain pending
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
  });
}
