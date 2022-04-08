part of '../pages.dart';

class PaymentEventPage extends StatefulWidget {
  final String idTransaksi;
  final String noInvoice;
  const PaymentEventPage(
      {required this.idTransaksi, required this.noInvoice, Key? key})
      : super(key: key);

  @override
  State<PaymentEventPage> createState() => _PaymentEventPageState();
}

class _PaymentEventPageState extends State<PaymentEventPage> {
  int? statusPayment = 1;
  String? iconSelectPayment;
  String? idPayment = '0';
  String? noPayment;
  String? namePayment;
  String? noCS;
  String? titleSelectPayment;
  String? descriptionSelectPayment;
  bool isSelectPayment = true;
  bool isLoading = false;
  int? _value = -1;

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Konfirmasi'),
            content: const Text(
                'Apakah mau keluar dari menu transaksi?\nTransaksi anda sudah tersimpan,\ncek di menu Transaksi.'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  navigationPop(context);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
          body: Stack(
        children: [
          //Background
          Container(color: mainColor),
          SafeArea(child: Container(color: backgroundPhoneColor)),

          SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: FutureBuilder(
              future: EventService.getListEventTransaksi(
                  'listevent_transaction',
                  idTransaksi: widget.idTransaksi),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<TransactionEventModel> transactionEventModel =
                      snapshot.data as List<TransactionEventModel>;
                  return ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 20, left: 16, right: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3)),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(top: 116),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(transactionEventModel[0].namaPromo,
                                        style: textBold),
                                    Text(
                                        transactionEventModel[0]
                                            .tanggalAcaraEvent,
                                        style: TextStyle(
                                            fontFamily: textMain,
                                            fontStyle: FontStyle.italic,
                                            color: grayColor)),
                                    Text(
                                        transactionEventModel[0].deskripsiPromo,
                                        style: TextStyle(fontFamily: textMain)),
                                    Text(transactionEventModel[0].hargaFormat,
                                        style: textBold.copyWith(
                                            color: mainColor)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 130,
                              decoration: BoxDecoration(
                                color: grayColor,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        transactionEventModel[0].filePromo),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Pilih Metode Pembayaran : ',
                                    style: TextStyle(
                                        fontFamily: textMain,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: -1,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value as int?;
                                    });
                                  },
                                ),
                                const Text(
                                  'Pembayaran Otomatis',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            FutureBuilder(
                              future: PaymentMethodService.getPaymentMethod(
                                  noInvoice: widget.noInvoice,
                                  total: widget.idTransaksi),
                              builder: ((context, snapshot) {
                                if (snapshot.hasData) {
                                  PaymentMethodModel paymentMethodModel =
                                      snapshot.data as PaymentMethodModel;
                                  return ListView.builder(
                                    itemCount:
                                        paymentMethodModel.paymentresult.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Radio(
                                            value: index,
                                            groupValue: _value,
                                            onChanged: (value) {
                                              idPayment = paymentMethodModel
                                                  .paymentresult[index]
                                                  .idPayment;
                                              statusPayment = 2;

                                              iconSelectPayment =
                                                  paymentMethodModel
                                                      .paymentresult[index]
                                                      .iconPayment;
                                              titleSelectPayment =
                                                  paymentMethodModel
                                                      .paymentresult[index]
                                                      .metodePembayaran;
                                              descriptionSelectPayment =
                                                  paymentMethodModel
                                                      .dataTransaksi.deskripsi;
                                              namePayment = paymentMethodModel
                                                  .paymentresult[index]
                                                  .penerimaPayment;
                                              noPayment = paymentMethodModel
                                                  .paymentresult[index]
                                                  .nomorPayment;
                                              isSelectPayment = true;
                                              noCS = paymentMethodModel
                                                  .dataTransaksi.nomorTelp;
                                              setState(() {
                                                _value = value as int?;
                                              });
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              idPayment = paymentMethodModel
                                                  .paymentresult[index]
                                                  .idPayment;
                                              statusPayment = 2;
                                              iconSelectPayment =
                                                  paymentMethodModel
                                                      .paymentresult[index]
                                                      .iconPayment;
                                              titleSelectPayment =
                                                  paymentMethodModel
                                                      .paymentresult[index]
                                                      .metodePembayaran;
                                              descriptionSelectPayment =
                                                  paymentMethodModel
                                                      .dataTransaksi.deskripsi;
                                              namePayment = paymentMethodModel
                                                  .paymentresult[index]
                                                  .penerimaPayment;
                                              noPayment = paymentMethodModel
                                                  .paymentresult[index]
                                                  .nomorPayment;
                                              isSelectPayment = true;
                                              noCS = paymentMethodModel
                                                  .dataTransaksi.nomorTelp;
                                              _value = index;
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 50,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 34,
                                                        width: 34,
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    paymentMethodModel
                                                                        .paymentresult[
                                                                            index]
                                                                        .iconPayment))),
                                                      ),
                                                      Text(
                                                          paymentMethodModel
                                                              .paymentresult[
                                                                  index]
                                                              .metodePembayaran,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  textMain)),
                                                    ],
                                                  ),
                                                  const Divider(thickness: 1)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                            ),
                            (_value != -1)
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Deskripsi',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text('Nomor Transfer ' + noPayment!),
                                      const SizedBox(height: 2),
                                      Text('An. ' + namePayment!),
                                      const SizedBox(height: 8),
                                      Text(descriptionSelectPayment ?? ''),
                                      const SizedBox(height: 2),
                                      Text(noCS!),
                                    ],
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Spacer(flex: 2),
                            Text('Total Harga : ',
                                style: TextStyle(
                                    fontFamily: textMain,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                NumberFormat.currency(
                                        locale: "id_ID",
                                        decimalDigits: 0,
                                        symbol: "Rp.")
                                    .format(int.parse(
                                        transactionEventModel[0].harga)),
                                style: TextStyle(
                                    fontFamily: textMain,
                                    fontWeight: FontWeight.w900,
                                    color: mainColor)),
                            const Spacer(flex: 8),
                            ElevatedButton(
                                onPressed: () async {
                                  if (isSelectPayment) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    BaTransactionResult baTransactionResult =
                                        await TransactionService.baTransaction(
                                            'update_payment_manual',
                                            paymentType: idPayment,
                                            noInvoice: widget.idTransaksi,
                                            totalPay:
                                                transactionEventModel[0].harga,
                                            statusPayment:
                                                statusPayment.toString());

                                    if (_value == -1) {
                                      AddPaymentModel addPaymentModel =
                                          await AddPaymentService
                                              .addPaymentBuyNow(
                                                  idTransaction:
                                                      widget.idTransaksi,
                                                  price:
                                                      transactionEventModel[0]
                                                          .harga);
                                      navigation(context,
                                          fromEvent: const GoToMainPage(
                                              bottomNavBarIndex: 2),
                                          toEvent: GoToAddPaymentPage(
                                              addPaymentModel: addPaymentModel,
                                              isEvent: true));

                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else {
                                      String url =
                                          "https://wa.me/${baTransactionResult.noTelepon}/?text=${Uri.parse(baTransactionResult.message.toString())}";
                                      if (await canLaunch(url)) {
                                        launch(url);
                                        navigation(context,
                                            fromEvent: const GoToMainPage(
                                                bottomNavBarIndex: 2),
                                            toEvent: GoToEventPage());
                                      } else {
                                        log("Can't open whatsapp");
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  } else {}
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      (isSelectPayment)
                                          ? mainColor
                                          : grayColor),
                                ),
                                child: Text(
                                    (_value == -1) ? 'Bayar' : 'Konfirmasi')),
                            const Spacer(flex: 2)
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          )),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),

          //Header
          SafeArea(
            child: HeaderBackArrowandTitlePage('Pembayaran', onTap: () {
              showExitPopup();
            }),
          )
        ],
      )),
    );
  }
}
