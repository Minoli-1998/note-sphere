import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_sphere/models/task_model.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/container_styles.dart';
import 'package:note_sphere/utils/text_styles.dart';

class TaskCard extends StatefulWidget {
  final bool isCompleted;
  final Task incompletedTask;

  const TaskCard({
    super.key,
    required this.isCompleted,
    required this.incompletedTask,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final String date = DateFormat("MM/dd/yyyy")
        .format(widget.incompletedTask.date);
    final String time = DateFormat('h.mm').format(widget.incompletedTask.time);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: AppContainerStyles.cardStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.incompletedTask.title,
                style: AppTextStyles.appDescriptionLargeStyle,
              ),

              SizedBox(height: 5),

              Text(
                "$date $time",
                style: AppTextStyles.appDescriptionSmallStyle.copyWith(
                  color: AppColors.kWhiteColor.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),

          Checkbox(value: widget.isCompleted, onChanged: (value) {}),
        ],
      ),
    );
  }
}
