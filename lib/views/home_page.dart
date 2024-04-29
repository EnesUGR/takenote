import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/components/pinned_note.dart';
import 'package:takenote/components/searchbox.dart';
import 'package:takenote/components/topwidget.dart';
import 'package:takenote/constants/style.dart';
import 'package:takenote/utils/extensions.dart';
import 'package:takenote/views/createnote_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

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
          context.goPage(const CreateNotePage());
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
                //TODO: tek bir note widgetı olmalı bu liste değil
                const PinnedNote(),
                const SizedBox(height: 20),
                Text(
                  "Others",
                  style: TextStyle(
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.body,
                  ),
                ),
                const SizedBox(height: 10),
                notesWidgets(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded notesWidgets(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: context.width,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) => Container(
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
                  'Accounts',
                  style: TextStyle(
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "yesterday",
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
                    'Lorem Ipsum is simply dummy text of the prinLorem Ipsum is simply dummy text of the prinLorem Ipsum is simply dummy text of the prinLorem Ipsum is simply dummy text of the prinLorem Ipsum is simply dummy text of the prin',
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
