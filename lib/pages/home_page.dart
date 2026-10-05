import 'package:flutter/material.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/text_styles.dart';
import 'package:note_sphere/widgets/notes_todo_card.dart';
import 'package:note_sphere/widgets/progress_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NoteSphere", style: AppTextStyles.appTitle)),

      body: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Column(
          children: [
            SizedBox(height: AppConstants.kDefaultPadding),

            ProgressCard(numberOfCompletedTasks: 1, numberOfTotalTasks: 3),

            SizedBox(height: AppConstants.kDefaultPadding),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NotesTodoCard(value: 3, isNote: true),
                NotesTodoCard(value: 3, isNote: false),
              ],
            ),

            SizedBox(height: AppConstants.kDefaultPadding),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Progress", style: AppTextStyles.appSubTitle),

                Text("See All", style: AppTextStyles.appButton),
              ],
            ),

            SizedBox(height: AppConstants.kDefaultPadding),

            // To-Do list
          ],
        ),
      ),
    );
  }
}
