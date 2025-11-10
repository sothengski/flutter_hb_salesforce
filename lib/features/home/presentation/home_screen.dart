import 'package:flutter/material.dart';
import 'package:flutter_hb_salesforce/constants/constants.dart';
import 'package:flutter_hb_salesforce/features/features.dart';
import 'package:flutter_hb_salesforce/layouts/layouts.dart';
import 'package:flutter_hb_salesforce/utils/utils.dart';
import 'package:flutter_hb_salesforce/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      homeScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(homeScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          ActionTextButton(
            text: 'Logout',
            onPressed: state.isLoading
                ? null
                : () async {
                    final logout = await showAlertDialog(
                      context: context,
                      title: 'Are you sure?',
                      cancelActionText: 'Cancel',
                      defaultActionText: 'Logout',
                    );
                    if (logout == true) {
                      await ref
                          .read(homeScreenControllerProvider.notifier)
                          .signOut();
                    }
                  },
          ),
        ],
      ),

      body: const ResponsiveCenter(
        padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: UserDataTable(),
      ),
    );
  }
}

/// Simple user data table showing the uid and email
class UserDataTable extends ConsumerWidget {
  const UserDataTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme.titleSmall!;
    final user = ref.watch(authStateChangesProvider).value;
    return DataTable(
      columns: [
        DataColumn(label: Text('Field', style: style)),
        DataColumn(label: Text('Value', style: style)),
      ],
      rows: [
        _makeDataRow('uid', user?.uid ?? '', style),
        _makeDataRow('email', user?.email ?? '', style),
      ],
    );
  }

  DataRow _makeDataRow(String name, String value, TextStyle style) {
    return DataRow(
      cells: [
        DataCell(Text(name, style: style)),
        DataCell(Text(value, style: style, maxLines: 2)),
      ],
    );
  }
}
