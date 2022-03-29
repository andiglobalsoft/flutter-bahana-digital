part of '../models.dart';

class BookshelfModel extends Equatable {
  final String idBook;
  final String title;
  final String writer;
  final String cover;
  final String category;
  final String urlPdf;
  const BookshelfModel(
      {required this.idBook,
      required this.title,
      required this.writer,
      required this.cover,
      required this.category,
      required this.urlPdf});

  factory BookshelfModel.fromJson(Map<String, dynamic> json) {
    return BookshelfModel(
        idBook: json['id_buku'] ?? '',
        title: json['judul'] ?? '',
        writer: json['penulis'] ?? '',
        cover: json['cover'] ?? '',
        category: json['nama_kategori'] ?? '',
        urlPdf: json['pdf_url'] ?? '');
  }

  @override
  List<Object?> get props => [idBook, title, writer, cover, category, urlPdf];
}
