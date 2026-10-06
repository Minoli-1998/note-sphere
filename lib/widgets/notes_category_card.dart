import 'package:flutter/material.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/container_styles.dart';
import 'package:note_sphere/utils/text_styles.dart';

class NotesCategoryCard extends StatelessWidget {
  final String category;
  final int noOfNotes;

  const NotesCategoryCard({
    super.key,
    required this.category,
    required this.noOfNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstants.kDefaultPadding),
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: AppContainerStyles.cardStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: AppTextStyles.appSubTitle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 10),

          Text(
            "$noOfNotes Notes",
            style: AppTextStyles.appBody.copyWith(
              color: AppColors.kWhiteColor.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
