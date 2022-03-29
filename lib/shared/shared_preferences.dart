part of 'shared.dart';

class SharedPreferencesUser {
  void saveUser({required String idUser}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('id_user', idUser);
    getIdUser().then((value) => detectUser = (value.isEmpty) ? false : true);
  }

  Future<String> getIdUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('id_user') ?? '';
  }

  void deleteUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    getIdUser().then((value) => log('IdUser Delete :' + value));
  }
}
