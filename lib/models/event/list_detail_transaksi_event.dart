part of '../models.dart';

class ListDetailTransaksiModel {
  final DataTransaksiEvent dataTransaksiEvent;
  final List<Result> result;

  const ListDetailTransaksiModel(
      {required this.dataTransaksiEvent, required this.result});

  factory ListDetailTransaksiModel.fromJson(Map<String, dynamic> json) {
    return ListDetailTransaksiModel(
        dataTransaksiEvent: DataTransaksiEvent.fromJson(json['data_transaksi']),
        result:
            List<Result>.from(json['result'].map((e) => Result.fromJson(e))));
  }
}

class DataTransaksiEvent {
  final String metodePembayaran;
  final String nomorPayment;
  final String penerimaPayment;
  final String pesan;
  final String nomorTelp;
  final String iconPayment;

  DataTransaksiEvent(
      {required this.metodePembayaran,
      required this.nomorPayment,
      required this.penerimaPayment,
      required this.pesan,
      required this.nomorTelp,
      required this.iconPayment});

  factory DataTransaksiEvent.fromJson(Map<String, dynamic> json) {
    return DataTransaksiEvent(
        metodePembayaran: json['metode_pembayaran'] ?? '',
        nomorPayment: json['nomor_payment'] ?? '',
        penerimaPayment: json['penerima_payment'] ?? '',
        pesan: json['pesan'] ?? '',
        nomorTelp: json['nomor_telp'] ?? '',
        iconPayment: json['icon_payment'] ?? '');
  }
}

class Result {
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
  final String idTransaksi;
  final String invoice;
  final String paymentType;
  final String statusPayment;
  final String urlPayment;

  Result(
      {required this.idPromo,
      required this.harga,
      required this.hargaFormat,
      required this.tanggalAcaraEvent,
      required this.namaPromo,
      required this.statusTransaksi,
      required this.keteranganStatus,
      required this.eventNamaTransaksi,
      required this.filePromo,
      required this.deskripsiPromo,
      required this.idTransaksi,
      required this.invoice,
      required this.paymentType,
      required this.statusPayment,
      required this.urlPayment});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        idPromo: json['id_promo'],
        harga: json['harga'] ?? '',
        hargaFormat: json['harga_format'] ?? '',
        tanggalAcaraEvent: json['tanggal_acara_event'] ?? '',
        namaPromo: json['nama_promo'] ?? '',
        statusTransaksi: json['status_transaksi'] ?? '',
        keteranganStatus: json['keterangan_status'] ?? '',
        eventNamaTransaksi: json['event_nama_transaksi'] ?? '',
        filePromo: json['file_promo'] ?? '',
        deskripsiPromo: json['deskripsi_promo'] ?? '',
        idTransaksi: json['id_transaksi'] ?? '',
        invoice: json['invoice'] ?? '',
        paymentType: json['payment_type'] ?? '',
        statusPayment: json['status_payment'] ?? '',
        urlPayment: json['url_payment'] ?? '');
  }
}
