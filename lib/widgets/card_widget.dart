import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xnotes/models/login_data.dart';
import 'package:xnotes/screens/LoginScreen.dart';
import 'package:xnotes/screens/NewdataScreen.dart';
import 'package:xnotes/utils/uiColors.dart';

class CardWidget extends StatelessWidget {
  final String heading;
  final String text;
  final Function onTap;

  CardWidget(this.heading, this.text,this.onTap);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: AppColors.lightBg,
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      heading,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Color(0xffffffff))),
                    ),
                  ),
                  Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 13,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(color: Color(0x80ffffff))),
                  )
                ]),
          ),
        ),
    );
  }
}
