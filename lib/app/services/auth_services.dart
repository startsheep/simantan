import 'package:sp_util/sp_util.dart';

class AuthServices {
  static set setToken(String token) => SpUtil.putString('token', token);
  static get getToken => SpUtil.getString('token');
  static set setAuth(bool stat) => SpUtil.putBool('isAuth', stat);
  static get getAuth => SpUtil.getBool('isAuth');
}
