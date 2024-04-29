import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopWidget extends StatefulWidget {
  final String title;
  final void Function()? onTap;
  final IconData? leading;
  final IconData? iconRight;
  const TopWidget({
    super.key,
    required this.title,
    this.onTap,
    this.leading,
    this.iconRight,
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
          Visibility(
            visible: widget.leading != null,
            child: Icon(
              widget.leading,
              size: 40,
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontFamily: GoogleFonts.manrope().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          Icon(
            widget.iconRight,
            size: 40,
          ),
        ],
      ),
    );
  }
}
