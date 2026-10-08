import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_sphere/models/task_model.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/container_styles.dart';
import 'package:note_sphere/utils/text_styles.dart';

class HomePageTaskCard extends StatelessWidget {
  final Task task;
  const HomePageTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    String date = DateFormat("MMMM dd,yyyy").format(task.date);
    String time = DateFormat("hh:mm").format(task.time);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: AppContainerStyles.cardStyle,
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title, style: AppTextStyles.appDescriptionLargeStyle),

              SizedBox(height: 10),

              Text(
                "$date $time",
                style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                  color: AppColors.kWhiteColor.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),

          task.isDone
              ? Icon(Icons.done_all, color: Colors.green, size: 20)
              : Icon(Icons.done, color: Colors.red, size: 20),
        ],
      ),
    );
  }
}
