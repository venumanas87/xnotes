import 'dart:ffi';

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:xnotes/models/login_data.dart';
import 'package:xnotes/screens/LoginScreen.dart';
import 'package:xnotes/screens/NewdataScreen.dart';
import 'package:xnotes/utils/sharedpref_data.dart';
import 'package:xnotes/utils/uiColors.dart';
import 'package:xnotes/widgets/card_widget.dart';

class HomeScreen extends StatefulWidget {
  final bool isComp;
  HomeScreen(this.isComp);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String uid;

  @override
  Widget build(BuildContext context) {
    print("Building from Scratch +++++++++++++");

    final FirebaseFirestore firestore = FirebaseFirestore.instance;



    if (widget.isComp) {
      return Scaffold(
          floatingActionButton: OpenContainer(
            closedShape: CircleBorder(),
            closedColor: AppColors.darkBg,
            openBuilder: (context,builder) => NewdataScreen("",""),
            closedBuilder: (context,open) => FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
            ),
          ),
          backgroundColor: AppColors.darkBg,
          body: Stack(
              children: [
               StreamBuilder(
                    stream: firestore.collection("xnotes").doc("quickyquick").collection("ids").doc(uid).collection("notes").snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }


                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 60, 10,0),
                        child: StaggeredGridView.countBuilder(
                          crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context,index){
                              var obj = snapshot.data.docs[index];
                              return CardWidget(obj["title"],obj["text"]);
                            },
                          crossAxisCount: 4,


                          staggeredTileBuilder: (int index){
                            var obj = snapshot.data.docs[index];
                            String title = obj["text"];
                            double height;
                            int words = title.split(" ").length;
                            if(words < 2 && title.length>15){
                              height = (((title.length)~/10 )+ 2.0);
                            }else{
                              height = ((title.length)~/50 + 1.8);
                            }
                            return StaggeredTile.count(2, height);
                          }
                        ),
                      );
                    }
                ),

              ]
          ));
    }else{
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  @override
  void initState() {
    SharedPref().getAppState().then((value){
      uid = value.id;
    }

    );
  }
}