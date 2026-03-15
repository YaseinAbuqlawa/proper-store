import 'package:flutter/material.dart';
import 'package:proper_store_shared/design_system/colors/app_colors.dart';

class StoreLogo extends StatelessWidget {
  const StoreLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [AppColors.blackDeep, Colors.transparent],
        ),
      ),
      child: Image.asset(
        "assets/images/proper_logo.png",
        height: MediaQuery.of(context).size.height * .4,
      ),
    );
  }
}
