import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/components/note_widget.dart';
import 'package:takenote/components/pinned_note.dart';
import 'package:takenote/components/searchbox.dart';
import 'package:takenote/components/topwidget.dart';
import 'package:takenote/constants/style.dart';
import 'package:takenote/models/note_model.dart';
import 'package:takenote/services/spref_manager.dart';
import 'package:takenote/utils/extensions.dart';
import 'package:takenote/views/createnote_page.dart';
import 'package:takenote/views/settings_page.dart';
import 'package:takenote/views/update_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<NoteModel> _notes = [];
  List<NoteModel> _pinnedNotes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes({bool isSearch = false}) async {
    List<NoteModel> notes;
    if (isSearch) {
      notes = await NoteManagerSPref.searchNote(_searchController.text);
    } else {
      notes = await NoteManagerSPref.getNotes();
    }
    setState(
      () {
        _notes = notes;
        _pinnedNotes = notes.where((element) => element.pinned).toList();
      },
    );
    for (var e in _notes) {
      debugPrint("_loadNotes ==> ${e.title}:${e.pinned}");
    }
  }

  /// Pin or update note. If [isUpdate] is false, only change pinned state.
  void _pinOrUpdate(bool isUpdate, NoteModel oldNote) {
    if (!isUpdate) {
      NoteModel newNote = NoteModel(
        title: oldNote.title,
        note: oldNote.note,
        dateStamp: oldNote.dateStamp,
        pinned: !oldNote.pinned,
      );
      NoteManagerSPref.updateNote(oldNote, newNote);
    }

    _loadNotes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goPage(const CreateNotePage(), onAfter: (_) {
            _loadNotes();
          });
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.light,
        child: const Icon(Icons.note_add),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(milliseconds: 100), () {
            _loadNotes();
            _searchController.clear();
          });
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: SizedBox(
              height: context.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopWidget(
                    title: context.l10n.allNotes,
                    trailing: Icons.settings,
                    trailingOnPressed: () {
                      context.goPage(const SettingsPage(), onAfter: (_) {
                        _loadNotes();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  SearchBox(
                    cntrl: _searchController,
                    onSubmitted: (query) => _loadNotes(isSearch: true),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    context.l10n.pinned,
                    style: TextStyle(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.body,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Visibility(
                    visible: _pinnedNotes.isNotEmpty,
                    child: SizedBox(
                      height: 160,
                      width: context.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: _pinnedNotes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.goPage(UpdatePage(note: _notes[index]),
                                  onAfter: (_) {
                                _loadNotes();
                              });
                            },
                            child: PinnedNoteWidget(
                                removePinned: (_) {
                                  _pinOrUpdate(false, _pinnedNotes[index]);
                                },
                                noteModel: _pinnedNotes[index]),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    context.l10n.others(_notes.length),
                    style: TextStyle(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.body,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SizedBox(
                      width: context.width,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _notes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.goPage(UpdatePage(note: _notes[index]),
                                  onAfter: (_) {
                                _loadNotes();
                              });
                            },
                            child: NoteWidget(
                              note: _notes[index],
                              onRemove: (_) {
                                NoteManagerSPref.removeNote(_notes[index]);
                                _loadNotes();
                              },
                              onPinned: (_) {
                                _pinOrUpdate(false, _notes[index]);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
