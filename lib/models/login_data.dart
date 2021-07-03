import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xnotes/utils/uiColors.dart';

class LoginData extends ChangeNotifier{
  bool _found = true;
  Color _color = AppColors.accent;
  String _text = "Enter a unique id";

  bool get found => _found;
  Color get color => _color;
  String get text => _text;


  setTextPassword(){
    _text = "Set new password for the uid";
    notifyListeners();
  }

  setTextEnterPassword(){
    _text = "Enter existing password for the uid";
    notifyListeners();
  }

  setSuccessColor(){
    _color = Colors.greenAccent;
    notifyListeners();
  }

  setErrorColor(){
    _color = Colors.red;
    notifyListeners();

  }

  setNormalColor(){
    _color = AppColors.accent;
    notifyListeners();
  }

  setFalse(){
    _found = false;
    notifyListeners();
  }

  setTrue(){
    _found = true;
    notifyListeners();
  }
}

class User{
  String id;
  String pass;

  User(this.id, this.pass);
}