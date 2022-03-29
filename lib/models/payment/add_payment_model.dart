part of '../models.dart';

class AddPaymentModel extends Equatable {
  final dynamic token;
  final dynamic redirectUrl;
  const AddPaymentModel({required this.token, required this.redirectUrl});

  factory AddPaymentModel.fromJson(Map<String, dynamic> json) {
    return AddPaymentModel(
        token: json['token'] ?? '', redirectUrl: json['redirect_url'] ?? '');
  }

  @override
  List<Object?> get props => [token, redirectUrl];
}
