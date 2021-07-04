import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnotes/utils/uiColors.dart';

class NewdataScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              TextFormField(
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.white)
                ),
                decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey )
                    ),
                    disabledBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey )
                    ) ,
                    focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.accent )
                    ) ,
                    hoverColor: Colors.redAccent,
                    focusColor: Colors.white
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Colors.blueGrey)
                ),

                decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey )
                    ),
                    disabledBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey )
                    ) ,
                    focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.accent )
                    ) ,
                    hoverColor: Colors.redAccent,
                    focusColor: Colors.white
                ),

                minLines: 8,
                maxLines: 100,

              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      color: AppColors.accent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: Center(
                            child: Text("Sync",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(color: Colors.white)
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

}