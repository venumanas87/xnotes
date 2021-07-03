import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xnotes/utils/uiColors.dart';
import 'package:xnotes/widgets/card_widget.dart';

class HomeScreen extends StatelessWidget {
  final bool isComp;
  HomeScreen(this.isComp){
    if(isComp){

    }
  }
  @override
  Widget build(BuildContext context) {
    List<String> list = [];
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection("class").doc("3").collection("community").get().then((value)=>{
      value.docs.forEach((element) {
        list.add(element.toString());

      })
    });
    if(isComp) return Scaffold(
            backgroundColor: AppColors.darkBg,
            body: Stack(
                children: [
                  StreamBuilder(
                      stream: firestore.collection("class").doc("3").collection("community").snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView(
                            children: snapshot.data.docs.map((document) {
                              return CardWidget(document["postTitle"]);
                            }).toList()
                        );
                      }
                  ),

                ]
            ));
  }
}