part of '../pages.dart';

class ProductDetailsBottomSheetPage extends StatefulWidget {
  final String idBook;
  final String cover;
  final String title;
  final String canPackage;
  final String canRent;
  final String canBuy;
  final String rentalPrice;
  final String rentalPriceFormat;
  final String price;
  final String priceFormat;
  final String discountPriceBuy;
  final String discountPriceRent;
  final String discountPriceFormatBuy;
  final String discountPriceFormatRent;
  final String discountRent;
  final String discountBuy;
  final String longRent;
  final String statusDiscount;
  final bool buyNow;
  const ProductDetailsBottomSheetPage(
      {required this.idBook,
      required this.cover,
      required this.title,
      required this.canPackage,
      required this.canRent,
      required this.canBuy,
      required this.rentalPrice,
      required this.rentalPriceFormat,
      required this.price,
      required this.priceFormat,
      required this.discountPriceBuy,
      required this.discountPriceRent,
      required this.discountPriceFormatBuy,
      required this.discountPriceFormatRent,
      required this.discountRent,
      required this.discountBuy,
      required this.longRent,
      required this.statusDiscount,
      this.buyNow = false,
      Key? key})
      : super(key: key);

  @override
  State<ProductDetailsBottomSheetPage> createState() =>
      _ProductDetailsBottomSheetPageState();
}

