import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/components/topwidget.dart';
import 'package:takenote/constants/style.dart';
import 'package:takenote/services/spref_manager.dart';
import 'package:takenote/utils/extensions.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              TopWidget(
                title: "Settings",
                leading: Icons.arrow_back_ios_rounded,
                onTap: () => context.back(),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text(
                  "Clear All Notes",
                  style: TextStyle(
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  onPressed: () {
                    NoteManagerSPref.deleteAllNotes(permission: true).then(
                      (value) => context.showSnackBar("All notes deleted"),
                    );
                  },
                  icon: Icon(Icons.build_circle_rounded,
                      color: AppColors.primary),
                ),
              ),
              const Spacer(),
              Text(
                "Powered by Enes Ugur",
                style: TextStyle(
                  fontFamily: GoogleFonts.manrope().fontFamily,
                  fontWeight: FontWeight.w200,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
