part of '../pages.dart';

class DetailTransactionPage extends StatefulWidget {
  final String idTransaction;
  const DetailTransactionPage({required this.idTransaction, Key? key})
      : super(key: key);

  @override
  State<DetailTransactionPage> createState() => _DetailTransactionPageState();
}

class _DetailTransactionPageState extends State<DetailTransactionPage> {
  bool isLoading = true;
  // final _key = UniqueKey();

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Pembayaran'),
            content:
                const Text('Apa anda yakin untuk keluar dari from pembayaran'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                //return true when click on "Yes"
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  void initState() {
    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Scaffold(
          body: Stack(
        children: [
          //Background
          Container(color: mainColor),
          SafeArea(child: Container(color: backgroundPhoneColor)),

          //Content Transaction
          SafeArea(
            child: FutureBuilder(
              future: TransactionService.baTransaction('listtransaction_detail',
                  idTransaction: widget.idTransaction),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  BaTransactionResult baTransactionResult =
                      snapshot.data as BaTransactionResult;

                  DetailTransactionModel detailTransactionModel =
                      baTransactionResult.detailTransactionModel
                          as DetailTransactionModel;

                  return ListView(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 36,
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, top: 100),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Transaksi',
                                    style: TextStyle(
                                        fontFamily: textMain,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(flex: 1),
                                Text(
                                    detailTransactionModel
                                        .dataTransactionModel.statusDescription,
                                    style: TextStyle(
                                        fontFamily: textMain,
                                        color: {'7', '3'}.contains(
                                                detailTransactionModel
                                                    .dataTransactionModel
                                                    .statusTransaksi)
                                            ? mainColor
                                            : {'9'}.contains(
                                                    detailTransactionModel
                                                        .dataTransactionModel
                                                        .statusTransaksi)
                                                ? redColor
                                                : grayColor,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const Divider(thickness: 1),
                            Row(
                              children: [
                                Text('Nomor Invoice', style: textBold),
                                const SizedBox(width: 38),
                                Text(
                                    detailTransactionModel
                                        .dataTransactionModel.invoice,
                                    style: TextStyle(fontFamily: textMain)),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Tanggal Transaksi', style: textBold),
                                const SizedBox(width: 16),
                                Text(
                                    detailTransactionModel
                                        .dataTransactionModel.purchaseDate,
                                    style: TextStyle(
                                        fontFamily: textMain, fontSize: 12)),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 36,
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Detail Produk',
                                style: TextStyle(
                                    fontFamily: textMain,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            const Divider(thickness: 1),
                            ListView.builder(
                              itemCount:
                                  detailTransactionModel.resultModel.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _imageProduct(detailTransactionModel
                                        .resultModel[index].cover),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                (72 + 58 + 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              detailTransactionModel
                                                  .resultModel[index].title,
                                              style: textBold,
                                            ),
                                            Text(
                                                detailTransactionModel
                                                    .resultModel[index].writer,
                                                style: TextStyle(
                                                    fontFamily: textMain)),
                                            Text(
                                                (detailTransactionModel
                                                            .resultModel[index]
                                                            .totalDiskon ==
                                                        '0')
                                                    ? detailTransactionModel
                                                        .resultModel[index]
                                                        .priceFormat
                                                    : detailTransactionModel
                                                        .resultModel[index]
                                                        .discountPriceFormat,
                                                style: TextStyle(
                                                    fontFamily: textMain)),
                                          ],
                                        ))
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            const Divider(thickness: 1),
                            Row(
                              children: [
                                Text('Total Harga : ',
                                    style: TextStyle(fontFamily: textMain)),
                                Text(
                                    detailTransactionModel.dataTransactionModel
                                        .totalPaymentFormat,
                                    style: textPrice)
                              ],
                            )
                          ],
                        ),
                      ),
                      (detailTransactionModel
                                  .dataTransactionModel.statusPayment ==
                              '0')
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 26),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    navigation(context,
                                        fromEvent: GoToDetailTransactionPage(
                                            idTransaction:
                                                widget.idTransaction),
                                        toEvent: GoToPaymentPage(
                                            idTransaction: widget.idTransaction,
                                            noInvoice: detailTransactionModel
                                                .dataTransactionModel.invoice,
                                            totalPrice: detailTransactionModel
                                                .dataTransactionModel
                                                .totalPaymentFormat
                                                .replaceAll(
                                                    RegExp('[^0-9]'), '')));
                                  },
                                  child: const Text('Lanjutkan Pembayaran')),
                            )
                          : (detailTransactionModel
                                      .dataTransactionModel.statusPayment ==
                                  '1')
                              ? ({'1', '2'}.contains(detailTransactionModel
                                      .dataTransactionModel.statusTransaksi))
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 26),
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            String url = detailTransactionModel
                                                .dataTransactionModel
                                                .urlPayment;

                                            navigation(context,
                                                fromEvent:
                                                    GoToDetailTransactionPage(
                                                        idTransaction: widget
                                                            .idTransaction),
                                                toEvent:
                                                    GoToTransactionMidtransPage(
                                                        url: url));

                                            // await canLaunch(url)
                                            //     ? launch(url)
                                            //     : log("Can't");

                                            // return await showDialog(
                                            //     context: context,
                                            //     builder: (_) {
                                            //       return WillPopScope(
                                            //         onWillPop: showExitPopup,
                                            //         child: SizedBox(
                                            //           height:
                                            //               MediaQuery.of(context)
                                            //                   .size
                                            //                   .height,
                                            //           width:
                                            //               MediaQuery.of(context)
                                            //                   .size
                                            //                   .width,
                                            //           // child: WebView(
                                            //           //   key: _key,
                                            //           //   // onWebViewCreated: (WebViewController
                                            //           //   //     webViewController) {
                                            //           //   //   _controller.complete(webViewController);
                                            //           //   // },
                                            //           //   initialUrl:
                                            //           //       detailTransactionModel
                                            //           //           .dataTransactionModel
                                            //           //           .urlPayment,
                                            //           //   javascriptMode: JavascriptMode
                                            //           //       .unrestricted,
                                            //           //   onPageFinished: (finish) {
                                            //           //     setState(() {
                                            //           //       isLoading = false;
                                            //           //     });
                                            //           //   },
                                            //           // )
                                            //           child: InAppWebView(
                                            //             initialUrlRequest:
                                            //                 URLRequest(
                                            //                     url: Uri.parse(
                                            //               detailTransactionModel
                                            //                   .dataTransactionModel
                                            //                   .urlPayment,
                                            //             )),
                                            //           ),
                                            //         ),
                                            //       );
                                            //     });
                                          },
                                          child: const Text(
                                              'Lanjutkan Pembayaran')),
                                    )
                                  : const SizedBox()
                              : Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          36,
                                      margin: const EdgeInsets.all(16),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: whiteColor),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Info Pembayaran',
                                              style: TextStyle(
                                                  fontFamily: textMain,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          const Divider(thickness: 1),
                                          Row(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            baTransactionResult
                                                                .detailTransactionModel!
                                                                .dataTransactionModel
                                                                .iconPayment))),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(baTransactionResult
                                                  .detailTransactionModel!
                                                  .dataTransactionModel
                                                  .paymentMethod),
                                              const Spacer(),
                                              Text(baTransactionResult
                                                  .detailTransactionModel!
                                                  .dataTransactionModel
                                                  .nameCS)
                                            ],
                                          ),
                                          Text('Nomer Rekening : ' +
                                              baTransactionResult
                                                  .detailTransactionModel!
                                                  .dataTransactionModel
                                                  .noPayment)
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          String url =
                                              "https://wa.me/${baTransactionResult.detailTransactionModel!.dataTransactionModel.noCS}/?text=${Uri.parse(baTransactionResult.detailTransactionModel!.dataTransactionModel.message.toString())}";
                                          await canLaunch(url)
                                              ? launch(url)
                                              : log("Can't open whatsapp");
                                        },
                                        child:
                                            const Text('Lakukan Konfirmasi')),
                                  ],
                                ),
                      Container(
                        width: MediaQuery.of(context).size.width - 36,
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: whiteColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rincian Pembayaran',
                                style: TextStyle(
                                    fontFamily: textMain,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            const Divider(thickness: 1),
                            Row(
                              children: [
                                Text('Total Akhir', style: textBold),
                                const SizedBox(width: 80),
                                Text(
                                  detailTransactionModel
                                      .dataTransactionModel.totalPaymentFormat,
                                  style: TextStyle(fontFamily: textMain),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          //Header
          SafeArea(
            child: HeaderBackArrowandTitlePage('Detail Transaksi', onTap: () {
              navigationPop(context);
            }),
          )
        ],
      )),
    );
  }

  _imageProduct(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: 90,
          width: 58,
          margin: const EdgeInsets.only(right: 10, bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ]),
        );
      },
      placeholder: (context, img) {
        return Container(
          height: 90,
          width: 58,
          margin: const EdgeInsets.only(right: 10, bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image:
                      AssetImage('assets/images/PlaceholderImageProduct.jpeg'),
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ]),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          height: 90,
          width: 58,
          margin: const EdgeInsets.only(right: 10, bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: AssetImage('assets/images/ErrorImageProduct.png'),
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ]),
        );
      },
    );
  }
}
