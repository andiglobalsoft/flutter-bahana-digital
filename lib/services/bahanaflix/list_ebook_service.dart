part of '../services.dart';

class ListEbookServices {
  //Gets List Ebook new, package, rent, buy
  static Future<DataListEbookModel> getListEbook({http.Client? client}) async {
    // String url = apiHttp + 'ba_list_ebook.php';
    String url = apiHttp + 'ba_list_ebooknew.php';
    client ??= http.Client();

    http.Response response = await client.get(Uri.parse(url));

    log('Response List Ebook : ' + response.body);

    var data = json.decode(response.body);
    var result = data;
    return DataListEbookModel.fromJson(result);
  }

  //Gets EBook by Category
  static Future<List<ListEbookModel>> getListCetegoryEbook(
      {required int limit,
      offset,
      required String idCategory,
      tag,
      search,
      http.Client? client}) async {
    String url = apiHttp + 'ba_ebook.php';
    client ??= http.Client();

    http.Response response = await client.get(Uri.parse(url +
        '?tag=$tag&limit=$limit&offset=$offset&idkategori=$idCategory&q=$search'));

    log('tag=$tag&limit=$limit&offset=$offset&idkategori=$idCategory&q=$search');
    log('Respone List Ebook Category ' + response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var result = data;
      return List<ListEbookModel>.from(
          result.map((e) => ListEbookModel.fromJson(e)));
    } else {
      throw (Exception(response.statusCode));
    }
  }

  //Get Detail EBook
  static Future<ProductDetailsBahanaflixModel> getProductDetailsDetaEbook(
      String idBook,
      {http.Client? client}) async {
    String url = apiHttp + 'ba_ebook.php';
    client ??= http.Client();

    http.Response response =
        await client.get(Uri.parse(url + '?tag=detail&id_buku=$idBook'));

    log('Respone Produc tDetails Ebook ' + response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var result = data;
      return ProductDetailsBahanaflixModel.fromJson(result);
    } else {
      throw (Exception(response.statusCode));
    }
  }

  //Ba Card
  static Future<BaCardResult> baCard(String tag, idUser, idBook,
      {required String status, http.Client? client}) async {
    String url = apiHttp + 'ba_cart.php';
    client ??= http.Client();

    http.Response response = await client.post(Uri.parse(url), body: {
      'tag': tag,
      'id_user': idUser,
      'id_buku': idBook,
      'status': status
    });

    var data = json.decode(response.body);
    if (tag == 'listcart') {
      log('item cart user : $idUser' + response.body);
      var result = data;
      try {
        List<ListEbookModel> listEBookInCard = List<ListEbookModel>.from(
            result.map((e) => ListEbookModel.fromJson(e)));
        log('item cart user : $idUser ' + response.body);

        return BaCardResult(response.statusCode,
            listEBookInCard: listEBookInCard);
      } catch (e) {
        return BaCardResult(response.statusCode,
            massage: result['pesan'], listEBookInCard: []);
      }
    } else if (tag == 'carttotal') {
      var result = data;
      log('item cart total user : $idUser' + response.body);
      CartCheckout cartCheckout = CartCheckout.fromJson(result);

      return BaCardResult(response.statusCode,
          cartCheckout: cartCheckout, listEBookInCard: []);
    } else if (tag == 'deletecart') {
      log('Delete item cart Ebook $idBook to card user : $idUser' +
          response.body);
      var result = data['pesan'];
      return BaCardResult(response.statusCode,
          massage: result, listEBookInCard: []);
    } else {
      log(
        'Add Ebook $idBook to cart user : $idUser' + response.body,
      );
      var result = data['pesan'];
      return BaCardResult(response.statusCode,
          massage: result, listEBookInCard: []);
    }
  }

