part of '../models.dart';

// class PaymentMethodModel1 extends Equatable {
//   final String idMethod;
//   final String name;
//   final String description;
//   final String icon;
//   final String accountNumber;
//   const PaymentMethodModel1(
//       {required this.idMethod,
//       required this.name,
//       required this.description,
//       required this.icon,
//       required this.accountNumber});

//   factory PaymentMethodModel1.fromJson(Map<String, dynamic> json) {
//     return PaymentMethodModel1(
//         idMethod: json['id_metode'],
//         name: json['nama_metode'],
//         description: json['deskripsi'],
//         icon: json['icon'],
//         accountNumber: json['no_rekening']);
//   }

//   @override
//   List<Object?> get props => [idMethod, name, description, icon, accountNumber];
// }

class PaymentMethodModel extends Equatable {
  const PaymentMethodModel({
    required this.dataTransaksi,
    required this.paymentresult,
  });

  final DataTransaksi dataTransaksi;
  final List<PaymentResult> paymentresult;

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        dataTransaksi: DataTransaksi.fromJson(json["data_transaksi"]),
        paymentresult: List<PaymentResult>.from(
            json["result"].map((x) => PaymentResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data_transaksi": dataTransaksi.toJson(),
        "result": List<dynamic>.from(paymentresult.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => throw UnimplementedError();
}

class DataTransaksi extends Equatable {
  const DataTransaksi({
    required this.nomorTelp,
    required this.deskripsi,
    required this.noInvoice,
    required this.total,
  });

  final String nomorTelp;
  final String deskripsi;
  final String noInvoice;
  final String total;

  factory DataTransaksi.fromJson(Map<String, dynamic> json) => DataTransaksi(
        nomorTelp: json["nomor_telp"],
        deskripsi: json["deskripsi"],
        noInvoice: json["no_invoice"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "nomor_telp": nomorTelp,
        "deskripsi": deskripsi,
        "no_invoice": noInvoice,
        "total": total,
      };

  @override
  List<Object?> get props => throw UnimplementedError();
}

class PaymentResult extends Equatable {
  const PaymentResult({
    required this.idPayment,
    required this.iconPayment,
    required this.metodePembayaran,
    required this.nomorPayment,
    required this.penerimaPayment,
  });

  final String idPayment;
  final String iconPayment;
  final String metodePembayaran;
  final String nomorPayment;
  final String penerimaPayment;

  factory PaymentResult.fromJson(Map<String, dynamic> json) => PaymentResult(
        idPayment: json["id_payment"],
        iconPayment: json["icon_payment"],
        metodePembayaran: json["metode_pembayaran"],
        nomorPayment: json["nomor_payment"],
        penerimaPayment: json["penerima_payment"],
      );

  Map<String, dynamic> toJson() => {
        "id_payment": idPayment,
        "icon_payment": iconPayment,
        "metode_pembayaran": metodePembayaran,
        "nomor_payment": nomorPayment,
        "penerima_payment": penerimaPayment,
      };

  @override
  List<Object?> get props => throw UnimplementedError();
}
