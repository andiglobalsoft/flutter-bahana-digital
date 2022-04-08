part of '../models.dart';

class SertifikatEventModel extends Equatable {
  final String idSertifikat;
  final String namaPromo;
  final String filePromo;
  final String fileSertifikat;
  final String tanggalAcaraEvent;

  const SertifikatEventModel(
      {required this.idSertifikat,
      required this.namaPromo,
      required this.filePromo,
      required this.fileSertifikat,
      required this.tanggalAcaraEvent});

  factory SertifikatEventModel.fromJson(Map<String, dynamic> json) {
    return SertifikatEventModel(
      idSertifikat: json['id_sertifikat'],
      namaPromo: json['nama_promo'],
      filePromo: json['file_promo'],
      fileSertifikat: json['file_sertifikat'],
      tanggalAcaraEvent: json['tanggal_acara_event'],
    );
  }

  @override
  List<Object?> get props =>
      [idSertifikat, namaPromo, filePromo, fileSertifikat];
}