  //Bookshelf
  static Future<List<BookshelfModel>> getBookshelf(String idUser,
      {required int limit, required int status, http.Client? client}) async {
    String url = apiHttp + 'ba_bookme.php';
    client ??= http.Client();

    try {
      http.Response response = await client.get(Uri.parse(
          url + '?id_user=$idUser&limit=$limit&offset=10&status=$status'));

      log('Bookshelf User $idUser :' + response.body);
      var data = json.decode(response.body);
      // if (response.statusCode == 200) {
      var result = data;
      return List<BookshelfModel>.from(
          result.map((e) => BookshelfModel.fromJson(e)));
      // }
    } catch (e) {
      throw (Exception(e));
    }
  }

  // static Future<List<ListEbookModel>> listCard(String idUser,
  //     {http.Client? client}) async {
  //   String url = apiHttp + 'ba_cart.php';
  //   client ??= http.Client();

  //   try {
  //     http.Response response = await client
  //         .post(Uri.parse(url), body: {'tag': 'listcart', 'id_user': idUser});

  //     log(response.body);

  //     var data = json.decode(response.body);
  //     var result = data;

  //     return List<ListEbookModel>.from(
  //         result.map((e) => ListEbookModel.fromJson(e)));
  //   } catch (e) {
  //     throw (Exception(e));
  //   }
  // }

  //
  static Future<BaCardResult> getListMore(
      {required String more,
      required String limit,
      required String q,
      http.Client? client}) async {
    String url = apiHttp + 'ba_ebook_semua.php';
    client ??= http.Client();

    try {
      http.Response response = await client
          .get(Uri.parse(url + '?tag=$more&limit=$limit&offset=10&q=$q'));

      log(response.body);

      var data = json.decode(response.body);
      var result = data;

      return BaCardResult(response.statusCode,
          listEBookInCard: List<ListEbookModel>.from(
              result.map((e) => ListEbookModel.fromJson(e))));
    } catch (e) {
      throw Exception(e);
    }
  }
}

class BaCardResult {
  final int statusCode;
  final List<ListEbookModel> listEBookInCard;
  final CartCheckout? cartCheckout;
  final String? massage;
  BaCardResult(this.statusCode,
      {required this.listEBookInCard, this.cartCheckout, this.massage});
}

class TagMoreResult {
  final int statusCode;
  final List<ListEbookModel>? listEBookInCard;
  final CartCheckout? cartCheckout;
  final String? massage;
  TagMoreResult(this.statusCode,
      {this.listEBookInCard, this.cartCheckout, this.massage});
}

class DataListEbookModel {
  final List<ListEbookModel> afterthought;
  final List<ListEbookModel> magazine;
  final List<ListEbookModel> listNew;
  final List<ListEbookModel> listPackage;
  final List<ListEbookModel> listRent;
  final List<ListEbookModel> listBuy;
  const DataListEbookModel(
      {required this.afterthought,
      required this.magazine,
      required this.listNew,
      required this.listPackage,
      required this.listRent,
      required this.listBuy});

  factory DataListEbookModel.fromJson(Map<String, dynamic> json) {
    return DataListEbookModel(
        afterthought: List<ListEbookModel>.from(
            json['hasil_renungan'].map((e) => ListEbookModel.fromJson(e))),
        magazine: List<ListEbookModel>.from(
            json['hasiL_majalah'].map((e) => ListEbookModel.fromJson(e))),
        listNew: List<ListEbookModel>.from(
            json['hasil_terbaru'].map((e) => ListEbookModel.fromJson(e))),
        listPackage: List<ListEbookModel>.from(
            (json['hasil_paket'] ?? json['hasil_sewa'])
                .map((e) => ListEbookModel.fromJson(e))),
        listRent: List<ListEbookModel>.from(
            json['hasil_sewa'].map((e) => ListEbookModel.fromJson(e))),
        listBuy: List<ListEbookModel>.from(
            json['hasil_beli'].map((e) => ListEbookModel.fromJson(e))));
  }

  List<Object?> get props => [listNew, listPackage, listRent, listBuy];
}
