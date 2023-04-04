import 'package:flutter/material.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

const _currentDatePattern = 'EEEE, MMMM dd';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppDimensions.spacing20,
            top: AppDimensions.spacing28,
            right: AppDimensions.spacing20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formatCurrentDate(),
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: AppDimensions.spacing4),
                  Text(AppLocalizations.of(context)!.today,
                      style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppDimensions.spacing20),
              child: CircleAvatar(
                radius: AppDimensions.homeAvatarSize,
                backgroundImage: AssetImage(Assets.images.dummyAvatar.path),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat(_currentDatePattern).format(now).toUpperCase();
  }
}
