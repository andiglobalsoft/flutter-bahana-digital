part of '../services.dart';

class EventService {
  //List Event
  static Future<List<EventModel>> getEvent(String tag,
      {String? idPromo, http.Client? client}) async {
    String url = apiHttp + 'ba_event.php';
    client ??= http.Client();

    if (idPromo == null) {
      try {
        http.Response response =
            await client.post(Uri.parse(url), body: {'tag': tag});

        log('tag $tag id_promo $idPromo');
        log('Response Event : ' + response.body);

        var data = jsonDecode(response.body);

        return List<EventModel>.from(data.map((e) => EventModel.fromJson(e)));
      } catch (e) {
        throw (Exception(e));
      }
    } else {
      try {
        http.Response response = await client
            .post(Uri.parse(url), body: {'tag': tag, 'id_promo': idPromo});

        log('tag $tag id_promo $idPromo');
        log('Response Event : ' + response.body);

        var data = jsonDecode(response.body);

        return List<EventModel>.from(data.map((e) => EventModel.fromJson(e)));
      } catch (e) {
        throw (Exception(e));
      }
    }
  }

  //Tiket Event
  static Future<List<TiketEventModel>> getTiketEvent(String tag,
      {http.Client? client}) async {
    String url = apiHttp + 'ba_event.php';
    client ??= http.Client();

    try {
      http.Response response = await client
          .post(Uri.parse(url), body: {'tag': tag, 'id_user': idUser});

      log('tag $tag, id_user $idUser');
      log('Response  Tiket Event : ' + response.body);

      var data = jsonDecode(response.body);

      return List<TiketEventModel>.from(
          data.map((e) => TiketEventModel.fromJson(e)));
    } catch (e) {
      throw (Exception(e));
    }
  }

  //add transaksi Event
  static Future<AddTransaksiEventModel> addTransaksiEvent(String tag,
      {required String idPromo,
      status,
      jumlahbayar,
      eventNamaTransaksi,
      http.Client? client}) async {
    String url = apiHttp + 'ba_event.php';
    client ??= http.Client();

    try {
      http.Response response = await client.post(Uri.parse(url), body: {
        'tag': tag,
        'id_user': idUser,
        'id_promo': idPromo,
        'status': status,
        'jumlahbayar': jumlahbayar,
        'event_nama_transaksi': eventNamaTransaksi
      });

      log('tag $tag, id_user $idUser, id_promo $idPromo, status $status, jumlahbayar $jumlahbayar, event_nama_transaksi $eventNamaTransaksi');
      log('Response  add transaksi Event : ' + response.body);

      var data = jsonDecode(response.body);

      return AddTransaksiEventModel.fromJson(data);
    } catch (e) {
      throw (Exception(e));
    }
  }

  //add transaksi Event Free
  static Future<AddTransaksiEventModel> addTransaksiEventFree(String tag,
      {required String idPromo,
      jumlahbayar,
      eventNamaTransaksi,
      http.Client? client}) async {
    String url = apiHttp + 'ba_event.php';
    client ??= http.Client();

    try {
      http.Response response = await client.post(Uri.parse(url), body: {
        'tag': tag,
        'id_user': idUser,
        'id_promo': idPromo,
        'status': '3',
        'jumlahbayar': jumlahbayar,
        'event_nama_transaksi': eventNamaTransaksi
      });

      log('tag $tag, id_user $idUser, id_promo $idPromo, status "3", jumlahbayar $jumlahbayar, event_nama_transaksi $eventNamaTransaksi');
      log('Response  add transaksi Event : ' + response.body);

      var data = jsonDecode(response.body);

      return AddTransaksiEventModel.fromJson(data);
    } catch (e) {
      throw (Exception(e));
    }
  }

  //sertifikat event
  static Future<List<SertifikatEventModel>> getSertifikat(String tag,
      {http.Client? client}) async {
    String url = apiHttp + 'ba_event.php';
    client ??= http.Client();

    try {
      http.Response response = await client
          .post(Uri.parse(url), body: {'tag': tag, 'id_user': idUser});

      log('tag $tag, id_user $idUser');
      log('Response  Tiket Event : ' + response.body);

      var data = jsonDecode(response.body);

      return List<SertifikatEventModel>.from(
          data.map((e) => SertifikatEventModel.fromJson(e)));
    } catch (e) {
      throw Exception(e);
    }
  }

//list transaksi
  static Future<List<ListTransaksiModel>> getListTransaksi(String tag,
      {http.Client? client}) async {
    String url = apiHttp + 'ba_event.php';
    client ??= http.Client();

    try {
      http.Response response = await client
          .post(Uri.parse(url), body: {'tag': tag, 'id_user': idUser});

      log('tag $tag, id_user $idUser');
      log('Response  Tiket Event : ' + response.body);

      var data = jsonDecode(response.body);

      return List<ListTransaksiModel>.from(
          data.map((e) => ListTransaksiModel.fromJson(e)));
    } catch (e) {
      throw Exception(e);
    }
  }
}
