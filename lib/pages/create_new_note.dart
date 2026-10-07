import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sphere/services/note_service.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/text_styles.dart';

class CreateNewNote extends StatefulWidget {
  final bool isNewCategory;
  const CreateNewNote({super.key, required this.isNewCategory});

  @override
  State<CreateNewNote> createState() => _CreateNewNoteState();
}

class _CreateNewNoteState extends State<CreateNewNote> {
  // initialize NoteService
  final NoteService noteService = NoteService();

  List<String> categories = [];

  String category = "Category";

  // get all categories
  Future<List<String>> _getAllCategories() async {
    categories = await noteService.getAllCategories();
    return categories;
  }

  @override
  void initState() {
    super.initState();
    _getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Note")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),

            Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppConstants.kDefaultPadding / 2,
              ),
              child: Form(
                child: Column(
                  children: [
                    // drop down
                    widget.isNewCategory
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                color: AppColors.kWhiteColor,
                                fontFamily: GoogleFonts.dmSans().fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                hintText: "New Category",
                                hintStyle: TextStyle(
                                  color: AppColors.kWhiteColor.withValues(
                                    alpha: 0.5,
                                  ),
                                  fontFamily: GoogleFonts.dmSans().fontFamily,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: AppColors.kWhiteColor.withValues(
                                      alpha: 0.1,
                                    ),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: AppColors.kWhiteColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonFormField(
                              style: TextStyle(
                                color: AppColors.kWhiteColor,
                                fontFamily: GoogleFonts.dmSans().fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: AppColors.kWhiteColor.withValues(
                                      alpha: 0.1,
                                    ),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: AppColors.kWhiteColor,
                                  ),
                                ),
                              ),
                              hint: Text("Category"),
                              items: categories.map((String category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(
                                    category,
                                    style: AppTextStyles.appButton,
                                  ),
                                );
                              }).toList(),
                              alignment: AlignmentGeometry.centerLeft,
                              onChanged: (value) {
                                setState(() {
                                  category = value as String;
                                });
                              },
                            ),
                          ),

                    SizedBox(height: 20),

                    // title field
                    TextFormField(
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.kWhiteColor.withValues(alpha: 0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withValues(alpha: 0.5),
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                        border: InputBorder.none,
                      ),
                    ),

                    SizedBox(height: 20),

                    // content field
                    TextFormField(
                      maxLines: 12,
                      style: TextStyle(
                        color: AppColors.kWhiteColor.withValues(alpha: 0.5),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Content",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withValues(alpha: 0.5),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),

                    Divider(
                      color: AppColors.kWhiteColor.withValues(alpha: 0.5),
                      thickness: 2,
                    ),

                    SizedBox(height: 10),

                    // submit button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              AppColors.kFabColor,
                            ),
                          ),
                          child: Text("Save Note"),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
