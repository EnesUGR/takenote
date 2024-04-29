import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopWidget extends StatefulWidget {
  final String title;
  final void Function()? onTap;
  const TopWidget({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontFamily: GoogleFonts.manrope().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          const Icon(
            Icons.arrow_drop_down,
            size: 40,
          ),
        ],
      ),
    );
  }
}
