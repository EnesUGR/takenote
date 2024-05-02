import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopWidget extends StatefulWidget {
  final String title;
  final void Function()? onTap;
  final IconData? leading;
  final bool isHome;
  // final IconData? iconRight;
  final void Function()? settingsOnPressed;
  const TopWidget({
    super.key,
    required this.title,
    this.onTap,
    this.leading,
    this.isHome = false,
    this.settingsOnPressed,
    // this.iconRight,
  });

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: widget.leading != null,
          child:
              IconButton(onPressed: widget.onTap, icon: Icon(widget.leading)),
        ),
        Text(
          widget.title,
          style: TextStyle(
            fontFamily: GoogleFonts.manrope().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 8, top: 3),
        //   child: Icon(
        //     widget.iconRight,
        //     size: 25,
        //   ),
        // ),
        const Spacer(),
        Visibility(
          visible: widget.isHome,
          child: IconButton(
              onPressed: widget.settingsOnPressed,
              icon: const Icon(Icons.settings_rounded)),
        ),
      ],
    );
  }
}
