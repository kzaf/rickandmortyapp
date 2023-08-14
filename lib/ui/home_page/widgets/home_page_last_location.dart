import 'package:flutter/material.dart';

import '../../../constants/strings.dart';
import '../../../constants/styles.dart';
import '../ui_model/home_list_item.dart';

class HomePageLastLocation extends StatelessWidget {
  const HomePageLastLocation({
    super.key,
    required this.allCharacters,
    required this.index,
  });

  final List<HomeListItem> allCharacters;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.homePageLastKnownLocationLabel,
          style: AppTextStyle.listHomeItemLabel,
        ),
        Text(
          allCharacters[index].lastLocation,
          style: AppTextStyle.listHomeItemText,
        ),
      ],
    );
  }
}
