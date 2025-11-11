import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen<AsyncValue>(
    //   homeScreenControllerProvider,
    //   (_, state) => state.showAlertDialogOnError(context),
    // );
    // final state = ref.watch(homeScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        // actions: [
        //   ActionTextButton(
        //     text: 'Logout',
        //     onPressed: state.isLoading
        //         ? null
        //         : () async {
        //             final logout = await showAlertDialog(
        //               context: context,
        //               title: 'Are you sure?',
        //               cancelActionText: 'Cancel',
        //               defaultActionText: 'Logout',
        //             );
        //             if (logout == true) {
        //               await ref
        //                   .read(homeScreenControllerProvider.notifier)
        //                   .signOut();
        //             }
        //           },
        //   ),
        // ],
      ),

      body: const Text("home screen"),
      // const ResponsiveCenter(
      //   padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
      //   child: UserDataTable(),
      // ),
    );
  }
}
