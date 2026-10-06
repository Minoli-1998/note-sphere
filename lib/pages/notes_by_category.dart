import 'package:flutter/material.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/services/note_service.dart';
import 'package:note_sphere/utils/text_styles.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category, style: AppTextStyles.appTitle),
      ),
    );
  }
}
