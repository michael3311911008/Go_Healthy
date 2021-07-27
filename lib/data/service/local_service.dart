import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  LocalService._internal();
  static final _singleton = LocalService._internal();
  factory LocalService() => _singleton;
  late SharedPreferences sf;

  Future<bool> getLoginStatus() async {
    sf = await SharedPreferences.getInstance();
    bool result = sf.getBool('isLogin') ?? false;
    return result;
  }

  Future<Map> getLoginDetails() async {
    sf = await SharedPreferences.getInstance();
    String email = (sf.getString('email') ?? '');
    int? idUser = (sf.getInt('idUser'));
    return {'email': email, 'idUser': idUser};
  }

  Future<void> saveLoginDetails(String email, int idUser) async {
    sf = await SharedPreferences.getInstance();
    sf.setBool('isLogin', true);
    sf.setString('email', email);
    sf.setInt('idUser', idUser);
  }

  Future<void> removeLoginDetails() async {
    sf = await SharedPreferences.getInstance();
    sf.remove('isLogin');
    sf.remove('email');
    sf.remove('idUser');
  }

  Future<bool> isSeen() async {
    sf = await SharedPreferences.getInstance();
    return sf.getBool('isSeen') ?? false;
  }

  Future<void> setSeen() async {
    sf = await SharedPreferences.getInstance();
    sf.setBool('isSeen', true);
  }
}
