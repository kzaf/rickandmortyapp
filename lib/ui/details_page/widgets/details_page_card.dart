import 'package:flutter/material.dart';

import '../../../constants/dimensions.dart';
import '../../../constants/strings.dart';
import '../../../constants/styles.dart';

class DetailsPageCard extends StatelessWidget {
  const DetailsPageCard({
    super.key,
    required this.title,
    required this.text,
    required this.image,
  });

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
                    style: AppTextStyle.textStyle.copyWith(
                      color: _getColorForSubtitle(text),
                    ),
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

  Color _getColorForSubtitle(String subtitle) {
    if (subtitle.toLowerCase() == Strings.aliveStatus.toLowerCase()) {
      return Colors.green;
    } else if (subtitle.toLowerCase() == Strings.deadStatus.toLowerCase()) {
      return Colors.red;
    } else if (subtitle.toLowerCase() == Strings.femaleStatus.toLowerCase()) {
      return Colors.pink.shade200;
    } else if (subtitle.toLowerCase() == Strings.maleStatus.toLowerCase()) {
      return Colors.blue.shade200;
    } else {
      return AppTextStyle.textStyle.color ?? Colors.grey;
    }
  }
}
