import 'package:flutter/material.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/container_styles.dart';
import 'package:note_sphere/utils/text_styles.dart';

class ProgressCard extends StatefulWidget {
  final int numberOfCompletedTasks;
  final int numberOfTotalTasks;

  const ProgressCard({
    super.key,
    required this.numberOfCompletedTasks,
    required this.numberOfTotalTasks,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    // caclculation for the completion percentage
    // this variable have to rebuild every time the card called. so create inside the build widget
    double completionPercentage = widget.numberOfTotalTasks != 0
        ? (widget.numberOfCompletedTasks / widget.numberOfTotalTasks) * 100
        : 0;

    return Container(
      decoration: AppContainerStyles.cardStyle,
      padding: EdgeInsets.all(AppConstants.kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Today's Progress", style: AppTextStyles.appSubTitle),

                SizedBox(height: 20),

                Text(
                  "You have completed ${widget.numberOfCompletedTasks} out of ${widget.numberOfTotalTasks} tasks, keep up the progress!",
                  style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                    color: AppColors.kWhiteColor.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: AppColors().kPrimaryGradient,
              shape: BoxShape.circle,
            ),
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            child: Center(
              child: Text(
                "${completionPercentage.toInt()}%",
                style: AppTextStyles.appSubTitle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
