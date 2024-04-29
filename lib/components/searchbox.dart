import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:takenote/constants/style.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "Search notes",
        hintStyle: TextStyle(
          fontFamily: GoogleFonts.manrope().fontFamily,
          color: AppColors.body,
        ),
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: AppColors.body.withOpacity(.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
