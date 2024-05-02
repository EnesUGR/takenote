import 'dart:convert';

import 'package:flutter/material.dart';
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

  static Future<void> updateNote(NoteModel old, NoteModel newNote) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> notes = prefs.getStringList(_key) ?? [];

    final index =
        notes.indexWhere((nJson) => nJson == jsonEncode(old.toJson()));

    if (index != -1) notes[index] = jsonEncode(newNote.toJson());

    await prefs.setStringList(_key, notes);
  }

  static Future<List<NoteModel>> getNotes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> notes = prefs.getStringList(_key) ?? [];

    List<NoteModel> list =
        notes.map((nJson) => NoteModel.fromJson(jsonDecode(nJson))).toList();
    return list;
  }

  static Future<List<NoteModel>> searchNote(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> notes = prefs.getStringList(_key) ?? [];

    List<NoteModel> list =
        notes.map((nJson) => NoteModel.fromJson(jsonDecode(nJson))).toList();

    List<NoteModel> searchResult = list;

    if (query.isNotEmpty) {
      searchResult = list
          .where((note) =>
              note.title.toLowerCase().contains(query.toLowerCase()) ||
              note.note.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    debugPrint("Search result: $searchResult");
    return searchResult;
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
