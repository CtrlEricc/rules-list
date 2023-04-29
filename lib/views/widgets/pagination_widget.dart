import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rules/constants.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function()? onPressNext;
  final Function()? onPressPrev;
  const PaginationWidget(
      {super.key,
      required this.currentPage,
      required this.onPressNext,
      required this.onPressPrev,
      required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: onPressPrev,
          icon: const Icon(Icons.chevron_left, color: orange_600),
          disabledColor: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Page $currentPage/$totalPages",
            style: GoogleFonts.montserrat(
              fontSize: 12,
            ),
          ),
        ),
        IconButton(
          onPressed: onPressNext,
          icon: const Icon(Icons.chevron_right, color: orange_600),
          disabledColor: Colors.grey,
        ),
      ],
    );
  }
}
