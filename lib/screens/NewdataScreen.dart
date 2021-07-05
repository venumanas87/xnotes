import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xnotes/utils/firestore.dart';
import 'package:xnotes/utils/sharedpref_data.dart';
import 'package:xnotes/utils/uiColors.dart';

class NewdataScreen extends StatefulWidget {
  final String title;
  final String text;
  final bool isNew;
  final String docid;

  NewdataScreen(this.title, this.text, this.isNew, this.docid);

  @override
  _NewdataScreenState createState() => _NewdataScreenState();
}

class _NewdataScreenState extends State<NewdataScreen> {

   var textControllerTitle;
   var textControllerText;



  @override
  void initState() {

   textControllerTitle = TextEditingController();

   textControllerText = TextEditingController();

    textControllerText.text = widget.text;
    textControllerTitle.text = widget.title;

    textControllerTitle.addListener(() {
      new Future.delayed(Duration.zero,() {
        updateDataSync();
      });
    });

    textControllerText.addListener(() {
      new Future.delayed(Duration.zero,() {
       updateDataSync();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                onTap: (){
                  syncData(context);
                },
                borderRadius: BorderRadius.circular(100),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              )],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: textControllerTitle,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(color: Colors.white, fontSize: 19)),
                    decoration: InputDecoration(
                      hintText: "Awesome Title",
                      hintStyle: TextStyle(color: Colors.white12),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SingleChildScrollView(
                    child: TextFormField(
                      controller: textControllerText,
                      onChanged: syncData,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Color(0x80ffffff))),
                      decoration: InputDecoration(
                          hintText: "Type here",
                          hintStyle: TextStyle(color: Colors.white12),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none
                          // enabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.grey)),
                          // disabledBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(color: Colors.grey)),
                          // focusedBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(color: AppColors.accent)),
                          ),
                      minLines: 8,
                      maxLines: 16,
                    ),
                  ),
                  /*Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
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
                                child: Text(
                                  "Sync",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  syncData(context) {
    if (widget.isNew) {
      print(textControllerTitle.text + "ve");
      if(textControllerTitle.text.isEmpty && textControllerText.text.isEmpty){
        Navigator.pop(context);
      }else{
        Navigator.pop(context);
        HapticFeedback.lightImpact();
        SharedPref().getAppState().then((value) {
          FirestoreDb(value.id)
              .addNote(textControllerTitle.text, textControllerText.text);
        });
      }
    } else {
      Navigator.pop(context);
      HapticFeedback.lightImpact();
      SharedPref().getAppState().then((value) {
        FirestoreDb(value.id).updateNote(
            textControllerTitle.text, textControllerText.text, widget.docid);
      });
    }
  }

  updateDataSync(){
    if(widget.isNew){
    }else{
      SharedPref().getAppState().then((value) {
        FirestoreDb(value.id).updateNote(
            textControllerTitle.text, textControllerText.text, widget.docid);
      });
    }

  }


}
