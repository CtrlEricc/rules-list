import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../../models/rule_model.dart';

class RuleCard extends StatelessWidget {
  final Rule item;
  const RuleCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => Get.offNamed('/rule',
            arguments: {'id': item.id, 'preSettedValues': true}),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        item.name,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: orange_600,
                        ),
                      )),
                      Text(
                        'view details',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 12),
                    ],
                  ),
                  Expanded(
                      child: Text(
                    item.active != 0 ? 'Rule activated' : 'Rule deactivated',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: orange_500,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
