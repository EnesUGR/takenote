import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/constants/style.dart';
import 'package:takenote/utils/extensions.dart';

class PinnedNote extends StatelessWidget {
  const PinnedNote({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //TODO: get the model
    var noteTitle = "Untitled";
    var noteDate = "14/04/24";
    var note =
        "Lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    return SizedBox(
      height: 160,
      width: context.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            width: 160,
            decoration: BoxDecoration(
              color: index % 3 == 0 ? AppColors.secondary : AppColors.accent2,
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
        },
      ),
    );
  }
}
