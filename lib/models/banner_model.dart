part of 'models.dart';

class BannerModel extends Equatable {
  final String idBanner;
  final String name;
  final String image;
  final String link;
  const BannerModel(
      {required this.idBanner,
      required this.name,
      required this.image,
      required this.link});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
        idBanner: json['id_promo'] ?? '',
        name: json['nama_promo'] ?? '',
        image: json['file_promo'] ?? '',
        link: json['link_promo'] ?? '');
  }

  @override
  List<Object?> get props => [idBanner, name, image, link];
}
