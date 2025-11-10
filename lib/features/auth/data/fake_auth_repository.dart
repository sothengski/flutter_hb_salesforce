import 'package:flutter_hb_salesforce/features/auth/auth.dart';
import 'package:flutter_hb_salesforce/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthRepository {
  Stream<AppUser?> get authStateChanges;

  AppUser? get currentUser;
  Future<void> createUserWithEmailAndPassword(String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  void dispose();
}

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.addDelay = true});
  final bool addDelay;

  final _authState = InMemoryStore<AppUser?>(null);

  @override
  Stream<AppUser?> get authStateChanges => _authState.stream;
  @override
  AppUser? get currentUser => _authState.value;

  @override
  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await delay(addDelay);
    _createNewUser(email);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await delay(addDelay);
  }

  @override
  Future<void> signOut() async {
    await delay(addDelay);
    // throw Exception('Connection failed');
    _authState.value = null;
  }

  @override
  void dispose() => _authState.close();

  void _createNewUser(String email) {
    _authState.value = AppUser(
      uid: email.split('').reversed.join(),
      email: email,
    );
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final auth = FakeAuthRepository();
  ref.onDispose(() => auth.dispose());
  return auth;
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});
