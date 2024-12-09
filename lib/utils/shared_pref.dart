import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String prefName = "com.example.learn_megnagmet";

  static String isIntro = prefName + "isIntro";
  static String isLogin = prefName + "isLigin";
  static String isVarification = prefName+'isVarification';
  static String isFirstLogin = prefName+'isFirstLogin';

  static setIntro(bool intro) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(isIntro, intro);
  }

  static getIntro() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool intro = sharedPreferences.getBool(isIntro) ?? false;
    return intro;
  }

  ///////////////////Ligin Screen////////////////////
  static setLogin(bool login) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(isLogin, login);
  }

  static getLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool Login = sharedPreferences.getBool(isLogin) ?? false;
    return Login;
  }
  /////////////////////varification/////////
  // static setVarification(bool varification) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setBool(isVarification, varification);
  // }
  //
  // static getVarification() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   bool Varification = sharedPreferences.getBool(isVarification) ?? false;
  //   return Varification;
  // }
  // /////////////////////////firstLogin//////////
  // static setFirstLogin(bool firstlogin) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setBool(isFirstLogin, firstlogin);
  // }
  //
  // static getFirstLogin() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   bool FirstLogin = sharedPreferences.getBool(isFirstLogin) ?? false;
  //   return FirstLogin;
  // }


}
