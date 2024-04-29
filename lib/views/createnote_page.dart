import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/components/topwidget.dart';
import 'package:takenote/constants/style.dart';
import 'package:takenote/utils/extensions.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
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
                    '14/10/24',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
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
