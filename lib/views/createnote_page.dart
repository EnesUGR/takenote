import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/components/topwidget.dart';
import 'package:takenote/constants/style.dart';
import 'package:takenote/models/note_model.dart';
import 'package:takenote/services/spref_manager.dart';
import 'package:takenote/utils/extensions.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool _isCompleted = false;

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopWidget(
                  title: "Create Page",
                  leading: Icons.arrow_back_ios_new,
                  onTap: () {
                    context.back();
                  },
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _titleController,
                  onChanged: (value) {
                    setState(() {
                      if (_titleController.text.isNotEmpty &&
                          _noteController.text.isNotEmpty) {
                        _isCompleted = true;
                      } else {
                        _isCompleted = false;
                      }
                    });
                  },
                  style: TextStyle(
                    color: AppColors.heading,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.text,
                  decoration: hintDec("Title"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    DateTime.timestamp().fullDate,
                    style: TextStyle(
                      color: AppColors.body.withOpacity(.7),
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: context.height * .6,
                  child: TextField(
                    controller: _noteController,
                    onChanged: (value) {
                      setState(() {
                        if (_titleController.text.isNotEmpty &&
                            _noteController.text.isNotEmpty) {
                          _isCompleted = true;
                        } else {
                          _isCompleted = false;
                        }
                      });
                    },
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      color: AppColors.heading,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: hintDec("Write something..."),
                  ),
                ),
                AbsorbPointer(
                  absorbing: !_isCompleted,
                  child: Opacity(
                    opacity: !_isCompleted ? .5 : 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            NoteModel noteObject = NoteModel(
                              title: _titleController.text,
                              note: _noteController.text,
                              dateStamp: DateTime.timestamp().toString(),
                            );
                            NoteManagerSPref.addNote(noteObject)
                                .whenComplete(() => context.back());
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.light,
                            padding: const EdgeInsets.all(18),
                          ),
                          child: Text(
                            'Save Note',
                            style: TextStyle(
                              color: AppColors.light,
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration hintDec(String hintText) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      hintText: hintText,
      border: InputBorder.none,
      hintStyle: TextStyle(
        color: AppColors.body.withOpacity(.7),
        fontFamily: GoogleFonts.manrope().fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
