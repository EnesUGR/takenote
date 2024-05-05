import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/constants/style.dart';
import 'package:takenote/models/note_model.dart';
import 'package:takenote/utils/extensions.dart';

class PinnedNoteWidget extends StatelessWidget {
  final NoteModel noteModel;
  final void Function(BuildContext) removePinned;
  const PinnedNoteWidget({
    super.key,
    required this.noteModel,
    required this.removePinned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Slidable(
          direction: Axis.vertical,
          endActionPane: ActionPane(
            extentRatio: 0.35,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: removePinned,
                backgroundColor: Colors.yellowAccent.shade700,
                foregroundColor: AppColors.light,
                icon: Icons.star_rounded,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            width: 160,
            decoration: BoxDecoration(
              color: AppColors.secondary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noteModel.title,
                  style: TextStyle(
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  noteModel.dateStamp.fullDate,
                  style: TextStyle(
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.dark.withOpacity(.8),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 80,
                  child: Text(
                    noteModel.note,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox backup(
      BuildContext context, String noteTitle, String noteDate, String note) {
    return SizedBox(
      height: 160,
      width: context.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return buildContainer(noteTitle, noteDate, note);
        },
      ),
    );
  }

  Container buildContainer(String noteTitle, String noteDate, String note) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            noteTitle,
            style: TextStyle(
              fontFamily: GoogleFonts.manrope().fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            noteDate,
            style: TextStyle(
              fontFamily: GoogleFonts.manrope().fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.dark.withOpacity(.8),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: Text(
              note,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontFamily: GoogleFonts.manrope().fontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
