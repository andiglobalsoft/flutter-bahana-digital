part of '../services.dart';

class PaymentMethodService {
  static Future<PaymentMethodModel> getPaymentMethod(
      {required String noInvoice,
      required String total,
      http.Client? client}) async {
    String url = apiHttp + 'ba_payment_manual.php';
    client ??= http.Client();

    http.Response response = await client
        .get(Uri.parse(url + '?no_invoice=$noInvoice&total=$total'));

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
