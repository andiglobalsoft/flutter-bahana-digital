part of '../pages.dart';

class PaymentPage extends StatefulWidget {
  final String idTransaction;
  final String noInvoice;
  final String totalPrice;
  const PaymentPage(
      {required this.idTransaction,
      required this.noInvoice,
      required this.totalPrice,
      Key? key})
      : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
        body: Stack(children: [
          //Background
          Container(color: mainColor),
          SafeArea(child: Container(color: backgroundPhoneColor)),

          SafeArea(
            child: SizedBox(
              child: Stack(
                children: [
                  ListView(
                    children: [
                      FutureBuilder(
                        future: TransactionService.baTransaction(
                            'listbarang_transaction',
                            idBook: '',
                            status: '',
                            idUser: '',
                            totalPay: '',
                            discount: '',
                            discountPrice: '',
                            normalPrice: '',
                            idTransaction: widget.idTransaction),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            BaTransactionResult baTransactionResult =
                                snapshot.data as BaTransactionResult;

                            List<DetailTransactionProductModel>
                                detailTransactionProductModel =
                                baTransactionResult
                                        .detailTransactionProductModel
                                    as List<DetailTransactionProductModel>;

                            return Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Container(
                                height: 120.0 *
                                    (detailTransactionProductModel.length),
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(16),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: whiteColor),
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        detailTransactionProductModel.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          _listProduct(context,
                                              title: detailTransactionProductModel[
                                                      index]
                                                  .title,
                                              nameCategory:
                                                  detailTransactionProductModel[
                                                          index]
                                                      .nameCategory,
                                              writer:
                                                  detailTransactionProductModel[
                                                          index]
                                                      .writer,
                                              discount:
                                                  detailTransactionProductModel[
                                                          index]
                                                      .discount
                                                      .toString(),
                                              priceFormat:
                                                  detailTransactionProductModel[
                                                          index]
                                                      .priceFormat,
                                              discountPriceFormat:
                                                  detailTransactionProductModel[
                                                          index]
                                                      .discountPriceFormat,
                                              cover:
                                                  detailTransactionProductModel[
                                                          index]
                                                      .cover),
                                          const Divider(thickness: 1),
                                        ],
                                      );
                                    }),
                              ),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
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
                                      statusPayment = 1;
                                      isSelectPayment = true;
                                      idPayment = '0';

                                      _value = value as int?;
                                      iconSelectPayment = null;
                                      titleSelectPayment = null;
                                      descriptionSelectPayment = null;
                                      namePayment = null;
                                      noPayment = null;
                                      noCS = null;
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
                            // Row(
                            //   children: [
                            //     Radio(
                            //       value: 2,
                            //       groupValue: statusPayment,
                            //       onChanged: (value) {
                            //         setState(() {
                            //           statusPayment = value as int?;
                            //         });
                            //       },
                            //     ),
                            //     const Text(
                            //       "Pembayaran Manual",
                            //       style: TextStyle(
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w500,
                            //           color: Colors.black),
                            //     ),
                            //     // (statusPayment == 2)
                            //     //     ? TextButton(
                            //     //         onPressed: () {
                            //     //           showModalBottomSheet(
                            //     //               context: context,
                            //     //               backgroundColor:
                            //     //                   Colors.transparent,
                            //     //               isScrollControlled: true,
                            //     //               builder: (context) =>
                            //     //                   _buildSheet());
                            //     //         },
                            //     //         child: Text('Pilih',
                            //     //             style: TextStyle(
                            //     //                 fontFamily: textMain,
                            //     //                 fontWeight: FontWeight.bold,
                            //     //                 color: mainColor)))
                            //     //     : const SizedBox()
                            //   ],
                            // ),
                            FutureBuilder(
                              future: PaymentMethodService.getPaymentMethod(
                                  noInvoice: widget.noInvoice,
                                  total: widget.idTransaction),
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
                                                      // const Spacer(
                                                      //     flex: 1),
                                                      // const Icon(Icons
                                                      //     .arrow_forward_ios_rounded),
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

                              //(idPayment != '0')
                              //     ? Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Row(
                              //             children: [
                              //               Container(
                              //                   height: 34,
                              //                   width: 34,
                              //                   margin: const EdgeInsets.only(
                              //                       right: 10),
                              //                   decoration: BoxDecoration(
                              //                       borderRadius:
                              //                           BorderRadius.circular(
                              //                               4),
                              //                       image: DecorationImage(
                              //                         image: (statusPayment ==
                              //                                 1)
                              //                             ? AssetImage(
                              //                                 iconSelectPayment!)
                              //                             : NetworkImage(
                              //                                     iconSelectPayment!)
                              //                                 as ImageProvider,
                              //                       ))),
                              //               Text(titleSelectPayment ?? '',
                              //                   style: TextStyle(
                              //                       fontFamily: textMain,
                              //                       fontWeight:
                              //                           FontWeight.bold)),
                              //               const Spacer(),
                              //               Text(namePayment ?? '',
                              //                   style: TextStyle(
                              //                     fontFamily: textMain,
                              //                   )),
                              //             ],
                              //           ),
                              //           const SizedBox(height: 4),
                              //           Text(noPayment ?? ''),
                              //           Text(descriptionSelectPayment ?? '')

                              //         ],
                              //       )
                              //     : const SizedBox()
                            ),
                            // : const SizedBox(),
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
                                    .format(int.parse(widget.totalPrice)),
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
                                            noInvoice: widget.idTransaction,
                                            totalPay: widget.totalPrice,
                                            statusPayment:
                                                statusPayment.toString());

                                    if (_value == -1) {
                                      AddPaymentModel addPaymentModel =
                                          await AddPaymentService
                                              .addPaymentBuyNow(
                                                  idTransaction:
                                                      widget.idTransaction,
                                                  price: widget.totalPrice);
                                      navigation(context,
                                          fromEvent: const GoToMainPage(
                                              bottomNavBarIndex: 2),
                                          toEvent: GoToAddPaymentPage(
                                              addPaymentModel:
                                                  addPaymentModel));
                                      // if (await canLaunch(
                                      //     addPaymentModel.redirectUrl)) {
                                      //   launch(
                                      //     addPaymentModel.redirectUrl,
                                      //   );
                                      //   navigation(context,
                                      //       fromEvent: const GoToMainPage(
                                      //           bottomNavBarIndex: 2),
                                      //       toEvent: GoToTransactionPage());
                                      // } else {
                                      //   log("Can't open ");
                                      // }
                                      setState(() {
                                        isLoading = false;
                                      });
                                      //  navigation(context,
                                      //     fromEvent: GoToPaymentPage(
                                      //         noInvoice: widget.noInvoice,
                                      //         idTransaction:
                                      //             widget.idTransaction,
                                      //         totalPrice:
                                      //             widget.totalPrice.toString()),
                                      //     toEvent: GoToAddPaymentPage(
                                      //         addPaymentModel:
                                      //             addPaymentModel));
                                    } else {
                                      String url =
                                          "https://wa.me/${baTransactionResult.noTelepon}/?text=${Uri.parse(baTransactionResult.message.toString())}";
                                      if (await canLaunch(url)) {
                                        launch(url);
                                        navigation(context,
                                            fromEvent: const GoToMainPage(
                                                bottomNavBarIndex: 2),
                                            toEvent: GoToTransactionPage());
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
                  ),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                ],
              ),
            ),
          ),

