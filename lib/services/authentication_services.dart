part of 'services.dart';

class AuthenticationServices {
  //Sign in user
  static Future<AuthenticationResult> signIn(
      {required String email,
      required String password,
      http.Client? client}) async {
    String url = apiHttp + 'ba_login_user.php';
    client ??= http.Client();

    try {
      http.Response response = await client
          .get(Uri.parse(url + '?email_login=$email&pass_login=$password'));

      log('Response SignIn : ' + response.body);

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        var result = data;
        UserModel userModel = UserModel.fromJson(result);
        SharedPreferencesUser().saveUser(idUser: result['id_user']);
        idUser = result['id_user'];
        detectUser = true;
        return AuthenticationResult(response.statusCode, userModel: userModel);
      } else {
        var result = data['pesan'];
        return AuthenticationResult(response.statusCode, massage: result);
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  //Sign up user
  static Future<AuthenticationResult> signUp(String name, String email,
      String noPhone, String password, File? imageProfile, String referal,
      {http.Client? client}) async {
    String url = apiHttp + 'ba_add_user.php';
    client ??= http.Client();

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['nama'] = name;
      request.fields['email_login'] = email;
      request.fields['no_hp'] = noPhone;
      request.fields['pass_login'] = password;
      // print('img' + imageProfile.toString());
      if (imageProfile!.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'uploadedfile', imageProfile.path));
      }
      if (referal.trim().isNotEmpty) {
        request.fields['referal'] = referal;
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('Status code: ${response.statusCode}');
      log('Body: ${response.body}');

      // http.Response response1 = await client.post(Uri.parse(url), body: {
      //   'nama': name,
      //   'email_login': email,
      //   'no_hp': noPhone,
      //   'pass_login': password
      // });
      log('Response SignUp : ' + response.body);

      var data = json.decode(response.body);
      String result = data['pesan'];
      return AuthenticationResult(response.statusCode,
          massage: result.toString());
    } catch (e) {
      log("error Profile Services " + e.toString());
      throw (Exception(e));
    }
  }

  //Get user
  static Future<AuthenticationResult> getUser(String idUser,
      {http.Client? client}) async {
    String url = apiHttp + 'ba_user.php';
    client ??= http.Client();

    http.Response response =
        await client.get(Uri.parse(url + '?id_user=$idUser'));

    log('idUser : $idUser');
    log('Response Getuser : ' + response.body);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      UserModel userModel = UserModel.fromJson(data);
      return AuthenticationResult(response.statusCode, userModel: userModel);
    } else {
      var result = data['pesan'];
      return AuthenticationResult(response.statusCode, massage: result);
    }
  }

  static Future<AuthenticationResult> editProfile(
      {required String idUser,
      required String noPhone,
      required String name,
      required String? password,
      required File? imageProfile,
      http.Client? client}) async {
    String url = apiHttp + 'ba_profil.php';
    client ??= http.Client();

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id_user'] = idUser;
      request.fields['nama'] = name;
      request.fields['no_hp'] = noPhone;

      if (password!.isNotEmpty) {
        request.fields['pass_login'] = password;
      }

      if (imageProfile!.path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'uploadedfile', imageProfile.path));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log('Status code: ${response.statusCode}');
      log('Body: ${response.body}');

      log('Response edit profile : ' + response.body);

      var data = json.decode(response.body);
      String result = data['pesan'];

      return AuthenticationResult(response.statusCode,
          massage: result.toString());
    } catch (e) {
      log("error editProfile Services " + e.toString());
      throw (Exception(e));
    }
  }

  //forgetPassword
  static Future<AuthenticationResult> forgetPassword(String email, password,
      {http.Client? client}) async {
    String url = apiHttp + 'ba_password.php';
    client ??= http.Client();

    if (password == '') {
      http.Response response = await client.post(Uri.parse(url), body: {
        'email_user': email,
      });

      log(
        'email_user' + email,
      );
      log('Response forgetPassword : ' + response.body);
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        return AuthenticationResult(response.statusCode,
            massage: data['pesan']);
      } else {
        var result = data['pesan'];
        return AuthenticationResult(response.statusCode, massage: result);
      }
    } else {
      http.Response response = await client.post(Uri.parse(url), body: {
        'email_user': email,
        'password_baru': password,
      });

      log('email_user' + email + 'password_baru' + password);
      log('Response forgetPassword : ' + response.body);
      var data = json.decode(response.body);
      var result = data['pesan'];
      if (response.statusCode == 200) {
        return AuthenticationResult(response.statusCode, massage: result);
      } else {
        var result = data['pesan'];
        return AuthenticationResult(response.statusCode, massage: result);
      }
    }
  }

  //generateReferal
  static Future<void> generateReferal({http.Client? client}) async {
    String url = apiHttp + 'ba_generate.php';
    client ??= http.Client();

    http.Response response =
        await client.get(Uri.parse(url + '?id_user=$idUser'));

    log('Response generate Referal : ' + response.body);
  }

  //Verification
  static Future<AuthenticationResult> verification(
      {required String email, http.Client? client}) async {
    String url = apiHttp + 'ba_kirim_ulang.php';
    client ??= http.Client();
    try {
      http.Response response =
          await client.post(Uri.parse(url), body: {'email_login': email});
      var data = json.decode(response.body);
      var result = data['pesan'];
      log('Response Verification : ' + response.body);
      return AuthenticationResult(response.statusCode, massage: result);
    } catch (e) {
      throw Exception(e);
    }
  }

  //Sign out user
  static Future<void> signOut() async {
    SharedPreferencesUser().deleteUser();
    idUser = '';
    detectUser = false;
    SharedPreferencesUser()
        .getIdUser()
        .then((value) => detectUser = (value.isEmpty) ? false : true);
  }
}

class AuthenticationResult {
  final int statusCode;
  final UserModel? userModel;
  final String? massage;
  AuthenticationResult(this.statusCode, {this.userModel, this.massage});
}
