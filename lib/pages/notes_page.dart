import 'package:flutter/material.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_styles.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            // navigate to home page
            AppRouter.router.go("/");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(
          side: BorderSide(width: 1, color: AppColors.kWhiteColor),
        ),
        child: Icon(Icons.add, color: AppColors.kWhiteColor, size: 30),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notes",
                style: AppTextStyles.appTitle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
