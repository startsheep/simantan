import 'package:sp_util/sp_util.dart';

class AuthServices {
  static set setToken(String token) => SpUtil.putString('token', token);
  static get getToken => SpUtil.getString('token');
  static set setAuth(bool stat) => SpUtil.putBool('isAuth', stat);
  static get getAuth => SpUtil.getBool('isAuth');
  static set setUser(Object user) => SpUtil.putObject('user', user);
  static get getUser => SpUtil.getObject('user');
  static set setRole(Object role) => SpUtil.putObject('role', role);
  static set setUserId(int id) => SpUtil.putInt('user_id', id);
  static get getUserId => SpUtil.getInt('user_id');
}
