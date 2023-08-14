import 'package:flutter/material.dart';

import '../../../constants/dimensions.dart';
import '../ui_model/home_list_item.dart';

class HomePageListImage extends StatelessWidget {
  const HomePageListImage({
    super.key,
    required this.allCharacters,
    required this.index,
  });

  final List<HomeListItem> allCharacters;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              Dimensions.homePageListItemCardIconRadius,
            ),
            bottomLeft: Radius.circular(
              Dimensions.homePageListItemCardIconRadius,
            ),
          ),
          child: Image.network(
            allCharacters[index].image,
            width: Dimensions.homePageListItemCardIconSize,
            height: Dimensions.homePageListItemCardIconSize,
          ),
        ),
      ],
    );
  }
}
