part of 'services.dart';

class CustomerServiceService {
  static Future<CustomerServiceResult> customerService(
      {http.Client? client}) async {
    String url = apiHttp + 'ba_customer_service.php';
    client ??= http.Client();

    try {
      http.Response response = await client.get(Uri.parse(url));

      log('Response customer Service : ' + response.body);

      var data = json.decode(response.body);

      var result = data['nomor_telp'];
      return CustomerServiceResult(noCustomerService: result);
    } catch (e) {
      throw Exception(e);
    }
  }
}

class CustomerServiceResult {
  String noCustomerService;
  CustomerServiceResult({required this.noCustomerService});
}
