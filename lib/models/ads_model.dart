part of 'models.dart';

class AdsModel extends Equatable {
  const AdsModel({
    required this.idIklan,
    required this.namaIklan,
    required this.fileIklan,
    required this.linkIklan,
    required this.statusIklan,
    required this.tglPostingIklan,
    required this.tglExpIklan,
  });

  final String idIklan;
  final String namaIklan;
  final String fileIklan;
  final String linkIklan;
  final String statusIklan;
  final String tglPostingIklan;
  final String tglExpIklan;

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        idIklan: json["id_iklan"],
        namaIklan: json["nama_iklan"],
        fileIklan: json["file_iklan"],
        linkIklan: json["link_iklan"],
        statusIklan: json["status_iklan"] ?? json["deskripsi_iklan"],
        tglPostingIklan: json["tgl_posting_iklan"],
        tglExpIklan: json["tgl_exp_iklan"],
      );

  @override
  List<Object?> get props =>
      [idIklan, namaIklan, fileIklan, linkIklan, statusIklan];
}
