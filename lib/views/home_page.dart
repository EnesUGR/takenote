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

  void _loadNotes() async {
    var notes = await NoteManagerSPref.getNotes();
    setState(
      () {
        debugPrint("_loadNotes");
        _notes = notes;
        _pinnedNotes = notes.where((element) => element.pinned).toList();
      },
    );
    for (var e in _notes) {
      debugPrint("${e.title}:${e.pinned}");
    }
  }

  /// Pin or update note. If [isUpdate] is false, only change pinned state.
  void _pinOrUpdate(bool isUpdate, NoteModel oldNote) {
    if (isUpdate) {
    } else {
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
          context.goPage(const CreateNotePage(), onValue: (_) {
            _loadNotes();
          });
        },
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.light,
        child: const Icon(Icons.note_add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          child: SizedBox(
            height: context.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopWidget(
                    title: "All Notes", iconRight: Icons.arrow_drop_down),
                const SizedBox(height: 20),
                SearchBox(searchController: _searchController),
                const SizedBox(height: 20),
                Text(
                  "Pinned",
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
                      itemCount: _pinnedNotes.length,
                      itemBuilder: (context, index) {
                        return PinnedNoteWidget(
                            removePinned: (_) {
                              _pinOrUpdate(false, _pinnedNotes[index]);
                            },
                            noteModel: _pinnedNotes[index]);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Others (${_notes.length})",
                  style: TextStyle(
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.body,
                  ),
                ),
                const SizedBox(height: 10),
                allNotesWidgets(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded allNotesWidgets(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: context.width,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            return NoteWidget(
              note: _notes[index],
              onRemove: (_) {
                NoteManagerSPref.removeNote(_notes[index]);
                _loadNotes();
              },
              onPinned: (_) {
                _pinOrUpdate(false, _notes[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
