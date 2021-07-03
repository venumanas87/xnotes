import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xnotes/models/login_data.dart';
import 'package:xnotes/screens/HomeScreen.dart';
import 'package:xnotes/utils/uiColors.dart';
import 'package:xnotes/widgets/card_widget.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();

}

class _LoginState extends State<LoginScreen>{


  String uid;
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          color: AppColors.lightBg,
          child: FractionallySizedBox(
            heightFactor: 0.6,
            widthFactor: 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter a unique id",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: Color(0xccffffff),fontSize: 20)
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Consumer<LoginData>(
                    builder:(context,data,child){
                      return TextField(
                        controller: myController,
                        onChanged: catchChange,
                        cursorColor: Colors.white,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Color.fromARGB(
                                87, 255, 255, 255),fontSize: 18,fontWeight: FontWeight.bold)
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(color: data.color )
                            ) ,
                            hoverColor: Colors.redAccent,
                            focusColor: Colors.white
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: (){
                    checkifUnique();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)
                        ),
                        color: AppColors.accent,
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Center(
                            child: Text(
                              ">",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)
                            ),
                          ),
                        ),
                      )
                      ),
                    Consumer<LoginData>(
                      builder: (context,data,child){
                       return Visibility(
                         visible: !data.found,
                         child: SizedBox(
                           height: 70,
                           width: 70,
                           child: CircularProgressIndicator(
                           ),
                         ),
                       );
                      },
                    )
                    ]
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  
  checkifUnique() async{

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var loginInfo = Provider.of<LoginData>(context,listen: false);
    loginInfo.setFalse();
    loginInfo.setNormalColor();
   var result = await firestore.collection("xnotes").doc("quickyquick").collection("ids")
       .where("id",isEqualTo: myController.text)
       .get();

    if(result.docs.isNotEmpty){
      print("toggle");
      loginInfo.setTrue();
      loginInfo.setErrorColor();
      print(loginInfo.found);
    }else{
      print("disposed ${loginInfo.found}");
      loginInfo.setTrue();
      loginInfo.dispose();
      firestore.collection("xnotes").doc("quickyquick").collection("ids")
          .add({
        "id" : myController.text
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(true)));
    }



  }

  void catchChange(String value) {

  }

}