part of '../models.dart';

class TransactionModel extends Equatable {
  final String idTransaction;
  final String invoice;
  final String purchaseDate;
  final String statusTransaction;
  final String cartStatus;
  final String totalPaymentFormat;

  const TransactionModel(
      {required this.idTransaction,
      required this.invoice,
      required this.purchaseDate,
      required this.statusTransaction,
      required this.totalPaymentFormat,
      required this.cartStatus});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        idTransaction: json['id_transaksi'] ?? '',
        invoice: json['invoice'] ?? '',
        purchaseDate: json['tgl_beli'] ?? '',
        statusTransaction: json['status_transaksi'] ?? '',
        totalPaymentFormat: json['total_pembayaran_format'] ?? '',
        cartStatus: json['keterangan_status'] ?? '');
  }

  @override
  List<Object?> get props => [
        idTransaction,
        invoice,
        purchaseDate,
        statusTransaction,
        totalPaymentFormat,
        cartStatus
      ];
}
