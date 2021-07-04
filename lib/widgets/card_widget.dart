import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xnotes/models/login_data.dart';
import 'package:xnotes/screens/LoginScreen.dart';
import 'package:xnotes/screens/NewdataScreen.dart';
import 'package:xnotes/utils/uiColors.dart';

class CardWidget extends StatelessWidget {
  String heading;
  String text;

  CardWidget(this.heading,this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: OpenContainer(
          openBuilder: (context,builder)=>NewdataScreen(heading, text),
          closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          closedBuilder:(context,open) =>  Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          color: AppColors.lightBg,
          child: InkWell(
              onTap: () => open,
              borderRadius: BorderRadius.circular(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Text(
                        heading,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Color(0xffffffff))
                        ),
                      ),
                    ),
                    Text(
                      text,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Color(0x80ffffff))
                      ),
                    )

                  ]
              ),
          ),
        ),
      ),
    );
  }
}
