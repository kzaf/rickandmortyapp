import 'package:flutter/material.dart';

import '../../../constants/dimensions.dart';
import '../../../constants/strings.dart';
import '../../../constants/styles.dart';
import '../ui_model/home_list_item.dart';

class HomePageNameStatus extends StatelessWidget {
  const HomePageNameStatus({
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
        SizedBox(
          width: Dimensions.homePageListItemNameWidth,
          child: Text(
            allCharacters[index].name,
            style: AppTextStyle.listHomeItemTitle,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: Dimensions.homePageListItemSize,
              width: Dimensions.homePageListItemSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.homePageListItemCardStatusDecorationBorderRadius,
                ),
                color: allCharacters[index].status == Strings.aliveStatus
                    ? Colors.green
                    : allCharacters[index].status == Strings.deadStatus
                        ? Colors.red
                        : Colors.grey,
              ),
            ),
            SizedBox(
              width: Dimensions.homePageListItemSizedBoxWidth,
            ),
            Text(
              "${allCharacters[index].status.capitalize()} - ${allCharacters[index].species}",
              style: AppTextStyle.listHomeItemText,
            ),
          ],
        ),
      ],
    );
  }
}
