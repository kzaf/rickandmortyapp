import 'package:flutter/material.dart';
import 'package:rickandmortyapp/constants/dimensions.dart';
import 'package:rickandmortyapp/ui/ui_model/home_list_item.dart';
import 'package:rickandmortyapp/ui/pages/details_page.dart';
import 'package:rickandmortyapp/ui/widgets/loading_indicator.dart';

import '../../constants/strings.dart';
import '../../constants/styles.dart';

class HomePageListView extends StatelessWidget {
  final ScrollController scrollController;
  final List<HomeListItem> allCharacters;
  final bool showLoader;
  final String? nextPageUrl;

  const HomePageListView({
    super.key,
    required this.allCharacters,
    required this.scrollController,
    required this.showLoader,
    required this.nextPageUrl
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey(0),
      controller: scrollController,
      itemCount: allCharacters.length + (showLoader ? 1 : 0),
      itemBuilder: (context, index) {
        return 
        nextPageUrl != null
          ? index >= allCharacters.length
              ? const LoadingIndicator()
              : _buildDataListItem(context, index)
          : _buildDataListItemEmpty(context, index);
      },
    );
  }

  Widget _buildDataListItem(context, index) {
    return Card(
      margin: EdgeInsets.only(
        left: Dimensions.homePageListItemCardMargin,
        right: Dimensions.homePageListItemCardMargin,
        top: Dimensions.homePageListItemCardMargin
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (BuildContext context) => DetailsPage(index: index, name: allCharacters[index].name)
            )
          );
        },
        child: Row(
          children: <Widget> [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.homePageListItemCardIconRadius), 
                    bottomLeft: Radius.circular(Dimensions.homePageListItemCardIconRadius)
                  ),
                  child: Image.network(
                    "${allCharacters[index].image}",
                    width: Dimensions.homePageListItemCardIconSize, 
                    height: Dimensions.homePageListItemCardIconSize
                  ),
                ),
              ],
            ),
            SizedBox(width: Dimensions.homePageListItemCardSizedBoxWidth),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${allCharacters[index].name}", style: AppTextStyle.listHomeItemTitle)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: Dimensions.homePageListItemSize,
                      width: Dimensions.homePageListItemSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.homePageListItemCardStatusDecorationBorderRadius),
                        color: allCharacters[index].status == Strings.aliveStatus
                            ? Colors.green
                            : allCharacters[index].status == Strings.deadStatus
                                ? Colors.red
                                : Colors.grey,
                      ),
                    ),
                    SizedBox(width: Dimensions.homePageListItemCardSizedBoxWidth),
                    Text("${allCharacters[index].status} - ${allCharacters[index].species}"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Strings.lastKnownLocationLabel, style: AppTextStyle.listHomeItemLabel),
                    Text("${allCharacters[index].lastLocation}", style: AppTextStyle.listHomeItemText),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Strings.firstSeenInLabel, style: AppTextStyle.listHomeItemLabel),
                    Text("${allCharacters[index].firstLocation}", style: AppTextStyle.listHomeItemText)
                  ],
                ),
              ],
            ),
          ],
        ),
      )
    );
  }

  Widget _buildDataListItemEmpty(context, index) {
    return const Card();
  }
}