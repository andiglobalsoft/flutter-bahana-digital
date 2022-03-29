part of '../models.dart';

class ProductDetailsBahanaflixModel extends Equatable {
  final String idBook;
  final String title;
  final String writer;
  final String cover;
  final String isbn;
  final String edition;
  final String categoryName;
  final String publicationYear;
  final String canPackage;
  final String canRent;
  final String canBuy;
  final String rentalPrice;
  final String price;
  final String rentalPriceFormat;
  final String priceFormat;
  final String discountBuy;
  final String discountRent;
  final String discountPriceFormatBuy;
  final String discountPriceFomatRent;
  final String discountPriceBuy;
  final String discountPriceRent;
  final String longRent;
  final String statusDiscount;
  const ProductDetailsBahanaflixModel(
      {required this.idBook,
      required this.title,
      required this.writer,
      required this.cover,
      required this.isbn,
      required this.edition,
      required this.categoryName,
      required this.publicationYear,
      required this.canPackage,
      required this.canRent,
      required this.canBuy,
      required this.rentalPrice,
      required this.price,
      required this.rentalPriceFormat,
      required this.priceFormat,
      required this.discountBuy,
      required this.discountRent,
      required this.discountPriceFormatBuy,
      required this.discountPriceFomatRent,
      required this.discountPriceBuy,
      required this.discountPriceRent,
      required this.longRent,
      required this.statusDiscount});

  factory ProductDetailsBahanaflixModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsBahanaflixModel(
        idBook: json['id_buku'] ?? '',
        title: json['judul'] ?? '',
        writer: json['penulis'] ?? '',
        cover: json['cover'] ?? '',
        isbn: json['ISBN'] ?? '',
        edition: json['edisi'] ?? '',
        categoryName: json['nama_kategori'] ?? '',
        publicationYear: json['tahun_terbit'] ?? '',
        canPackage: json['bisa_paket'] ?? 'N',
        canRent: json['bisa_sewa'] ?? 'N',
        canBuy: json['bisa_beli'] ?? 'N',
        rentalPrice: json['harga_sewa'] ?? '0',
        price: json['harga'] ?? '0',
        rentalPriceFormat: json['harga_sewa_format'] ?? '0',
        priceFormat: json['harga_format'] ?? '0',
        discountBuy: json['jumlah_diskon_beli'] ?? '0',
        discountRent: json['jumlah_diskon_sewa'] ?? '0',
        discountPriceFormatBuy: json['harga_beli_diskon_format'] ?? '0',
        discountPriceFomatRent: json['harga_sewa_diskon_format'] ?? '0',
        discountPriceBuy: json['harga_beli_diskon'] ?? '',
        discountPriceRent: json['harga_sewa_diskon'] ?? '',
        longRent: json['lama_sewa'] ?? '',
        statusDiscount: json['status_diskon'] ?? 'N');
  }

  @override
  List<Object?> get props => [
        idBook,
        title,
        writer,
        cover,
        isbn,
        edition,
        categoryName,
        publicationYear,
        canPackage,
        canRent,
        canBuy,
        rentalPrice,
        price,
        rentalPrice,
        priceFormat,
        discountBuy,
        discountPriceFormatBuy,
        discountPriceFomatRent,
        discountPriceBuy,
        discountPriceRent,
        statusDiscount
      ];
}
