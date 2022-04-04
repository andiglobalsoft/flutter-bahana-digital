part of '../models.dart';

class AddTransaksiEventModel extends Equatable {
  final String pesan;
  final String? idTransaksi;
  final String? noInvoice;
  final String? total;

  const AddTransaksiEventModel(
      {required this.pesan,
      required this.idTransaksi,
      required this.noInvoice,
      required this.total});

  factory AddTransaksiEventModel.fromJson(Map<String, dynamic> json) {
    return AddTransaksiEventModel(
        pesan: json['pesan'],
        idTransaksi: json['id_transaksi'] ?? '',
        noInvoice: json['no_invoice'] ?? '',
        total: json['total'] ?? '');
  }

  @override
  List<Object?> get props => [];
}
