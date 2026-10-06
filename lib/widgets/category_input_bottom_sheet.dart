import 'package:flutter/material.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/container_styles.dart';
import 'package:note_sphere/utils/text_styles.dart';

class CategoryInputBottomSheet extends StatefulWidget {
  final Function() onNewNote;
  final Function() onNewCategory;

  const CategoryInputBottomSheet({
    super.key,
    required this.onNewNote,
    required this.onNewCategory,
  });

  @override
  State<CategoryInputBottomSheet> createState() =>
      _CategoryInputBottomSheetState();
}

class _CategoryInputBottomSheetState extends State<CategoryInputBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      padding: EdgeInsets.all(AppConstants.kDefaultPadding * 1.5),
      decoration: AppContainerStyles.cardStyle.copyWith(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.onNewNote,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Create a New Note",
                  style: AppTextStyles.appDescriptionSmallStyle,
                ),
                Icon(
                  Icons.arrow_right_outlined,
                  color: AppColors.kWhiteColor,
                  size: 20,
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          Divider(
            color: AppColors.kWhiteColor.withValues(alpha: 0.5),
            thickness: 2,
          ),

          SizedBox(height: 20),

          GestureDetector(
            onTap: widget.onNewCategory,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Create New Note Category",
                  style: AppTextStyles.appDescriptionSmallStyle,
                ),
                Icon(
                  Icons.arrow_right_outlined,
                  color: AppColors.kWhiteColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
