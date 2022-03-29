part of '../pages.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int i = 0;
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    context.read<ItemCartBloc>().add(FetchDataItemCartEvent(idUser: idUser));

    context
        .read<CountCartBloc>()
        .add(FetchDataCountCartItemEvent(idUser: idUser));
    if (i < 2) {
      Future.delayed(const Duration(seconds: 5), () {
        context
            .read<ItemCartBloc>()
            .add(FetchDataItemCartEvent(idUser: idUser));

        context
            .read<CountCartBloc>()
            .add(FetchDataCountCartItemEvent(idUser: idUser));
        i++;
        // setState(() {});
      });
      Future.delayed(const Duration(seconds: 5), () {
        context
            .read<CountCartBloc>()
            .add(FetchDataCountCartItemEvent(idUser: idUser));

        setState(() {});
      });
    }

    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Scaffold(
        body: Stack(children: [
          //Background
          Container(color: mainColor),
          SafeArea(child: Container(color: backgroundPhoneColor)),

          SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(const Duration(seconds: 1), () {
                    context
                        .read<ItemCartBloc>()
                        .add(FetchDataItemCartEvent(idUser: idUser));
                    context
                        .read<CountCartBloc>()
                        .add(FetchDataCountCartItemEvent(idUser: idUser));
                  });
                },
                child: BlocBuilder<ItemCartBloc, ItemCartState>(
                    builder: ((context, state) {
                  if (state is ItemCartLoaded) {
                    BaCardResult baCardResultl = state.baCardResult;
                    if (baCardResultl.statusCode == 200) {
                      List<ListEbookModel> listEbookModel =
                          baCardResultl.listEBookInCard;

                      return ListView.builder(
                        itemCount: listEbookModel.length,
                        padding: const EdgeInsets.symmetric(vertical: 80),
                        itemBuilder: (context, index) {
                          return CardProductCart(
                              idBook: listEbookModel[index].idBook,
                              title: listEbookModel[index].title,
                              cover: listEbookModel[index].cover,
                              totalDiscount:
                                  listEbookModel[index].discountBuy.toString(),
                              priceFormat: listEbookModel[index].priceFormat,
                              discountPriceFormat:
                                  listEbookModel[index].discountPriceFormatBuy);
                        },
                      );
                    } else {
                      return Center(
                          child: Lottie.network(
                              'https://assets7.lottiefiles.com/packages/lf20_oguf0mw4.json'));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })),
              ),
              // child: FutureBuilder(
              //   future:
              //       ListEbookServices.baCard('listcart', idUser, '', status: ''),
              //   builder: (_, snapshot) {
              //     if (snapshot.hasData) {
              //       BaCardResult baCardResult = snapshot.data as BaCardResult;
              //       if (baCardResult.statusCode == 200) {
              //         List<ListEbookModel> listEbookModel =
              //             baCardResult.listEBookInCard as List<ListEbookModel>;

              //         return ListView.builder(
              //           itemCount: listEbookModel.length,
              //           padding: const EdgeInsets.symmetric(vertical: 80),
              //           itemBuilder: (context, index) {
              //             return CardProductCart(
              //                 idBook: listEbookModel[index].idBook,
              //                 title: listEbookModel[index].title,
              //                 cover: listEbookModel[index].cover,
              //                 totalDiscount:
              //                     listEbookModel[index].discountBuy.toString(),
              //                 priceFormat: listEbookModel[index].priceFormat,
              //                 discountPriceFormat:
              //                     listEbookModel[index].discountPriceFormat);
              //           },
              //         );
              //       } else {
              //         return const SizedBox();
              //       }
              //     } else {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }
              //   },
              // ),
            ),
          ),

          SafeArea(
            child: HeaderBackArrowandTitlePage('Keranjang', onTap: () {
              navigationPop(context);
            }),
          ),
          _footer(context),

          (isLoaded)
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.9)),
                  child: const Center(child: CircularProgressIndicator()))
              : Container(),
        ]),
      ),
    );
  }

  Widget _footer(BuildContext context) {
    return BlocBuilder<CountCartBloc, CountCartState>(
      builder: (context, state) {
        if (state is CountCartItemLoaded) {
          CartCheckout cartCheckout =
              state.baCardResult.cartCheckout as CartCheckout;
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                color: whiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(flex: 1),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Harga',
                            style: TextStyle(fontFamily: textMain)),
                        Text(cartCheckout.totalPaymentFormat, style: textPrice)
                      ],
                    ),
                    const Spacer(flex: 8),
                    Container(
                      height: 48,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isLoaded = true;
                            });
                            if (cartCheckout.totalItem != 0) {
                              context.read<CountCartBloc>().add(
                                  FetchDataCountCartItemEvent(idUser: idUser));
                              context
                                  .read<ItemCartBloc>()
                                  .add(FetchDataItemCartEvent(idUser: idUser));

                              BaTransactionResult baTransactionResult =
                                  await TransactionService.baTransaction(
                                      'addtransaction',
                                      idUser: idUser,
                                      discount: '',
                                      discountPrice: '',
                                      normalPrice: '',
                                      totalPay:
                                          cartCheckout.totalPayment.toString(),
                                      idTransaction: '',
                                      idBook: '',
                                      status: '');

                              await AddPaymentService.addPaymentBuyNow(
                                  idTransaction:
                                      baTransactionResult.idTransaction ?? '',
                                  price: cartCheckout.totalPayment.toString());

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          baTransactionResult.message ?? ''),
                                      actions: [
                                        TextButton(
                                          child: const Text('Mengerti'),
                                          onPressed: () {
                                            if (cartCheckout.totalItem != 0) {
                                              setState(() {
                                                isLoaded = false;
                                              });
                                              context.read<CountCartBloc>().add(
                                                  FetchDataCountCartItemEvent(
                                                      idUser: idUser));
                                              context.read<ItemCartBloc>().add(
                                                  FetchDataItemCartEvent(
                                                      idUser: idUser));
                                              Navigator.of(context).pop();

                                              // navigation(context,
                                              //     fromEvent: GoToCartPage(),
                                              //     toEvent: GoToAddPaymentPage(
                                              //         addPaymentModel:
                                              //             addPaymentModel));
                                              navigation(context,
                                                  fromEvent: GoToCartPage(),
                                                  toEvent: GoToPaymentPage(
                                                      noInvoice:
                                                          baTransactionResult
                                                                  .noInvoice ??
                                                              '',
                                                      idTransaction:
                                                          baTransactionResult
                                                                  .idTransaction ??
                                                              '',
                                                      totalPrice: cartCheckout
                                                          .totalPayment
                                                          .toString()));
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }

                            //   if (baTransactionResult.statusCode == 200) {
                            //     navigation(context,
                            //         fromEvent: GoToCartPage(),
                            //         toEvent: GoToPaymentPage(
                            //             idTransaction:
                            //                 baTransactionResult.idTransaction ??
                            //                     '',
                            //             totalPrice:
                            //                 cartCheckout.totalPaymentFormat));
                            //   } else {
                            //     showDialog(
                            //         context: context,
                            //         builder: (context) {
                            //           return AlertDialog(
                            //             content: Text(
                            //                 baTransactionResult.message ?? ''),
                            //             actions: [
                            //               TextButton(
                            //                 child: const Text('Mengerti'),
                            //                 onPressed: () {
                            //                   if (cartCheckout.totalItem != 0) {
                            //                     context.read<CountCartBloc>().add(
                            //                         FetchDataCountCartItemEvent(
                            //                             idUser: idUser));
                            //                     context.read<ItemCartBloc>().add(
                            //                         FetchDataItemCartEvent(
                            //                             idUser: idUser));

                            //                     Navigator.of(context).pop();
                            //                   }
                            //                 },
                            //               ),
                            //             ],
                            //           );
                            //         });
                            //   }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: (cartCheckout.totalItem != 0)
                                  ? mainColor
                                  : grayColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text('Beli (${cartCheckout.totalItem})')),
                    ),
                    const Spacer(flex: 1)
                  ],
                )),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
