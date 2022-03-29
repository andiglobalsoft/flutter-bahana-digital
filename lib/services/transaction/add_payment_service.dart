part of '../services.dart';

class AddPaymentService {
  //addPaymentBuyNow
  static Future<AddPaymentModel> addPaymentBuyNow(
      {required String idTransaction,
      required String price,
      http.Client? client}) async {
    String url = apiHttp + 'payment_midtrans/create_invoice.php';
    client ??= http.Client();

    try {
      http.Response response = await client.post(Uri.parse(url), body: {
        'id_transaksi': idTransaction,
        'pembayaran': price,
      });

      log('id_transaksi: $idTransaction pembayaran: $price');
      log('Response Add Payment Buy Now : ' + response.body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var result = data[0];

        return AddPaymentModel.fromJson(result);
      } else {
        throw Exception('Error Payment Buy Now');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
