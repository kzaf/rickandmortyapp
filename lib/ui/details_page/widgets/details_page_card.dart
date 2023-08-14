import 'package:flutter/material.dart';

import '../../../constants/dimensions.dart';
import '../../../constants/strings.dart';
import '../../../constants/styles.dart';

class DetailsPageCard extends StatelessWidget {
  const DetailsPageCard({
    super.key,
    required this.context,
    required this.title,
    required this.text,
    required this.image,
  });

  final BuildContext context;
  final String title;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      child: Card(
        elevation: Dimensions.detailsPageCardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Dimensions.detailsPageCardRadius,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            Dimensions.detailsPageCardPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListTile(
                  leading: Image.asset(
                    image,
                  ),
                  title: Text(
                    title,
                    style: AppTextStyle.titleStyle,
                  ),
                  subtitle: Text(
                    text.toString().capitalize(),
                    style: AppTextStyle.textStyle,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
