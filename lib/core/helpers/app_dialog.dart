import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AppDialog {
  static Future<dynamic> showLoading(BuildContext context) => AwesomeDialog(
    context: context,
    dismissOnBackKeyPress: false,
    dialogType: DialogType.noHeader,
    customHeader: CircularProgressIndicator(),
    title: "جاري التحميل",
  ).show();
}
