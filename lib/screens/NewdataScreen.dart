import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnotes/utils/firestore.dart';
import 'package:xnotes/utils/sharedpref_data.dart';
import 'package:xnotes/utils/uiColors.dart';

class NewdataScreen extends StatelessWidget{
  String title;
  String text;
  final textControllerTitle = TextEditingController();
  final textControllerText = TextEditingController();



  NewdataScreen(this.title, this.text);

  @override
  Widget build(BuildContext context) {
    textControllerText.text = text;
    textControllerTitle.text = title;
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              TextFormField(
                controller: textControllerTitle,
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
                controller: textControllerText,
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
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          syncData(context);
                        },
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


  syncData(context){
    Navigator.pop(context);
    SharedPref().getAppState().then((value){
      FirestoreDb(value.id).addNote(textControllerTitle.text, textControllerText.text);
    });
  }

}