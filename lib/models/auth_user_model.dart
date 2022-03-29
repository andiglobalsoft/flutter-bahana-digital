part of 'models.dart';

class UserModel extends Equatable {
  final String idUser;
  final String name;
  final String email;
  final String noPhone;
  final String baReferal;
  final String statusReferal;
  final String imageProfile;
  const UserModel(
      {required this.idUser,
      required this.name,
      required this.email,
      required this.noPhone,
      required this.baReferal,
      required this.statusReferal,
      required this.imageProfile});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        idUser: json['id_user'] ?? '',
        name: json['nama_user'] ?? '',
        email: json['email_user'] ?? '',
        noPhone: json['telepon_user'] ?? '',
        baReferal: json['ba_referal'] ?? '',
        statusReferal: json['status_referal'] ?? '',
        imageProfile: json['foto_user'] ?? '');
  }

  @override
  List<Object?> get props =>
      [idUser, name, email, noPhone, baReferal, statusReferal, imageProfile];
}
