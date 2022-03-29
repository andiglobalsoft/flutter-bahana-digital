part of '../services.dart';

class MidtransService {
  static Future<PaymentMethodModel> getPaymentMethod(
      {http.Client? client}) async {
    String url = apiHttp + 'ba_metodepembayaran.php';
    client ??= http.Client();

    http.Response response = await client.get(Uri.parse(url));

    log('Response get payment method : ' + response.body);
    var data = json.decode(response.body);

    if (response.statusCode == 200) {
      var result = data;
      return PaymentMethodModel.fromJson(result);
    } else {
      throw ('Error');
    }
  }
}
