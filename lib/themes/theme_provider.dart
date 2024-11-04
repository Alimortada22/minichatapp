import 'package:flutter/material.dart';
import 'package:mini_chat_app/themes/dark_mode.dart';
import 'package:mini_chat_app/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themedata= lightmode;
  ThemeData get themeData=> _themedata;
  bool get isdarkmode => _themedata==darkMode;
   set themedata(ThemeData themedata){
    _themedata=themedata;
    notifyListeners();
 
  }
  void toggletheme(){
       if (_themedata==lightmode) {
      themedata=darkMode;
    }else{
      themedata=lightmode;
    }
  }
}