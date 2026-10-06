import 'package:flutter/material.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/container_styles.dart';
import 'package:note_sphere/utils/text_styles.dart';

class SingleCategoryNoteCard extends StatefulWidget {
  final String noteTitle;
  final String noteContent;
  final Future Function() removeNote;
  final Future Function() editNote;

  const SingleCategoryNoteCard({
    super.key,
    required this.noteTitle,
    required this.noteContent,
    required this.removeNote,
    required this.editNote,
  });

  @override
  State<SingleCategoryNoteCard> createState() => _SingleCategoryNoteCardState();
}

class _SingleCategoryNoteCardState extends State<SingleCategoryNoteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: AppContainerStyles.cardStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: widget.editNote,
                icon: Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: AppColors.kWhiteColor.withValues(alpha: 0.5),
                ),
              ),

              SizedBox(width: 20),

              IconButton(
                onPressed: widget.removeNote,
                icon: Icon(
                  Icons.delete_outlined,
                  size: 20,
                  color: AppColors.kWhiteColor.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Text(
            widget.noteTitle,
            style: AppTextStyles.appSubTitle,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            maxLines: 1,
          ),

          SizedBox(height: 15),

          Text(
            widget.noteContent,
            style: AppTextStyles.appDescriptionSmallStyle.copyWith(
              color: AppColors.kWhiteColor.withValues(alpha: 0.5),
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            maxLines: 6,
          ),
        ],
      ),
    );
  }
}
