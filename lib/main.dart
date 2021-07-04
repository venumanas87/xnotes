import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnotes/screens/HomeScreen.dart';
import 'package:xnotes/screens/LoginScreen.dart';
import 'package:xnotes/utils/sharedpref_data.dart';
import 'package:xnotes/utils/uiColors.dart';
import 'package:xnotes/widgets/card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/login_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MaterialApp(home: MyApp(),
  theme: ThemeData(
    primaryColor: AppColors.accent,
    primaryColorDark: AppColors.darkBg,
    accentColor: AppColors.accent
  ),));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _AppState createState() => _AppState();


}

class _AppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return LoginScreen();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return FutureBuilder<User>(
              future: SharedPref().getAppState(),
              builder: (context,snap){
                if (snap.connectionState == ConnectionState.done){
                  if(snap.data.id == null) {
                    return ChangeNotifierProvider(
                      child: LoginScreen(),
                      create: (context) => LoginData(),
                    );
                  }else{
                    print("found data ${snap.data.id}");
                    return ChangeNotifierProvider(
                      child: LoginScreen(),
                      create: (context) => LoginData(),
                    );
                  }
                }
                return HomeScreen(false);
          }
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

}
