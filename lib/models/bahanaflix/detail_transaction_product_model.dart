part of '../models.dart';

class DetailTransactionProductModel extends Equatable {
  final dynamic idBook;
  final dynamic price;
  final dynamic priceFormat;
  final dynamic discountPrice;
  final dynamic discountPriceFormat;
  final dynamic discount;
  final dynamic title;
  final dynamic writer;
  final dynamic cover;
  final dynamic nameCategory;

  const DetailTransactionProductModel(
      {required this.idBook,
      required this.price,
      required this.priceFormat,
      required this.discountPrice,
      required this.discountPriceFormat,
      required this.discount,
      required this.title,
      required this.writer,
      required this.cover,
      required this.nameCategory});

  factory DetailTransactionProductModel.fromJson(Map<String, dynamic> json) {
    return DetailTransactionProductModel(
        idBook: json['id_buku'] ?? '',
        price: json['harga'] ?? '',
        priceFormat: json['harga_format'] ?? '',
        discountPrice: json['harga_potongan'] ?? '',
        discountPriceFormat: json['harga_potongan_format'] ?? '',
        discount: json['jumlah_diskon'] ?? '',
        title: json['judul'] ?? '',
        writer: json['penulis'] ?? '',
        cover: json['cover'] ?? '',
        nameCategory: json['nama_kategori'] ?? '');
  }

  @override
  List<Object?> get props => [
        idBook,
        price,
        priceFormat,
        discountPrice,
        discountPriceFormat,
        discount,
        title,
        writer,
        cover,
        nameCategory
      ];
}
