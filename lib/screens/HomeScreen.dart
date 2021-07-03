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

    firestore.collection("class").doc("3").collection("community").get().then((
        value) =>
    {
      value.docs.forEach((element) {
        list.add(element.toString());
      })
    });
    if (isComp) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
        ),
        backgroundColor: AppColors.darkBg,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
          child: Stack(
            children: [
              FutureBuilder(
                  future: firestore.collection("class").doc("3").collection(
                      "community").get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context,index){
                        var obj = snapshot.data.docs[index];
                        return CardWidget(obj["postTitle"]);
                      },
                    );
                  }
              ),

            ]
            ),
        ));
  }else{
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}