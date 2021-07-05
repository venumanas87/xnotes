import 'dart:ffi';

import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:xnotes/models/login_data.dart';
import 'package:xnotes/screens/LoginScreen.dart';
import 'package:xnotes/screens/NewdataScreen.dart';
import 'package:xnotes/utils/firestore.dart';
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
            openBuilder: (context, builder) => NewdataScreen("", "",true,""),
            closedBuilder: (context, open) => FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
            ),
          ),
          backgroundColor: AppColors.darkBg,
          body: Stack(children: [

            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap:(){
                      SharedPref().clearState();
                      Navigator.pop(context);
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                        child: LoginScreen(),
                        create: (context) => LoginData(),
                      )));
                    },
                    borderRadius:BorderRadius.circular(100),
                    child: SizedBox(
                      height:50,
                        width:50,
                        child: Icon(Icons.logout,
                        color: Colors.white38,)
                    ),
                  )
                ],
              ),
            ),


            StreamBuilder(
                stream: firestore
                    .collection("xnotes")
                    .doc("quickyquick")
                    .collection("ids")
                    .doc(uid)
                    .collection("notes")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if(snapshot.data.docs.length > 0){
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
                      child: StaggeredGridView.countBuilder(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            var obj = snapshot.data.docs[index];
                            return Dismissible(
                              key: Key(obj.id),
                              onDismissed: (direction) {
                                FirestoreDb(uid).deleteNote(obj.id);
                              },
                              child: OpenContainer(
                                  closedColor: AppColors.lightBg,
                                  openBuilder: (context, builder) => NewdataScreen(obj["title"], obj["text"],false,obj.id),
                                  closedShape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  closedBuilder: (context, open) => CardWidget(obj["title"], obj["text"],open)
                              ),
                            );
                          },
                          crossAxisCount: 4,
                          staggeredTileBuilder: (int index) {
                            var obj = snapshot.data.docs[index];
                            String title = obj["text"];
                            double height;
                            int words = title.split(" ").length;
                            if (words < 2 && title.length > 15) {
                              height = (((title.length) ~/ 10) + 2.0);
                            } else {
                              height = ((title.length) ~/ 50 + 1.8);
                            }

                            if(height > 4){
                              height = 4;
                            }
                            return StaggeredTile.count(2, height);
                          }),
                    );
                  }else{
                    return Center(
                      child: Text("Add new notes"),
                    );
                  }

                }),
          ]));
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  @override
  void initState() {
    SharedPref().getAppState().then((value) {
      uid = value.id;
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
