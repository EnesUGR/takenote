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
    // list = _fakeNotes(); // For testing purposes
    return list;
  }

  /// This method is used to generate fake notes for testing purposes.
  static List<NoteModel> _fakeNotes() {
    final List<NoteModel> notes = [
      NoteModel(
        title: "Shopping List",
        note:
            "Grocery shopping list: Milk, eggs, bread, cheese, tomatoes, peppers, potatoes, cucumber, red meat, chicken breast, rice, pasta, olive oil, dish detergent, toilet paper.",
        dateStamp: DateTime.now().toString(),
      ),
      NoteModel(
        title: "Appointment Reminder",
        note:
            "Reminder: You have a dentist appointment tomorrow at 10:00. Please arrive ten minutes early. If you need to cancel, please notify us at least 24 hours in advance.",
        dateStamp: DateTime.now().toString(),
        pinned: true,
      ),
      NoteModel(
        title: "Thank You Note",
        note:
            "Hello, thank you for your wonderful help. Today was very important to me, and with your support, it became even more meaningful. I'm glad you're here!",
        dateStamp: DateTime.now().toString(),
      ),
      NoteModel(
        title: "Birthday Message",
        note:
            "Happy birthday! Wishing you happiness, health, success, and plenty of beauty in your new year. Cheers to many more!",
        dateStamp: DateTime.now().toString(),
      ),
      NoteModel(
        title: "Educational Program",
        note:
            "This week's educational program: Monday - Mathematics, Tuesday - Science, Wednesday - Turkish, Thursday - Physical Education, Friday - Music.",
        dateStamp: DateTime.now().toString(),
        pinned: true,
      ),
      NoteModel(
        title: "Recipe",
        note:
            "Ingredients for pasta sauce: 4 tomatoes, 1 onion, 2 cloves of garlic, 3 tablespoons of olive oil, salt, pepper, dried basil leaves. For a detailed recipe, visit the link below.",
        dateStamp: DateTime.now().toString(),
      ),
      NoteModel(
        title: "Travel Plan",
        note:
            "Our two-week travel plan is as follows: Departure on May 10th, Return on May 24th. During the trip, we will visit Istanbul, Antalya, and Cappadocia. Hotel reservations have been made; details are in the email.",
        dateStamp: DateTime.now().toString(),
      ),
    ];
    return notes;
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
