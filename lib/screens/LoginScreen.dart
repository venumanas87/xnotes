import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:xnotes/models/login_data.dart';
import 'package:xnotes/screens/HomeScreen.dart';
import 'package:xnotes/utils/sharedpref_data.dart';
import 'package:xnotes/utils/uiColors.dart';
import 'package:xnotes/widgets/card_widget.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();

}

class _LoginState extends State<LoginScreen>{


  String uid;
  final myController = TextEditingController();
  bool redirect = false;
  bool existing;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.darkBg,
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          color: AppColors.lightBg,
          child: FractionallySizedBox(
            heightFactor: 0.5,
            widthFactor: 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<LoginData>(
                  builder: (context,data,child){
                    return Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        data.text,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Color(0xccffffff),fontSize: 20)
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Consumer<LoginData>(
                    builder:(context,data,child){
                      return TextField(
                        controller: myController,
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
                FloatingActionButton(
                  onPressed: (){
                    if(redirect){
                      continueLogin();
                    }else {
                      checkifUnique();
                    }
                  },
                  child: Icon(Icons.navigate_next_rounded,
                  size:30 ,
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
    uid = myController.text;
   var result = await firestore.collection("xnotes").doc("quickyquick").collection("ids")
       .where("id",isEqualTo: myController.text)
       .get();

    redirect = true;

    if(result.docs.isNotEmpty){
      print("existing user");
      existing = true;
      loginInfo.setTrue();
      loginInfo.setSuccessColor();
      loginInfo.setTextEnterPassword();
      print(loginInfo.found);
    }else{
      print("new user");
      existing = false;
      loginInfo.setTrue();
      loginInfo.setSuccessColor();
      loginInfo.setTextPassword();
    }


    myController.clear();



  }

  void continueLogin() async{

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var loginInfo = Provider.of<LoginData>(context,listen: false);
    loginInfo.setFalse();
    loginInfo.setNormalColor();
    String pass = myController.text;
    var result = await firestore.collection("xnotes").doc("quickyquick").collection("ids")
        .where("id",isEqualTo: uid)
        .get();

    if(existing){
      if(pass == result.docs[0].get("pass")){
        print("passed");
        SharedPref().saveAppState(uid, pass);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(true)));
      }else{
        loginInfo.setErrorColor();
      }
    }else{
      firestore.collection("xnotes").doc("quickyquick").collection("ids")
      .doc(uid)
          .set({
        "id" : uid,
        "pass" : pass
      });

      SharedPref().saveAppState(uid, pass);

      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(true)));

    }



  }

}