          SafeArea(
            child: HeaderBackArrowandTitlePage('Pembayaran', onTap: () {
              showExitPopup();
            }),
          )
        ]),
      ),
    );
  }

  // Widget _buildSheet() => DraggableScrollableSheet(
  //     initialChildSize: 0.9,
  //     minChildSize: 0.5,
  //     maxChildSize: 0.9,
  //     builder: (_, controller) => Container(
  //           decoration: BoxDecoration(
  //               color: whiteColor,
  //               borderRadius:
  //                   const BorderRadius.vertical(top: Radius.circular(20))),
  //           child: ListView(
  //             controller: controller,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(16.0),
  //                 child: Text('Pili Metode Pembayaran',
  //                     style: TextStyle(
  //                         fontFamily: textMain,
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 16)),
  //               ),
  //               FutureBuilder(
  //                   future: PaymentMethodService.getPaymentMethod(
  //                       noInvoice: widget.noInvoice,
  //                       total: widget.idTransaction),
  //                   builder: ((context, snapshot) {
  //                     if (snapshot.hasData) {
  //                       PaymentMethodModel paymentMethodModel =
  //                           snapshot.data as PaymentMethodModel;
  //                       return ListView.builder(
  //                         itemCount: paymentMethodModel.paymentresult.length,
  //                         physics: const NeverScrollableScrollPhysics(),
  //                         shrinkWrap: true,
  //                         itemBuilder: (context, index) {
  //                           return GestureDetector(
  //                             onTap: () {
  //                               idPayment = paymentMethodModel
  //                                   .paymentresult[index].idPayment;

  //                               iconSelectPayment = paymentMethodModel
  //                                   .paymentresult[index].iconPayment;
  //                               titleSelectPayment = paymentMethodModel
  //                                   .paymentresult[index].metodePembayaran;
  //                               descriptionSelectPayment =
  //                                   paymentMethodModel.dataTransaksi.deskripsi;
  //                               namePayment = paymentMethodModel
  //                                   .paymentresult[index].penerimaPayment;
  //                               noPayment = paymentMethodModel
  //                                   .paymentresult[index].nomorPayment;
  //                               isSelectPayment = true;
  //                               noCS =
  //                                   paymentMethodModel.dataTransaksi.nomorTelp;
  //                               setState(() {});
  //                               Navigator.pop(context);
  //                             },
  //                             child: Container(
  //                               height: 50,
  //                               width: MediaQuery.of(context).size.width,
  //                               padding:
  //                                   const EdgeInsets.symmetric(horizontal: 16),
  //                               child: Column(
  //                                 children: [
  //                                   Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       Container(
  //                                         height: 34,
  //                                         width: 34,
  //                                         margin:
  //                                             const EdgeInsets.only(right: 10),
  //                                         decoration: BoxDecoration(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(8),
  //                                             image: DecorationImage(
  //                                                 image: NetworkImage(
  //                                                     paymentMethodModel
  //                                                         .paymentresult[index]
  //                                                         .iconPayment))),
  //                                       ),
  //                                       Text(
  //                                           paymentMethodModel
  //                                               .paymentresult[index]
  //                                               .metodePembayaran,
  //                                           style: TextStyle(
  //                                               fontFamily: textMain)),
  //                                       const Spacer(flex: 1),
  //                                       const Icon(
  //                                           Icons.arrow_forward_ios_rounded),
  //                                     ],
  //                                   ),
  //                                   const Divider(thickness: 1)
  //                                 ],
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       );
  //                     } else {
  //                       return const Center(child: CircularProgressIndicator());
  //                     }
  //                   }))
  //             ],
  //           ),
  //         ));

  Widget _listProduct(BuildContext context,
      {required String title,
      required String nameCategory,
      required String writer,
      required String discount,
      required String priceFormat,
      required String discountPriceFormat,
      required String cover}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
            imageUrl: cover,
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 100,
                width: 76,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: grayColor,
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              );
            },
            placeholder: (context, img) {
              return Container(
                height: 100,
                width: 76,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: grayColor,
                    borderRadius: BorderRadius.circular(4),
                    image: const DecorationImage(
                        image: AssetImage(
                            'assets/images/PlaceholderImageProduct.jpeg'),
                        fit: BoxFit.cover)),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                height: 100,
                width: 76,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    color: grayColor,
                    borderRadius: BorderRadius.circular(4),
                    image: const DecorationImage(
                        image:
                            AssetImage('assets/images/ErrorImageProduct.png'),
                        fit: BoxFit.cover)),
              );
            }),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - (36 * 2 + (86)),
              child: Text(title.replaceAll('\n', '') + ' | ' + nameCategory,
                  style: TextStyle(fontFamily: textMain)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - (36 * 2 + (86)),
              child: Text(writer,
                  style: TextStyle(fontFamily: textMain, color: grayColor)),
            ),
            (discount != '0')
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: redColor,
                          ),
                          child: Text(
                            discount.toString() + '%',
                            style: TextStyle(
                              fontFamily: textMain,
                              color: whiteColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      const SizedBox(width: 6),
                      Text(
                        priceFormat,
                        style: TextStyle(
                            fontFamily: textMain,
                            color: grayColor,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  )
                : const SizedBox(),
            Text(
              (discount != '0') ? discountPriceFormat : priceFormat,
              style: textPrice,
            ),
          ],
        )
      ],
    );
  }
}
