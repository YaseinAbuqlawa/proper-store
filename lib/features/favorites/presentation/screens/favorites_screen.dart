import 'package:flutter/material.dart';
import 'package:proper_store/core/widgets/temporary_screen.dart';
import 'package:proper_store/generated/l10n.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TemporaryScreen(text: S.of(context).favoritesTitle);
  }
}
