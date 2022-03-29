part of '../services.dart';

class ListCategoryServices {
  static Future<List<ListCategoryBahanaflixModel>> getListCategoryBahanaflix(
      {http.Client? client}) async {
    String url = apiHttp + 'ba_list_kategori.php';
    client ??= http.Client();

    http.Response response = await client.get(Uri.parse(url));

    log('Response category bahanaflix : ' + response.body);

    var data = json.decode(response.body);
    var result = data;
    return List<ListCategoryBahanaflixModel>.from(
        result.map((e) => ListCategoryBahanaflixModel.fromJson(e)));
  }
}
