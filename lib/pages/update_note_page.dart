import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/services/note_service.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_styles.dart';

class UpdateNotePage extends StatefulWidget {
  final Note note;
  const UpdateNotePage({super.key, required this.note});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  // initialize NoteService
  final NoteService noteService = NoteService();

  List<String> categories = [];

  // get all categories
  Future<void> _getAllCategories() async {
    final loadedCategories = await noteService.getAllCategories();
    if (mounted) {
      setState(() {
        categories = loadedCategories;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getAllCategories();
    category = widget.note.category;
    // assigning values
    _noteTitleController.text = widget.note.title;
    _noteContentController.text = widget.note.content;
    // _categoryController.text = widget.note.category;
  }

  // variables form
  final _formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  // final TextEditingController _categoryController = TextEditingController();

  var category = "";

  // dispose values
  @override
  void dispose() {
    super.dispose();
    _noteTitleController.dispose();
    _noteContentController.dispose();
    // _categoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Note")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),

            Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppConstants.kDefaultPadding / 2,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // drop down
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: TextFormField(
                    //     controller: _categoryController,
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return "Please enter the category";
                    //       }
                    //       return null;
                    //     },
                    //     style: TextStyle(
                    //       color: AppColors.kWhiteColor,
                    //       fontFamily: GoogleFonts.dmSans().fontFamily,
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 16,
                    //     ),
                    //     decoration: InputDecoration(
                    //       hintText: "New Category",
                    //       hintStyle: TextStyle(
                    //         color: AppColors.kWhiteColor.withValues(alpha: 0.5),
                    //         fontFamily: GoogleFonts.dmSans().fontFamily,
                    //         fontWeight: FontWeight.w500,
                    //         fontSize: 16,
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: BorderSide(
                    //           width: 2,
                    //           color: AppColors.kWhiteColor.withValues(
                    //             alpha: 0.1,
                    //           ),
                    //         ),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //         borderSide: BorderSide(
                    //           width: 1,
                    //           color: AppColors.kWhiteColor,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField(
                        initialValue: category,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select the category";
                          }
                          return null;
                        },
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
                        onChanged: (String? value) {
                          setState(() {
                            category = value!;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: 20),

                    // title field
                    TextFormField(
                      controller: _noteTitleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter note title";
                        }
                        return null;
                      },
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
                      controller: _noteContentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter note content";
                        }
                        return null;
                      },
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
                          onPressed: () {
                            // validate the form
                            if (_formKey.currentState!.validate()) {
                              // save the note
                              try {
                                // update note
                                noteService.editNote(
                                  Note(
                                    title: _noteTitleController.text,
                                    category: category,
                                    content: _noteContentController.text,
                                    date: DateTime.now(),
                                    id: widget.note.id,
                                  ),
                                );

                                // display message
                                AppHelpers.showSnackBarMessage(
                                  context,
                                  "Note updated successfully",
                                );

                                // clear text fields
                                _noteTitleController.clear();
                                _noteContentController.clear();

                                // navigate to notes page
                                AppRouter.router.go('/notes');
                              } catch (error) {
                                AppHelpers.showSnackBarMessage(
                                  context,
                                  "Error occured while updating note",
                                );
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              AppColors.kFabColor,
                            ),
                          ),
                          child: Text("Update Note"),
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
