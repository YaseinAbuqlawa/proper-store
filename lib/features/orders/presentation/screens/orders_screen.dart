import 'package:flutter/material.dart';
import 'package:proper_store/core/widgets/initial_screen_widget.dart';
import 'package:proper_store/generated/l10n.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemporaryScreen(text: S.of(context).ordersTitle);
  }
}
