import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopWidget extends StatefulWidget {
  final String title;
  final void Function()? onTap;
  final IconData? leading;
  final void Function()? trailingOnPressed;
  final IconData? trailing;
  const TopWidget({
    super.key,
    required this.title,
    this.onTap,
    this.leading,
    this.trailingOnPressed,
    this.trailing,
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
        const Spacer(),
        Visibility(
          visible: widget.trailing != null,
          child: IconButton(
              onPressed: widget.trailingOnPressed, icon: Icon(widget.trailing)),
        ),
      ],
    );
  }
}
