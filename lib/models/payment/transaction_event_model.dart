part of '../models.dart';

class TransactionEventModel extends Equatable {
  final String idPromo;
  final String harga;
  final String hargaFormat;
  final String tanggalAcaraEvent;
  final String namaPromo;
  final String statusTransaksi;
  final String keteranganStatus;
  final String eventNamaTransaksi;
  final String filePromo;
  final String deskripsiPromo;

  const TransactionEventModel(
      {required this.idPromo,
      required this.harga,
      required this.hargaFormat,
      required this.tanggalAcaraEvent,
      required this.namaPromo,
      required this.statusTransaksi,
      required this.keteranganStatus,
      required this.eventNamaTransaksi,
      required this.filePromo,
      required this.deskripsiPromo});

  factory TransactionEventModel.fromJson(Map<String, dynamic> json) {
    return TransactionEventModel(
        idPromo: json['id_promo'],
        harga: json['harga'] ?? '',
        hargaFormat: json['harga_format'] ?? '',
        tanggalAcaraEvent: json['tanggal_acara_event'] ?? '',
        namaPromo: json['nama_promo'] ?? '',
        statusTransaksi: json['status_transaksi'] ?? '',
        keteranganStatus: json['keterangan_status'] ?? '',
        eventNamaTransaksi: json['event_nama_transaksi'] ?? '',
        filePromo: json['file_promo'] ?? '',
        deskripsiPromo: json['deskripsi_promo'] ?? '');
  }

  @override
  List<Object?> get props => [];
}
