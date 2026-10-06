import 'package:hive/hive.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:uuid/uuid.dart';

class NoteService {
  // all notes
  List<Note> allNotes = [
    Note(
      id: const Uuid().v4(),
      title: "Meeting Notes",
      category: "Work",
      content: "Discussed project deadlines and deliverables. Assigned tasks to team members and set up follow-up meetings to track progress.",
      date: DateTime.now(),
    ),
    Note(
      id: const Uuid().v4(),
      title: "Grocery List",
      category: "Personal",
      content: "Bought milk, eggs, bread, fruits, and vegetables from the local grocery store. Also added some snacks for the week.",
      date: DateTime.now(),
    ),
    Note(
      id: const Uuid().v4(),
      title: "Book Recommendations",
      category: "Hobby",
      content: "Recently read 'Sapiens' by Yuval Noah Harari, which offered fascinating insights into the history of humankind. Also enjoyed 'Atomic Habits' by James Clear, a practical guide to building good habits and breaking bad ones.",
      date: DateTime.now(),
    ),
  ];

  // create the db reference for notes
  final _myBox = Hive.box('notes');

  // check whether the user is a new user
  // if there is nothing save in Hive box then the user is a new users
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  // method to save initial notes if the user is new
  Future<void> createdInitialNotes() async {
    if (_myBox.isEmpty) {
      _myBox.put("notes", allNotes);
    }
  }

  // method to load notes
  Future<List<Note>> loadNotes() async {
    // get the notes in box
    final dynamic notes = _myBox.get("notes");

    // check whether the notes are empty and a list of note
    // the type of notes is dynamic converting notes type dynamic to Note using cast
    if (notes != null && notes is List<Note>) {
      return notes.cast<Note>().toList();
    }

    return [];
  }

  // loop through all notes and create an object where the key is the category and the value is the notes in that category
  Map<String, List<Note>> getNotesByCategory(List<Note> allNotes) {
    final Map<String, List<Note>> notesByCategory = {};

    for (final note in allNotes) {
      // if category contains add note to the map under the key
      // else create the new category with a list containing that note
      if (notesByCategory.containsKey(note.category)) {
        notesByCategory[note.category]!.add(note);
      } else {
        notesByCategory[note.category] = [note];
      }
    }

    return notesByCategory;
  }

  // method to get the notes according to the category
  Future<List<Note>> getNotesByCategoryName(String category) async {
    final dynamic allNotes = await _myBox.get("notes");

    final List<Note> notesByCategory = [];

    for (final note in allNotes) {
      if (note.category == category) {
        notesByCategory.add(note);
      }
    }

    return notesByCategory;
  }
}
