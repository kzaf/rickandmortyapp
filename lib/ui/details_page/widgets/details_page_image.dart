import 'package:flutter/material.dart';

import '../../../constants/dimensions.dart';

class DetailsPageImage extends StatelessWidget {
  const DetailsPageImage({
    super.key,
    required this.context,
    required this.image,
  });

  final BuildContext context;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      pinned: true,
      centerTitle: false,
      expandedHeight: Dimensions.detailsPageImageExpandedHeight,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}