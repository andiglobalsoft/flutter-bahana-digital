part of '../models.dart';

class ListCategoryBahanaflixModel extends Equatable {
  final String idCategory;
  final String name;
  final String countBook;
  final String icon;
  const ListCategoryBahanaflixModel(
      {required this.idCategory,
      required this.name,
      required this.countBook,
      required this.icon});

  factory ListCategoryBahanaflixModel.fromJson(Map<String, dynamic> json) {
    return ListCategoryBahanaflixModel(
        idCategory: json['id_kategori'] ?? '',
        name: json['nama_kategori'] ?? '',
        countBook: json['jumlah_buku'] ?? '',
        icon: json['icon'] ?? '');
  }

  @override
  List<Object?> get props => [idCategory, name, countBook, icon];
}
