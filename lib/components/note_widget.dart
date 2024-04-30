import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/constants/style.dart';
import 'package:takenote/models/note_model.dart';
import 'package:takenote/utils/extensions.dart';

class NoteWidget extends StatelessWidget {
  final NoteModel note;
  const NoteWidget({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO: image version
      height: 140,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.body.withOpacity(.15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            note.title,
            style: TextStyle(
              fontFamily: GoogleFonts.manrope().fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          Text(
            note.dateStamp.fullDate,
            style: TextStyle(
              fontFamily: GoogleFonts.manrope().fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: AppColors.body,
            ),
          ),
          SizedBox(
            height: 60,
            child: Text(
              note.note,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontFamily: GoogleFonts.manrope().fontFamily,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
