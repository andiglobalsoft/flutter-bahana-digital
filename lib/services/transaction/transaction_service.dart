part of '../services.dart';

class TransactionService {
  static Future<BaTransactionResult> baTransaction(String tag,
      {String? idUser,
      String? totalPay,
      String? noInvoice,
      String? discountPrice,
      String? discount,
      String? normalPrice,
      String? paymentType,
      String? statusPayment,
      String? idTransaction,
      String? idBook,
      String? status,
      http.Client? client}) async {
    String url = apiHttp + 'ba_transaction.php';
    client ??= http.Client();

    try {
      // http.Response response = await client.post(Uri.parse(url), body: {
      //   'tag': tag,
      //   'id_user': idUser,
      //   'jumlahbayar': totalPay,
      //   'id_transaksi': idTransaction,
      // });

      // log('Response transaction bahanaflix : ' + response.body);
      // var data = jsonDecode(response.body);
      if (tag == 'update_payment_manual') {
        http.Response response = await client.post(Uri.parse(url), body: {
          'tag': tag,
          'no_invoice': noInvoice,
          'payment_type': paymentType,
          'total': totalPay,
          'status_payment': statusPayment,
        });
        log('tag' +
            tag +
            'no_invoice' +
            noInvoice.toString() +
            'payment_type' +
            paymentType! +
            'total' +
            totalPay! +
            'status_payment' +
            statusPayment!);
        log('Response update_payment_manual bahanaflix : ' + response.body);
        var data = jsonDecode(response.body);

        return BaTransactionResult(response.statusCode,
            message: data['pesan'], noTelepon: data['nomor_telp']);
      } else if (tag == 'addtransaction') {
        http.Response response = await client.post(Uri.parse(url), body: {
          'tag': tag,
          'id_user': idUser,
          'jumlahbayar': totalPay,
          'id_transaksi': idTransaction,
        });

        log('tag: $tag id_user: $idUser,jumlahbayar: $totalPay,id_transaks: $idTransaction');
        log('Response transaction bahanaflix : ' + response.body);
        var data = jsonDecode(response.body);

        var result = data['id_transaksi'];

        return BaTransactionResult(response.statusCode,
            noInvoice: data['no_invoice'],
            total: data['total'],
            idTransaction: result,
            message: data['pesan']);
      } else if (tag == 'listbarang_transaction') {
        http.Response response = await client.post(Uri.parse(url), body: {
          'tag': tag,
          'id_user': idUser,
          'jumlahbayar': totalPay,
          'id_transaksi': idTransaction,
        });

        log('Response transaction listbarang_transaction bahanaflix : ' +
            response.body);
        var data = jsonDecode(response.body);

        var result = data;

        return BaTransactionResult(response.statusCode,
            detailTransactionProductModel:
                List<DetailTransactionProductModel>.from(result
                    .map((e) => DetailTransactionProductModel.fromJson(e))));
      } else if (tag == 'addtransaction_direct') {
        http.Response response = await client.post(Uri.parse(url), body: {
          'tag': tag,
          'id_user': idUser,
          'jumlahbayar': totalPay,
          'id_buku': idBook,
          'harga_normal': normalPrice,
          'diskon': discount,
          'harga_diskon': discountPrice,
          'status': status
        });

        log('tag =$tag, id_user : $idUser, jumlahbayar : $totalPay, id_buku : $idBook, status : $status');

        log('Response transaction addtransaction_direct bahanaflix : ' +
            response.body);
        var data = jsonDecode(response.body);

        var result = data['id_transaksi'];

        return BaTransactionResult(response.statusCode,
            idTransaction: result, message: data['pesan']);
      } else if (tag == 'listtransaction_detail') {
        http.Response response = await client.post(Uri.parse(url),
            body: {'tag': tag, 'id_transaksi': idTransaction});
        log(idTransaction.toString());
        log('Response transaction listtransaction_detail bahanaflix : ' +
            response.body);
        var data = jsonDecode(response.body);

        var result = data;

        return BaTransactionResult(response.statusCode,
            detailTransactionModel: DetailTransactionModel.fromJson(result));
      } else {
        http.Response response = await client
            .post(Uri.parse(url), body: {'tag': tag, 'id_user': idUser});

        log('Response transaction bahanaflix : ' + response.body);
        log('Id Transaction : ' + idTransaction.toString());
        var data = jsonDecode(response.body);

        var result = data;
        return BaTransactionResult(response.statusCode,
            transaction: List<TransactionModel>.from(
                result.map((e) => TransactionModel.fromJson(e))));
      }
    } catch (e) {
      throw (Exception(e));
    }
  }
}

class BaTransactionResult {
  final int statusCode;
  final String? noTelepon;
  final String? noInvoice;
  final String? total;
  final String? idTransaction;
  final List<TransactionModel>? transaction;
  final List<TransactionEventModel>? transactionEvent;
  final List<DetailTransactionProductModel>? detailTransactionProductModel;
  final DetailTransactionModel? detailTransactionModel;
  final String? message;
  const BaTransactionResult(this.statusCode,
      {this.idTransaction,
      this.noTelepon,
      this.noInvoice,
      this.total,
      this.detailTransactionProductModel,
      this.detailTransactionModel,
      this.transaction,
      this.transactionEvent,
      this.message});
}
