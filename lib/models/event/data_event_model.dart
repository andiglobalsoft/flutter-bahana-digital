part of '../models.dart';

class EventModel extends Equatable {
  final String idPromo;
  final String? namaPromo;
  final String? filePromo;
  final String? linkPromo;
  final String? deskripsiPromo;
  final String? tanggalAcaraEvent;
  final String? hargaEvent;

  const EventModel(
      {required this.idPromo,
      this.namaPromo,
      this.filePromo,
      this.linkPromo,
      this.deskripsiPromo,
      this.tanggalAcaraEvent,
      this.hargaEvent});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        idPromo: json['id_promo'],
        namaPromo: json['nama_promo'] ?? '',
        filePromo: json['file_promo'] ?? '',
        linkPromo: json['link_promo'] ?? '',
        deskripsiPromo: json['deskripsi_promo'] ?? '',
        tanggalAcaraEvent: json['tanggal_acara_event'] ?? '',
        hargaEvent: json['harga_event'] ?? '');
  }

  @override
  List<Object?> get props => [
        idPromo,
        namaPromo,
        filePromo,
        linkPromo,
        deskripsiPromo,
        tanggalAcaraEvent,
        hargaEvent
      ];
}
