import 'package:flutter/material.dart';
import 'package:proper_store/core/shared_feature/presentation/widgets/temporary_screen.dart';
import 'package:proper_store/generated/l10n.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemporaryScreen(text: S.of(context).cartTitle);
  }
}
