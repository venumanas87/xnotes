import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xnotes/utils/uiColors.dart';

class LoginData extends ChangeNotifier{
  bool _found = true;

  Color _color = AppColors.accent;


  bool get found => _found;

  Color get color => _color;




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