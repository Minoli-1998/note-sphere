import 'package:flutter/material.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/container_styles.dart';
import 'package:note_sphere/utils/text_styles.dart';

class NotesTodoCard extends StatefulWidget {
  final int value;
  final bool isNote;

  const NotesTodoCard({super.key, required this.value, required this.isNote});

  @override
  State<NotesTodoCard> createState() => _NotesTodoCardState();
}

class _NotesTodoCardState extends State<NotesTodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: AppContainerStyles.cardStyle,
      padding: EdgeInsets.all(AppConstants.kDefaultPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.isNote
                  ? Icons.bookmark_add_outlined
                  : Icons.today_outlined,
              size: 40,
              color: AppColors.kWhiteColor,
            ),

            SizedBox(height: 10),

            Text(
              widget.isNote ? "Note" : "To-Do List",
              style: AppTextStyles.appSubTitle,
            ),

            SizedBox(height: 5),

            Text(
              widget.isNote ? "${widget.value} Notes" : "${widget.value} Tasks",

              style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                color: AppColors.kWhiteColor.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
