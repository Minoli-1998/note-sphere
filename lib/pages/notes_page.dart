import 'package:flutter/material.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/services/note_service.dart';
import 'package:note_sphere/utils/colors.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_styles.dart';
import 'package:note_sphere/widgets/category_input_bottom_sheet.dart';
import 'package:note_sphere/widgets/notes_category_card.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // NoteService variable
  final NoteService noteService = NoteService();
  List<Note> allNotes = [];
  Map<String, List<Note>> notesWithCategory = {};

  @override
  void initState() {
    super.initState();
    _checkAndCreateData();
  }

  // method to check if user new
  void _checkAndCreateData() async {
    bool isNewUser = await noteService.isNewUser();

    // if the user is new create initial notes
    if (isNewUser) {
      await noteService.createdInitialNotes();
    }

    // load the notes
    loadNotes();
  }

  // open bottom sheet
  void openBottomSheet() {
    showModalBottomSheet(
      barrierColor: Colors.black.withValues(alpha: 0.7),
      context: context,
      builder: (context) {
        return CategoryInputBottomSheet(
          onNewNote: () {
            // close the bottom sheet after clicking
            Navigator.pop(context);
            AppRouter.router.push('/create-note', extra: false);
          },
          onNewCategory: () {
            // close the bottom sheet after clicking
            Navigator.pop(context);
            AppRouter.router.push("/create-note", extra: true);
          },
        );
      },
    );
  }

  Future<void> loadNotes() async {
    final List<Note> loadedNotes = await noteService.loadNotes();
    final Map<String, List<Note>> notesByCategory = noteService
        .getNotesByCategory(loadedNotes);
    setState(() {
      allNotes = loadedNotes;
      notesWithCategory = notesByCategory;
    });
  }

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
        onPressed: openBottomSheet,
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

              allNotes.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: Text(
                          "No notes are available, please click the + button to add a new note",
                          style: AppTextStyles.appDescriptionSmallStyle,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: notesWithCategory.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppConstants.kDefaultPadding,
                        mainAxisSpacing: AppConstants.kDefaultPadding,
                        childAspectRatio: 6 / 4,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // go to notes by category page
                            AppRouter.router.push(
                              '/category',
                              extra: notesWithCategory.keys.elementAt(index),
                            );
                          },
                          child: NotesCategoryCard(
                            category: notesWithCategory.keys.elementAt(index),
                            noOfNotes: notesWithCategory.values
                                .elementAt(index)
                                .length,
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
