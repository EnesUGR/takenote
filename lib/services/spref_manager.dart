import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:takenote/models/note_model.dart';

class NoteManagerSPref {
  static const String _key = "takenotes_notes";

  static Future<void> addNote(NoteModel note) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> notes = prefs.getStringList(_key) ?? [];

    notes.add(jsonEncode(note.toJson()));

    await prefs.setStringList(_key, notes);
  }

  static Future<List<NoteModel>> getNotes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> notes = prefs.getStringList(_key) ?? [];

    List<NoteModel> list =
        notes.map((nJson) => NoteModel.fromJson(jsonDecode(nJson))).toList();
    return list;
  }

  static Future<void> removeNote(NoteModel note) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> notes = prefs.getStringList(_key) ?? [];

    notes.removeWhere((nJson) => nJson == jsonEncode(note.toJson()));

    await prefs.setStringList(_key, notes);
  }

  static Future<void> deleteAllNotes({bool permission = false}) async {
    if (permission) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    }
  }
}
