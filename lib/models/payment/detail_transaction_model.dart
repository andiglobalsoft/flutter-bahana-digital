part of '../models.dart';

class DetailTransactionModel extends Equatable {
  final DataTransactionModel dataTransactionModel;
  final List<ResultModel> resultModel;
  const DetailTransactionModel({
    required this.dataTransactionModel,
    required this.resultModel,
  });

  factory DetailTransactionModel.fromJson(Map<String, dynamic> json) =>
      DetailTransactionModel(
        dataTransactionModel:
            DataTransactionModel.fromJson(json['data_transaksi']),
        resultModel: List<ResultModel>.from(
            json['result'].map((x) => ResultModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [dataTransactionModel, resultModel];
}

class DataTransactionModel extends Equatable {
  final String invoice;
  final String purchaseDate;
  final String statusTransaksi;
  final String statusDescription;
  final String statusPayment;
  final String totalPaymentFormat;
  final String paymentType;
  final String urlPayment;
  final String tokenPayment;
  final String paidDate;
  final String paymentMethod;
  final String noPayment;
  final String message;
  final String noCS;
  final String nameCS;
  final String iconPayment;
  const DataTransactionModel({
    required this.invoice,
    required this.purchaseDate,
    required this.statusTransaksi,
    required this.statusDescription,
    required this.statusPayment,
    required this.totalPaymentFormat,
    required this.paymentType,
    required this.urlPayment,
    required this.tokenPayment,
    required this.paidDate,
    required this.paymentMethod,
    required this.noPayment,
    required this.noCS,
    required this.nameCS,
    required this.message,
    required this.iconPayment,
  });

  factory DataTransactionModel.fromJson(Map<String, dynamic> json) =>
      DataTransactionModel(
        invoice: json['invoice'] ?? '',
        purchaseDate: json['tgl_beli'] ?? '',
        statusTransaksi: json['status_transaksi'] ?? '',
        statusDescription: json['keterangan_status'] ?? '',
        statusPayment: json['status_payment'] ?? '',
        totalPaymentFormat: json['total_pembayaran_format'] ?? '',
        paymentType: json['payment_type'] ?? '',
        urlPayment: json['url_payment'] ?? '',
        paidDate: json['tanggal_dibayar'] ?? '',
        tokenPayment: json['url_payment'] ?? '',
        paymentMethod: json['metode_pembayaran'] ?? '',
        noPayment: json['nomor_payment'] ?? '',
        noCS: json['nomor_telp'] ?? '',
        nameCS: json['penerima_payment'] ?? '',
        message: json['pesan'] ?? '',
        iconPayment: json['icon_payment'] ?? '',
      );

  @override
  List<Object?> get props => [
        invoice,
        purchaseDate,
        statusTransaksi,
        statusDescription,
        totalPaymentFormat,
        paymentType,
        urlPayment,
        paidDate,
        tokenPayment
      ];
}

class ResultModel extends Equatable {
  final String idBook;
  final String price;
  final String priceFormat;
  final String discountPrice;
  final String discountPriceFormat;
  final String totalDiskon;
  final String title;
  final String writer;
  final String cover;
  final dynamic namaCategory;
  const ResultModel({
    required this.idBook,
    required this.price,
    required this.priceFormat,
    required this.discountPrice,
    required this.discountPriceFormat,
    required this.totalDiskon,
    required this.title,
    required this.writer,
    required this.cover,
    required this.namaCategory,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        idBook: json['id_buku'] ?? '',
        price: json['harga'] ?? '',
        priceFormat: json['harga_format'] ?? '',
        discountPrice: json['harga_potongan'] ?? '',
        discountPriceFormat: json['harga_potongan_format'] ?? '',
        totalDiskon: json['jumlah_diskon'] ?? '',
        title: json['judul'] ?? '',
        writer: json['penulis'] ?? '',
        cover: json['cover'] ?? '',
        namaCategory: json['nama_kategori'] ?? '',
      );

  @override
  List<Object?> get props => [
        idBook,
        price,
        priceFormat,
        discountPrice,
        discountPriceFormat,
        totalDiskon,
        title,
        writer,
        cover,
        namaCategory
      ];
}
