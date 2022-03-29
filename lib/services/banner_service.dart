part of 'services.dart';

class BannerService {
  //Get Banner Bahana
  static Future<List<BannerModel>> getBannerBahana(
      {http.Client? client}) async {
    String url = apiHttp + 'ba_promo.php';
    client ??= http.Client();

    http.Response response = await client.get(Uri.parse(url));

    log('Response get banner bahana : ' + response.body);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      var result = data;
      return List<BannerModel>.from(result.map((e) => BannerModel.fromJson(e)));
    } else {
      throw ('Error');
    }
  }
}
