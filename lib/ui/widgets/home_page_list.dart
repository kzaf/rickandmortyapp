import 'package:flutter/material.dart';
import 'package:rickandmortyapp/constants/dimensions.dart';
import 'package:rickandmortyapp/ui/ui_model/home_list_item.dart';
import 'package:rickandmortyapp/ui/pages/details_page.dart';

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
      physics: const BouncingScrollPhysics(),
      key: const PageStorageKey(0),
      controller: scrollController,
      itemCount: allCharacters.length + 1,
      itemBuilder: (context, index) {
        if (nextPageUrl != null) {
          if (index >= allCharacters.length) {
            return Padding(
                padding: EdgeInsets.all(Dimensions.homePageListItemLoaderPadding),
                child: const Center(child: CircularProgressIndicator()),
              );
          } else {
            return _buildListItem(context, index);
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Card _buildListItem(context, index) {
    return Card(
      margin: EdgeInsets.only(
        left: Dimensions.homePageListItemCardMargin,
        right: Dimensions.homePageListItemCardMargin,
        top: Dimensions.homePageListItemCardMargin
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.homePageListItemCardRadius),
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
            _listItemImage(index),
            SizedBox(width: Dimensions.homePageListItemSizedBoxHeight),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _listItemNameAndStatus(index),
                SizedBox(height: Dimensions.homePageListItemSizedBoxHeight),

                _listItemLastLocation(index),
                SizedBox(height: Dimensions.homePageListItemSizedBoxHeight),

                _listItemFirstSeen(index),
                SizedBox(height: Dimensions.homePageListItemSizedBoxHeight),
              ],
            ),
          ],
        ),
      )
    );
  }

  Column _listItemImage(index) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.homePageListItemCardIconRadius), 
            bottomLeft: Radius.circular(Dimensions.homePageListItemCardIconRadius)
          ),
          child: Image.network(
            allCharacters[index].image,
            width: Dimensions.homePageListItemCardIconSize, 
            height: Dimensions.homePageListItemCardIconSize
          ),
        ),
      ],
    );
  }

  Column _listItemNameAndStatus(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(allCharacters[index].name, style: AppTextStyle.listHomeItemTitle),
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
            SizedBox(width: Dimensions.homePageListItemSizedBoxWidth),
            Text("${allCharacters[index].status.capitalize()} - ${allCharacters[index].species}", style: AppTextStyle.listHomeItemText),
          ],
        ),
      ],
    );
  }

  Column _listItemLastLocation(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.lastKnownLocationLabel, style: AppTextStyle.listHomeItemLabel),
        Text(allCharacters[index].lastLocation, style: AppTextStyle.listHomeItemText),
      ],
    );
  }

  Column _listItemFirstSeen(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.firstSeenInLabel, style: AppTextStyle.listHomeItemLabel),
        Text(allCharacters[index].firstLocation, style: AppTextStyle.listHomeItemText)
      ],
    );
  }

}