class _ProductDetailsBottomSheetPageState
    extends State<ProductDetailsBottomSheetPage> {
  int menuSelectionAddToCard = 0;
  bool isLoaded = false;

  @override
  void initState() {
    menuSelectionAddToCard = (widget.canBuy == 'Y') ? 1 : 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            CachedNetworkImage(
                imageUrl: widget.cover,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 140,
                    width: 90,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  );
                },
                placeholder: (context, img) {
                  return Container(
                    height: 140,
                    width: 90,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/PlaceholderImageProduct.jpeg'),
                          fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    height: 140,
                    width: 90,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image:
                              AssetImage('assets/images/ErrorImageProduct.png'),
                          fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  );
                }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width:
                        MediaQuery.of(context).size.width - (32 + 98 + 64 + 10),
                    child: Text(
                      widget.title,
                      style: TextStyle(fontFamily: textMain),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                const SizedBox(height: 8),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (widget.canBuy == 'Y') {
                              setState(() {
                                menuSelectionAddToCard = 1;
                              });
                              log(menuSelectionAddToCard.toString());
                            }
                          },
                          style: (widget.canBuy == 'Y')
                              ? (menuSelectionAddToCard == 1)
                                  ? ElevatedButton.styleFrom(
                                      primary: purpleColorBtn,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))
                                  : ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        width: 1.0,
                                        color: purpleColorBtn,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onPrimary: blackColor,
                                      primary: whiteColor,
                                    )
                              : ElevatedButton.styleFrom(
                                  side: BorderSide(
                                    width: 1.0,
                                    color: grayColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPrimary: whiteColor,
                                  primary: grayColor,
                                ),
                          child: const Text('Beli')),
                      const SizedBox(width: 8),
                      ElevatedButton(
                          onPressed: () {
                            if (widget.canRent == 'Y') {
                              setState(() {
                                menuSelectionAddToCard = 2;
                                log(menuSelectionAddToCard.toString());
                              });
                            }
                          },
                          style: (widget.canRent == 'Y')
                              ? (menuSelectionAddToCard == 2)
                                  ? ElevatedButton.styleFrom(
                                      primary: purpleColorBtn,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))
                                  : ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        width: 1.0,
                                        color: purpleColorBtn,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onPrimary: blackColor,
                                      primary: whiteColor,
                                    )
                              : ElevatedButton.styleFrom(
                                  side: BorderSide(
                                    width: 1.0,
                                    color: grayColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPrimary: whiteColor,
                                  primary: grayColor,
                                ),
                          child: const Text('Sewa')),
                      const SizedBox(width: 8),
                      // OutlinedButton(
                      //     onPressed: () {},
                      //     style: ElevatedButton.styleFrom(
                      //       side: BorderSide(
                      //         width: 1.0,
                      //         color: purpleColorBtn,
                      //       ),
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10)),
                      //       onPrimary: blackColor,
                      //     ),
                      //     child: const Text('Paket'))
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                (menuSelectionAddToCard == 1)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (widget.discountBuy == '0')
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    Text(
                                      widget.priceFormat,
                                      style: textPriceLineThrough,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: redColor,
                                      ),
                                      child: Text(
                                        widget.discountBuy + '%',
                                        style: textDiscount,
                                      ),
                                    )
                                  ],
                                ),
                          const SizedBox(height: 8),
                          Text(
                              (widget.discountBuy == '0')
                                  ? widget.priceFormat
                                  : widget.discountPriceFormatBuy,
                              style: textPrice),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('- Penyewaan buku ${widget.longRent} hari'),
                          const SizedBox(height: 8),
                          (widget.discountRent == '0')
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    Text(
                                      widget.rentalPriceFormat,
                                      style: textPriceLineThrough,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: redColor,
                                      ),
                                      child: Text(
                                        widget.discountRent + '%',
                                        style: textDiscount,
                                      ),
                                    )
                                  ],
                                ),
                          Text(
                              (widget.discountRent == '0')
                                  ? widget.rentalPriceFormat
                                  : widget.discountPriceFormatRent,
                              style: textPrice),
                        ],
                      )
              ],
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoaded = true;
                    });
                    if (widget.buyNow) {
                      BaTransactionResult baTransactionResult =
                          await TransactionService.baTransaction(
                              'addtransaction_direct',
                              idUser: idUser,
                              totalPay: (menuSelectionAddToCard == 1)
                                  ? (widget.discountBuy == '0')
                                      ? widget.price
                                      : widget.discountPriceBuy
                                  : (widget.discountRent == '0')
                                      ? widget.rentalPrice
                                      : widget.discountPriceRent,
                              idBook: widget.idBook,
                              status: menuSelectionAddToCard.toString(),
                              idTransaction: '',
                              discount: (menuSelectionAddToCard == 1)
                                  ? widget.discountBuy
                                  : widget.discountRent,
                              discountPrice: (menuSelectionAddToCard == 1)
                                  ? widget.discountPriceBuy
                                  : widget.discountPriceRent,
                              normalPrice: (menuSelectionAddToCard == 1)
                                  ? widget.price
                                  : widget.rentalPrice);

                      if (baTransactionResult.statusCode == 200) {
                        showDialog<dynamic>(
                          barrierDismissible: false,
                          barrierColor: Colors.black.withOpacity(0.4),
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Berhasil'),
                              content:
                                  Text(baTransactionResult.message.toString()),
                              actions: [
                                TextButton(
                                  child: const Text('Mengerti'),
                                  onPressed: () {
                                    setState(() {
                                      isLoaded = false;
                                    });
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();

                                    // navigation(context,
                                    //     fromEvent: GoToProductDetailsPage(
                                    //         idBook: widget.idBook),
                                    //     toEvent: GoToAddPaymentPage(
                                    //         addPaymentModel: addPaymentModel));
                                    log('invoisapp' +
                                        baTransactionResult.noInvoice
                                            .toString());
                                    navigation(context,
                                        fromEvent: GoToProductDetailsPage(
                                            idBook: widget.idBook),
                                        toEvent: GoToPaymentPage(
                                            noInvoice:
                                                baTransactionResult.noInvoice ??
                                                    '',
                                            idTransaction: baTransactionResult
                                                    .idTransaction ??
                                                '',
                                            totalPrice:
                                                (menuSelectionAddToCard == 1)
                                                    ? (widget.discountBuy ==
                                                            '0')
                                                        ? widget.price
                                                        : widget
                                                            .discountPriceBuy
                                                    : (widget.discountRent ==
                                                            '0')
                                                        ? widget.rentalPrice
                                                        : widget
                                                            .discountPriceRent));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog<dynamic>(
                          barrierDismissible: false,
                          barrierColor: Colors.black.withOpacity(0.4),
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Gagal'),
                              content:
                                  Text(baTransactionResult.message.toString()),
                              actions: [
                                TextButton(
                                  child: const Text('Mengerti'),
                                  onPressed: () {
                                    setState(() {
                                      isLoaded = false;
                                    });
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();

                                    // navigation(context,
                                    //     fromEvent: GoToProductDetailsPage(
                                    //         idBook: widget.idBook),
                                    //     toEvent: GoToAddPaymentPage(
                                    //         addPaymentModel: addPaymentModel));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      if (menuSelectionAddToCard != 0) {
                        setState(() {
                          isLoaded = true;
                        });

                        BaCardResult baCardResult =
                            await ListEbookServices.baCard(
                                'addcart', idUser, widget.idBook,
                                status: menuSelectionAddToCard.toString());

                        log('imte cart' + itemCardProduct.toString());

                        setState(() {
                          isLoaded = false;
                        });
                        if (baCardResult.statusCode == 200) {
                          Navigator.pop(context);
                        } else {
                          showDialog<dynamic>(
                            barrierColor: Colors.black.withOpacity(0.4),
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Gagal'),
                                content: Text(baCardResult.massage.toString()),
                                actions: [
                                  TextButton(
                                    child: const Text('Mengerti'),
                                    onPressed: () {
                                      setState(() {
                                        isLoaded = false;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    }
                  },
                  child: Icon(
                    (widget.buyNow)
                        ? Icons.shopping_bag_outlined
                        : Icons.shopping_cart_outlined,
                    color: whiteColor,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 16),
                      primary: purpleColorBtn),
                )),
          ],
        ),
        (isLoaded)
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.9)),
                child: const Center(child: CircularProgressIndicator()))
            : Container(),
      ],
    );
  }
}
