import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/components/topwidget.dart';
import 'package:takenote/constants/style.dart';
import 'package:takenote/models/note_model.dart';
import 'package:takenote/services/spref_manager.dart';
import 'package:takenote/utils/extensions.dart';

class UpdatePage extends StatefulWidget {
  final NoteModel note;
  const UpdatePage({
    super.key,
    required this.note,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.note.title;
    _noteController.text = widget.note.note;
    super.initState();
  }

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
                  title: context.l10n.update,
                  leading: Icons.arrow_back_ios_new,
                  onTap: () {
                    context.back();
                  },
                  trailing: Icons.delete,
                  trailingOnPressed: () {
                    NoteManagerSPref.removeNote(widget.note).whenComplete(() {
                      context.back();
                    });
                  },
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _titleController,
                  style: TextStyle(
                    color: AppColors.heading,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  keyboardType: TextInputType.text,
                  decoration: hintDec(context.l10n.title),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    widget.note.dateStamp.fullDate,
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
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      color: AppColors.heading,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: hintDec(context.l10n.writeSomething),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        NoteModel noteObject = NoteModel(
                          title: _titleController.text,
                          note: _noteController.text,
                          dateStamp: widget.note.dateStamp,
                          pinned: widget.note.pinned,
                        );
                        NoteManagerSPref.updateNote(widget.note, noteObject)
                            .whenComplete(() => context.back());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.light,
                        padding: const EdgeInsets.all(18),
                      ),
                      child: Text(
                        context.l10n.save,
                        style: TextStyle(
                          color: AppColors.light,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
