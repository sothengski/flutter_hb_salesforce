// import 'package:flutter_hb_salesforce/features/auth/auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';

// class HomeScreenController extends StateNotifier<AsyncValue> {
//   HomeScreenController({required this.authRepository})
//     : super(const AsyncData(null));
//   final AuthRepository authRepository;

//   Future<bool> signOut() async {
//     state = const AsyncLoading();
//     state = await AsyncValue.guard(() => authRepository.signOut());
//     return state.hasError == false;
//   }
// }

// final homeScreenControllerProvider =
//     StateNotifierProvider.autoDispose<HomeScreenController, AsyncValue<void>>((
//       ref,
//     ) {
//       final authRepository = ref.watch(authRepositoryProvider);
//       return HomeScreenController(authRepository: authRepository);
//     });
