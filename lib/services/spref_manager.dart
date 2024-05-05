import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takenote/models/note_model.dart';
import 'package:takenote/utils/extensions.dart';

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
    list = _fakeNotes();
    return list;
  }

  /// This method is used to generate fake notes for testing purposes.
  static List<NoteModel> _fakeNotes() {
    final List<NoteModel> notes = [
      NoteModel(
        title: "Alışveriş Listesi",
        note:
            "Market için alınacaklar listesi: Süt, yumurta, ekmek, peynir, domates, biber, patates, salatalık, kırmızı et, tavuk göğsü, pirinç, makarna, zeytinyağı, bulaşık deterjanı, tuvalet kağıdı.",
        dateStamp: DateTime.now().toString(),
      ),
      NoteModel(
        title: "Randevu Hatırlatması",
        note:
            "Hatırlatma: Yarın 10:00'da diş doktoru randevunuz var. Lütfen randevuya on dakika önce geliniz. İptal etmek isterseniz en az 24 saat önceden haber veriniz.",
        dateStamp: DateTime.now().toString(),
        pinned: true,
      ),
      NoteModel(
        title: "Teşekkür Notu",
        note:
            "Merhaba, harika yardımınız için teşekkür ederim. Bugün benim için çok önemliydi ve senin desteğinle daha da anlamlı hale geldi. İyiki varsın!",
        dateStamp: DateTime.now().toString(),
      ),
      NoteModel(
        title: "Doğum Günü Mesajı",
        note:
            "Doğum günün kutlu olsun! Yeni yaşında sana mutluluk, sağlık, başarılar ve bolca güzellik getirmesini dilerim. Nice yıllara!",
        dateStamp: DateTime.now().toString(),
      ),
      NoteModel(
        title: "Eğitim Programı",
        note:
            "Bu haftanın eğitim programı: Pazartesi - Matematik, Salı - Fen Bilgisi, Çarşamba - Türkçe, Perşembe - Beden Eğitimi, Cuma - Müzik.",
        dateStamp: DateTime.now().toString(),
        pinned: true,
      ),
      NoteModel(
        title: "Yemek Tarifi",
        note:
            "Makarna sosu için gereken malzemeler: 4 adet domates, 1 adet soğan, 2 diş sarımsak, 3 yemek kaşığı zeytinyağı, tuz, karabiber, kurutulmuş fesleğen yaprağı. Detaylı tarif için aşağıdaki linki ziyaret edebilirsiniz.",
        dateStamp: DateTime.now().toString(),
      ),
      NoteModel(
        title: "Seyahat Planı",
        note:
            "İki hafta sürecek olan seyahat planımız şu şekildedir: Gidiş 10 Mayıs, Dönüş 24 Mayıs. Seyahat boyunca İstanbul, Antalya ve Kapadokya'yı ziyaret edeceğiz. Otel rezervasyonları yapılmıştır, detaylar mailde.",
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
