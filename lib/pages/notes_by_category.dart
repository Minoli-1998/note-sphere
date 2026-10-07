import 'package:flutter/material.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/services/note_service.dart';
import 'package:note_sphere/utils/constants.dart';
import 'package:note_sphere/utils/router.dart';
import 'package:note_sphere/utils/text_styles.dart';
import 'package:note_sphere/widgets/single_category_note_card.dart';

class NotesByCategory extends StatefulWidget {
  final String category;

  const NotesByCategory({super.key, required this.category});

  @override
  State<NotesByCategory> createState() => _NotesByCategoryState();
}

class _NotesByCategoryState extends State<NotesByCategory> {
  // initialize a variable for NoteService
  final NoteService noteService = NoteService();

  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotesByCategory();
  }

  Future<void> _loadNotesByCategory() async {
    notes = await noteService.getNotesByCategoryName(widget.category);
    setState(() {});
  }

  void _editNote(Note note) {
    AppRouter.router.push('/edit-note', extra: note);
  }

  Future<void> _removeNote(String id) async {
    try {
      await noteService.deleteNote(id);

      if (context.mounted) {
        AppHelpers.showSnackBarMessage(context, "Note deleted successfully");
      }
    } catch (error) {
      if (context.mounted) {
        AppHelpers.showSnackBarMessage(context, "Failed to delete note");
      }
    }
  }

  void _viewSinglePage(Note note) {
    AppRouter.router.push('/single-note', extra: note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            // go back to notes page
            AppRouter.router.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: AppConstants.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.category,
                style: AppTextStyles.appTitle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 15),

              GridView.builder(
                itemCount: notes.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstants.kDefaultPadding,
                  mainAxisSpacing: AppConstants.kDefaultPadding,
                  childAspectRatio: 7 / 11,
                ),
                itemBuilder: (context, index) {
                  Note note = notes[index];
                  return SingleCategoryNoteCard(
                    noteTitle: note.title,
                    noteContent: note.content,
                    removeNote: () async {
                      await _removeNote(note.id);

                      setState(() {
                        notes.removeAt(index);
                      });
                    },
                    editNote: () async => _editNote(note),
                    viewSingleNote: () => _viewSinglePage(note),
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
