import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class AppDialog {
  static Future<dynamic> showLoading(BuildContext context) => AwesomeDialog(
    context: context,
    dismissOnBackKeyPress: false,
    dialogType: DialogType.noHeader,
    customHeader: const CircularProgressIndicator(),
    title: S.of(context).loadingTitle,
  ).show();
}
