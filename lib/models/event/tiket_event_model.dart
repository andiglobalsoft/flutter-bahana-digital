part of '../models.dart';

class TiketEventModel extends Equatable {
  final String idTransaksi;
  final String hargaNormal;
  final String namaPromo;
  final String filePromo;
  final String linkPromo;
  final String deskripsiPromo;
  final String ketEvent;
  final String tanggalAcaraEvent;

  const TiketEventModel(
      {required this.idTransaksi,
      required this.hargaNormal,
      required this.namaPromo,
      required this.filePromo,
      required this.linkPromo,
      required this.deskripsiPromo,
      required this.ketEvent,
      required this.tanggalAcaraEvent});

  factory TiketEventModel.fromJson(Map<String, dynamic> json) {
    return TiketEventModel(
        idTransaksi: json['id_transaksi'],
        hargaNormal: json['harga_normal'],
        namaPromo: json['nama_promo'],
        filePromo: json['file_promo'],
        linkPromo: json['link_promo'],
        deskripsiPromo: json['deskripsi_promo'],
        ketEvent: json['ket_event'],
        tanggalAcaraEvent: json['tanggal_acara_event']);
  }

  @override
  List<Object?> get props => [
        idTransaksi,
        hargaNormal,
        namaPromo,
        filePromo,
        linkPromo,
        deskripsiPromo,
        ketEvent,
        tanggalAcaraEvent
      ];
}
