part of '../models.dart';

class ListTransaksiModel extends Equatable {
  final String idTransaksi;
  final String hargaNormal;
  final String namaPromo;
  final String filePromo;
  final String linkPromo;
  final String ketStatusTransaksi;
  final String statusTransaksi;
  final String deskripsiPromo;
  final String tanggalAcaraEvent;

  const ListTransaksiModel(
      {required this.idTransaksi,
      required this.hargaNormal,
      required this.namaPromo,
      required this.filePromo,
      required this.linkPromo,
      required this.ketStatusTransaksi,
      required this.statusTransaksi,
      required this.deskripsiPromo,
      required this.tanggalAcaraEvent});

  factory ListTransaksiModel.fromJson(Map<String, dynamic> json) {
    return ListTransaksiModel(
        idTransaksi: json['id_transaksi'],
        hargaNormal: json['harga_normal'],
        namaPromo: json['nama_promo'],
        filePromo: json['file_promo'],
        linkPromo: json['link_promo'],
        ketStatusTransaksi: json['ket_status_transaksi'],
        statusTransaksi: json['status_transaksi'],
        deskripsiPromo: json['deskripsi_promo'],
        tanggalAcaraEvent: json['tanggal_acara_event']);
  }

  @override
  List<Object?> get props => [];
}
