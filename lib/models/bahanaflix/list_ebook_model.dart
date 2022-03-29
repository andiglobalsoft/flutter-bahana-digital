part of '../models.dart';

class ListEbookModel extends Equatable {
  final String idBook;
  final String title;
  final String writer;
  final String cover;
  final String canPackage;
  final String canRent;
  final String canBuy;
  final String rentalPriceFormat;
  final String priceFormat;
  final dynamic discountBuy;
  final dynamic discountRent;
  final String discountPriceFormatBuy;
  final String discountPriceFormatRent;
  final String statusDiscount;
  const ListEbookModel(
      {required this.idBook,
      required this.title,
      required this.writer,
      required this.cover,
      required this.canPackage,
      required this.canRent,
      required this.canBuy,
      required this.rentalPriceFormat,
      required this.priceFormat,
      required this.discountBuy,
      required this.discountRent,
      required this.discountPriceFormatBuy,
      required this.discountPriceFormatRent,
      required this.statusDiscount});

  factory ListEbookModel.fromJson(Map<String, dynamic> json) {
    return ListEbookModel(
        idBook: json['id_buku'] ?? '',
        title: json['judul'] ?? '',
        writer: json['penulis'] ?? '',
        cover: json['cover'] ?? '',
        canPackage: json['bisa_paket'] ?? 'N',
        canRent: json['bisa_sewa'] ?? 'N',
        canBuy: json['bisa_beli'] ?? 'Y',
        rentalPriceFormat: json['harga_sewa_format'] ?? '0',
        priceFormat: json['harga_format'] ?? '0',
        discountBuy: json['jumlah_diskon'] ?? json['jumlah_diskon_beli'] ?? '0',
        discountRent: json['jumlah_diskon_sewa'] ?? '0',
        discountPriceFormatBuy: json['harga_potongan_format'] ??
            json['harga_beli_diskon_format'] ??
            '0',
        discountPriceFormatRent: json['harga_sewa_diskon_format'] ?? '0',
        statusDiscount: json['status_diskon'] ?? 'Y');
  }

  @override
  List<Object?> get props => [
        idBook,
        title,
        writer,
        cover,
        canPackage,
        canRent,
        canBuy,
        rentalPriceFormat,
        priceFormat,
        discountBuy,
        discountPriceFormatBuy,
        discountPriceFormatRent,
        statusDiscount
      ];
}
