import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proper_store/core/design_system/colors/app_colors.dart';
import 'package:proper_store/core/design_system/spacing/app_spacing.dart';
import 'package:proper_store/core/design_system/typography/app_text_styles.dart';
import 'package:proper_store/core/widgets/app_spacer.dart';

class OfferEndTimeCounter extends StatefulWidget {
  final DateTime endDate;
  const OfferEndTimeCounter({super.key, required this.endDate});

  @override
  State<OfferEndTimeCounter> createState() => _OfferEndTimeCounterState();
}

class _OfferEndTimeCounterState extends State<OfferEndTimeCounter> {
  DateTime currentDateTime = DateTime.now();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (time) {
      if (mounted) {
        setState(() {
          currentDateTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Duration remainingTime = widget.endDate.difference(currentDateTime);
    int days = 0, hours = 0, minutes = 0, seconds = 0;

    if (!remainingTime.isNegative) {
      days = remainingTime.inDays;
      hours = remainingTime.inHours % 24;
      minutes = remainingTime.inMinutes % 60;
      seconds = remainingTime.inSeconds % 60;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: .7,
          color: AppColors.goldMuted.withValues(alpha: .5),
        ),
        borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
      ),
      padding: EdgeInsets.all(AppSpacing.small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ListTile(
              title: Text(
                "عروض محدودة",
                style: AppTextStyles.badgeText.copyWith(
                  color: AppColors.goldMuted,
                ),
              ),
              subtitle: Text(
                "ينتهي العرض خلال",
                style: AppTextStyles.navLabel.copyWith(fontSize: 16),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TimerColumn(number: days.toString(), label: "يوم"),
              _VerticalDivider(),
              _TimerColumn(number: hours.toString(), label: "ساعة"),
              _VerticalDivider(),
              _TimerColumn(number: minutes.toString(), label: "دقيقة"),
              _VerticalDivider(),
              _TimerColumn(number: seconds.toString(), label: "ثانية"),
              AppSpacer(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimerColumn extends StatelessWidget {
  final String number;
  final String label;
  const _TimerColumn({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(number, style: AppTextStyles.sectionTitle.copyWith(height: 1)),
          Text(
            label,
            style: AppTextStyles.bodyDescription.copyWith(
              fontSize: 8,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 20, color: AppColors.goldMuted);
  }
}
