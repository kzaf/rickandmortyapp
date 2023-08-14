import 'package:flutter/material.dart';
import 'package:rickandmortyapp/constants/dimensions.dart';
import 'package:rickandmortyapp/ui/home_page/ui_model/home_list_item.dart';
import 'package:rickandmortyapp/ui/details_page/pages/details_page.dart';

import 'home_page_first_seen.dart';
import 'home_page_image.dart';
import 'home_page_last_location.dart';
import 'home_page_name_status.dart';

class HomePageListItem extends StatelessWidget {
  final int index;
  final List<HomeListItem> allCharacters;

  const HomePageListItem({
    super.key,
    required this.allCharacters,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: Dimensions.homePageListItemCardMargin,
        right: Dimensions.homePageListItemCardMargin,
        top: Dimensions.homePageListItemCardMargin,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Dimensions.homePageListItemCardRadius,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => DetailsPage(
                index: index,
                name: allCharacters[index].name,
              ),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            HomePageListImage(allCharacters: allCharacters, index: index),
            SizedBox(
              width: Dimensions.homePageListItemSizedBoxHeight,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomePageNameStatus(allCharacters: allCharacters, index: index),
                SizedBox(
                  height: Dimensions.homePageListItemSizedBoxHeight,
                ),
                HomePageLastLocation(
                    allCharacters: allCharacters, index: index),
                SizedBox(
                  height: Dimensions.homePageListItemSizedBoxHeight,
                ),
                HomePageFirstSeen(allCharacters: allCharacters, index: index),
                SizedBox(
                  height: Dimensions.homePageListItemSizedBoxHeight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
