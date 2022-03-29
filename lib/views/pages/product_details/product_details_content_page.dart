part of '../pages.dart';

class ProductDetailsContentPage extends StatelessWidget {
  final String idBook;
  const ProductDetailsContentPage({required this.idBook, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<ProductDetailsBahanaflixModel> detailDataProduct =
        ListEbookServices.getProductDetailsDetaEbook(idBook);
    // PaletteColor? paletteColor;

    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1), () {
          detailDataProduct =
              ListEbookServices.getProductDetailsDetaEbook(idBook);
          context
              .read<CountCartBloc>()
              .add(FetchDataCountCartItemEvent(idUser: idUser));
        });
      },
      child: FutureBuilder(
        future: detailDataProduct,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            ProductDetailsBahanaflixModel productDetailsBahanaflixModel =
                snapshot.data as ProductDetailsBahanaflixModel;

            // _addPalettes() async {
            //   PaletteGenerator paletteGenerator =
            //       await PaletteGenerator.fromImageProvider(
            //           NetworkImage(productDetailsBahanaflixModel.cover),
            //           size: const Size(164, 230));

            //   paletteColor = (paletteGenerator.lightMutedColor != null)
            //       ? paletteGenerator.lightMutedColor
            //       : PaletteColor(mainColor, 2);
            // }

            // _addPalettes();

            return Stack(
              children: [
                Container(
                    height: 390,
                    width: MediaQuery.of(context).size.width,
                    color: mainColor),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  child: ListView(
                    children: [
                      //Cover Product
                      Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: productDetailsBahanaflixModel.cover,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: 230,
                                width: 164,
                                margin:
                                    const EdgeInsets.only(top: 80, bottom: 60),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 4,
                                          blurRadius: 20,
                                          offset: const Offset(0, 0)),
                                    ],
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              );
                            },
                            placeholder: (context, img) {
                              return Container(
                                height: 230,
                                width: 164,
                                margin:
                                    const EdgeInsets.only(top: 80, bottom: 60),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/PlaceholderImageProduct.jpeg'),
                                        fit: BoxFit.cover)),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Container(
                                height: 230,
                                width: 164,
                                margin:
                                    const EdgeInsets.only(top: 80, bottom: 60),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/ErrorImageProduct.png'),
                                        fit: BoxFit.cover)),
                              );
                            },
                          ),
                        ],
                      ),

                      Text(
                        productDetailsBahanaflixModel.title,
                        style: TextStyle(
                            fontFamily: textMain,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),

                      const SizedBox(height: 2),
                      Text(
                        productDetailsBahanaflixModel.categoryName,
                        style: textGray,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ISBN: ${productDetailsBahanaflixModel.isbn}',
                            style: TextStyle(fontFamily: textMain),
                          ),
                          Text(
                              'Tahun Terbit : ${productDetailsBahanaflixModel.publicationYear}',
                              style: TextStyle(fontFamily: textMain))
                        ],
                      ),
                      const SizedBox(height: 10),
                      (productDetailsBahanaflixModel.canBuy == 'Y')
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Harga Beli : '),
                                (productDetailsBahanaflixModel.discountBuy ==
                                        '0')
                                    ? const SizedBox()
                                    : Row(
                                        children: [
                                          Text(
                                            productDetailsBahanaflixModel
                                                .priceFormat,
                                            style: textPriceLineThrough,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: redColor,
                                            ),
                                            child: Text(
                                              productDetailsBahanaflixModel
                                                      .discountBuy +
                                                  '%',
                                              style: textDiscount,
                                            ),
                                          ),
                                        ],
                                      ),
                                const SizedBox(height: 4),
                                Text(
                                    (productDetailsBahanaflixModel
                                                .discountBuy ==
                                            '0')
                                        ? productDetailsBahanaflixModel
                                            .priceFormat
                                        : productDetailsBahanaflixModel
                                            .discountPriceFormatBuy,
                                    style: textPrice),
                              ],
                            )
                          : const SizedBox(),

                      (productDetailsBahanaflixModel.canRent == 'Y')
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const Text('Harga Sewa : '),
                                (productDetailsBahanaflixModel.discountRent ==
                                        '0')
                                    ? const SizedBox()
                                    : Row(
                                        children: [
                                          Text(
                                              productDetailsBahanaflixModel
                                                  .rentalPriceFormat,
                                              style: textPriceLineThrough),
                                          // Text(productDetailsBahanaflixModel.discountRent,
                                          //     style: textPrice),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: redColor,
                                            ),
                                            child: Text(
                                              productDetailsBahanaflixModel
                                                      .discountRent +
                                                  '%',
                                              style: textDiscount,
                                            ),
                                          ),
                                        ],
                                      ),
                                Text(
                                    (productDetailsBahanaflixModel
                                                .discountRent ==
                                            '0')
                                        ? productDetailsBahanaflixModel
                                            .rentalPriceFormat
                                        : productDetailsBahanaflixModel
                                            .discountPriceFomatRent,
                                    style: textPrice),
                              ],
                            )
                          : const SizedBox(),

                      const SizedBox(height: 100)
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    color: whiteColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //note : Chat WhatsApp
                        // GestureDetector(
                        //   onTap: () {
                        //     lauchWhatsapp(
                        //         number: numberWhatsApp,
                        //         message:
                        //             'Haloo Kak, saya ingin bertanya mengenai produk ' +
                        //                 titleProduct);
                        //   },
                        //   child: Image.asset(
                        //     'assets/icons/IconWhatsApp.png',
                        //     scale: 15,
                        //   ),
                        // ),

                        //note : Button Tambah Ke Keranjang
                        GestureDetector(
                          onTap: () {
                            if (detectUser) {
                              showModalBottomSheet<dynamic>(
                                  isScrollControlled: true,
                                  barrierColor: Colors.black.withOpacity(0.4),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.0),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                        height: 200,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 14),
                                        decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius: const BorderRadius.vertical(
                                                top: Radius.circular(25))),
                                        child: ProductDetailsBottomSheetPage(
                                            longRent: productDetailsBahanaflixModel
                                                .longRent,
                                            discountPriceFormatBuy:
                                                productDetailsBahanaflixModel
                                                    .discountPriceFormatBuy,
                                            discountPriceFormatRent:
                                                productDetailsBahanaflixModel
                                                    .discountPriceFomatRent,
                                            idBook: idBook,
                                            cover: productDetailsBahanaflixModel
                                                .cover,
                                            title: productDetailsBahanaflixModel
                                                .title,
                                            canPackage: productDetailsBahanaflixModel
                                                .canPackage,
                                            canRent: productDetailsBahanaflixModel
                                                .canRent,
                                            canBuy: productDetailsBahanaflixModel
                                                .canBuy,
                                            rentalPriceFormat:
                                                productDetailsBahanaflixModel
                                                    .rentalPriceFormat,
                                            priceFormat:
                                                productDetailsBahanaflixModel
                                                    .priceFormat,
                                            discountPriceBuy:
                                                productDetailsBahanaflixModel.discountPriceBuy,
                                            discountPriceRent: productDetailsBahanaflixModel.discountPriceRent,
                                            discountRent: productDetailsBahanaflixModel.discountRent,
                                            discountBuy: productDetailsBahanaflixModel.discountBuy,
                                            price: productDetailsBahanaflixModel.price,
                                            rentalPrice: productDetailsBahanaflixModel.rentalPrice,
                                            statusDiscount: productDetailsBahanaflixModel.statusDiscount));
                                  });
                            } else {
                              navigation(context,
                                  fromEvent:
                                      GoToProductDetailsPage(idBook: idBook),
                                  toEvent: GoToSignInPage());
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                                border: Border.all(color: mainColor, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Tambah Ke Keranjang',
                              style: TextStyle(
                                  height: 1,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor,
                                  fontSize: 15),
                            ),
                          ),
                        ),

                        //note : Button Beli Sekarang

                        GestureDetector(
                          onTap: () async {
                            if (detectUser) {
                              showModalBottomSheet<dynamic>(
                                  isScrollControlled: true,
                                  barrierColor: Colors.black.withOpacity(0.4),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.0),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                        height: 200,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 14),
                                        decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(25))),
                                        child: ProductDetailsBottomSheetPage(
                                          longRent:
                                              productDetailsBahanaflixModel
                                                  .longRent,
                                          discountPriceFormatBuy:
                                              productDetailsBahanaflixModel
                                                  .discountPriceFormatBuy,
                                          discountPriceFormatRent:
                                              productDetailsBahanaflixModel
                                                  .discountPriceFomatRent,
                                          idBook: idBook,
                                          cover: productDetailsBahanaflixModel
                                              .cover,
                                          title: productDetailsBahanaflixModel
                                              .title,
                                          canPackage:
                                              productDetailsBahanaflixModel
                                                  .canPackage,
                                          canRent: productDetailsBahanaflixModel
                                              .canRent,
                                          canBuy: productDetailsBahanaflixModel
                                              .canBuy,
                                          rentalPriceFormat:
                                              productDetailsBahanaflixModel
                                                  .rentalPriceFormat,
                                          priceFormat:
                                              productDetailsBahanaflixModel
                                                  .priceFormat,
                                          discountBuy:
                                              productDetailsBahanaflixModel
                                                  .discountBuy,
                                          discountPriceBuy:
                                              productDetailsBahanaflixModel
                                                  .discountPriceBuy,
                                          discountPriceRent:
                                              productDetailsBahanaflixModel
                                                  .discountPriceRent,
                                          discountRent:
                                              productDetailsBahanaflixModel
                                                  .discountRent,
                                          statusDiscount:
                                              productDetailsBahanaflixModel
                                                  .statusDiscount,
                                          price: productDetailsBahanaflixModel
                                              .price,
                                          rentalPrice:
                                              productDetailsBahanaflixModel
                                                  .rentalPrice,
                                          buyNow: true,
                                        ));
                                  });
                            } else {
                              navigation(context,
                                  fromEvent:
                                      GoToProductDetailsPage(idBook: idBook),
                                  toEvent: GoToSignInPage());
                            }
                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return AlertDialog(
                            //         content: Text(message),
                            //         actions: [
                            //           TextButton(
                            //             child: const Text('Mengerti'),
                            //             onPressed: () {
                            //               Navigator.of(context).pop();
                            //             },
                            //           ),
                            //         ],
                            //       );
                            //     });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                                color: mainColor,
                                border: Border.all(color: mainColor, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Beli Sekarang',
                              style: TextStyle(
                                  height: 1,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // child: ElevatedButton(
                    //     onPressed: (() {
                    //       showModalBottomSheet<dynamic>(
                    //           isScrollControlled: true,
                    //           barrierColor: Colors.black.withOpacity(0.4),
                    //           backgroundColor: Colors.black.withOpacity(0.0),
                    //           context: context,
                    //           builder: (context) {
                    //             return Container(
                    //                 height: 180,
                    //                 padding: const EdgeInsets.symmetric(
                    //                     horizontal: 16, vertical: 14),
                    //                 decoration: BoxDecoration(
                    //                     color: whiteColor,
                    //                     borderRadius: const BorderRadius.vertical(
                    //                         top: Radius.circular(25))),
                    //                 child: ProductDetailsBottomSheetPage(
                    //                     idBook: idBook,
                    //                     cover:
                    //                         productDetailsBahanaflixModel.cover,
                    //                     title:
                    //                         productDetailsBahanaflixModel.title,
                    //                     canPackage: productDetailsBahanaflixModel
                    //                         .canPackage,
                    //                     canRent:
                    //                         productDetailsBahanaflixModel.canRent,
                    //                     canBuy:
                    //                         productDetailsBahanaflixModel.canBuy,
                    //                     rentalPrice: productDetailsBahanaflixModel
                    //                         .rentalPrice,
                    //                     price:
                    //                         productDetailsBahanaflixModel.price,
                    //                     discount: productDetailsBahanaflixModel
                    //                         .discount,
                    //                     discountPrice:
                    //                         productDetailsBahanaflixModel
                    //                             .discount,
                    //                     statusDiscount:
                    //                         productDetailsBahanaflixModel
                    //                             .statusDiscount));
                    //           });
                    //     }),
                    //     style: ElevatedButton.styleFrom(
                    //       primary: purpleColorBtn,
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 100, vertical: 10),
                    //     ),
                    //     child: const Text('Ambil Buku')),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
