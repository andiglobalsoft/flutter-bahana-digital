part of 'shared.dart';

//Url base api
// String apiHttp = 'http://192.168.6.42/andipub_bahanaflix/api/';
// String apiHttp = 'https://andipublisher.com/application_api/';
String apiHttp = 'https://dev.andipublisher.com/application_api/';

//Authentication User on Divices
String idUser = '';
bool detectUser = false;
int itemCardProduct = 0;
ValueNotifier ss = itemCardProduct as ValueNotifier;

Stream<int> generateNumbers = (() async* {
  for (int i = 1; i <= 10; i++) {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield itemCardProduct;
  }
  yield itemCardProduct;
})();

//Versi App
String versiApp = '';

//shareLinkProduk
String shareLinkProduk = 'https://dev.andipublisher.com/produk/detail/';

//ADS Show Dialog
bool adsshowDialog = true;
