part of 'services.dart';

class AdsService {
  static Future<List<AdsModel>> ads(
      {required String tag, required String idAds, http.Client? client}) async {
    String url = apiHttp + 'ba_iklan.php';
    client ??= http.Client();

    try {
      http.Response response =
          await client.get(Uri.parse(url + '?tag=$tag&id_iklan=$idAds'));

      log('Response ADS : ' + response.body);

      var data = json.decode(response.body);

      var result = data;
      return List<AdsModel>.from(result.map((e) => AdsModel.fromJson(e)));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<AdsModel> adsDetail(
      {required String tag, required String idAds, http.Client? client}) async {
    String url = apiHttp + 'ba_iklan.php';
    client ??= http.Client();

    try {
      http.Response response =
          await client.get(Uri.parse(url + '?tag=$tag&id_iklan=$idAds'));

      log('Response ADS : ' + response.body);

      var data = json.decode(response.body);

      var result = data;
      return AdsModel.fromJson(result);
    } catch (e) {
      throw Exception(e);
    }
  }
}
