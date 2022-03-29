part of '../models.dart';

class CartCheckout extends Equatable {
  final int totalItem;
  final int totalPayment;
  final String totalPaymentFormat;
  const CartCheckout(
      {required this.totalItem,
      required this.totalPayment,
      required this.totalPaymentFormat});

  factory CartCheckout.fromJson(Map<String, dynamic> json) {
    return CartCheckout(
        totalItem: json['jumlah_item'],
        totalPayment: json['total_pembayaran'],
        totalPaymentFormat: json['total_pembayaran_format']);
  }
  @override
  List<Object?> get props => [totalItem, totalPayment, totalPaymentFormat];
}
