import 'package:flutter/material.dart';

import '../../../constants/dimensions.dart';
import '../../../constants/strings.dart';
import '../../../constants/styles.dart';

class DetailsPageExpansionTile extends StatelessWidget {
  const DetailsPageExpansionTile({
    super.key,
    required this.context,
    required this.episodesList,
  });

  final BuildContext context;
  final List<String> episodesList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      child: Card(
        elevation: Dimensions.detailsPageExpansionTileElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Dimensions.detailsPageCardRadius,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            Dimensions.detailsPageExpansionTilePadding,
          ),
          child: ExpansionTile(
            leading: Image.asset(
              'icons/episodes.png',
            ),
            shape: const Border(),
            title: Text(
              Strings.detailsPageLabelEpisodes,
              style: AppTextStyle.titleStyle,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            children: episodesList.map<Widget>((item) {
              return ListTile(
                title: Expanded(
                  child: Text(
                    item,
                    style: AppTextStyle.textStyle,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
