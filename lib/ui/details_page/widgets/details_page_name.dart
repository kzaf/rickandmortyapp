import 'package:flutter/material.dart';

import '../../../constants/dimensions.dart';
import '../../../constants/styles.dart';

class DetailsPageName extends StatelessWidget {
  const DetailsPageName({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(
        Dimensions.detailsPageTitlePadding,
      ),
      sliver: SliverAppBar(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimensions.detailsPageTitleBorderRadius,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        pinned: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            Dimensions.detailsPageTitleBottomHeight,
          ),
          child: const SizedBox(),
        ),
        flexibleSpace: Center(
          child: Text(
            name,
            style: AppTextStyle.headlineDetails,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
