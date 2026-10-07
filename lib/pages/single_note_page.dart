import 'package:flutter/material.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/utils/text_styles.dart';

class SingleNotePage extends StatefulWidget {
  final Note note;
  const SingleNotePage({super.key, required this.note});

  @override
  State<SingleNotePage> createState() => _SingleNotePageState();
}

class _SingleNotePageState extends State<SingleNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.note.title, style: AppTextStyles.appTitle),

            SizedBox(height: 20),

            Text(
              widget.note.content,
              style: AppTextStyles.appDescriptionSmallStyle,
            ),
          ],
        ),
      ),
    );
  }
}
