import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/constants/style.dart';
import 'package:takenote/models/note_model.dart';
import 'package:takenote/utils/extensions.dart';

class NoteWidget extends StatefulWidget {
  final NoteModel note;
  final void Function(BuildContext) onRemove;
  const NoteWidget({
    super.key,
    required this.note,
    required this.onRemove,
  });

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                flex: 1,
                onPressed: widget.onRemove,
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.light,
                icon: Icons.delete_sweep_rounded,
              ),
            ],
          ),
          child: Container(
            //TODO: image version
            height: 140,
            width: context.width,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accent1.withOpacity(.8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.note.title,
                  style: TextStyle(
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                Text(
                  widget.note.dateStamp.fullDate,
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
                    widget.note.note,
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
          ),
        ),
      ),
    );
  }
}
