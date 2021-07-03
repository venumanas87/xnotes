import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xnotes/models/login_data.dart';
import 'package:xnotes/screens/LoginScreen.dart';
import 'package:xnotes/utils/uiColors.dart';

class CardWidget extends StatelessWidget {
  String heading;

  CardWidget(this.heading);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.lightBg,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              ChangeNotifierProvider(
                  child: LoginScreen(),
                create: (context) => LoginData(),
              )));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  heading,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: Color(0xffffffff))
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
