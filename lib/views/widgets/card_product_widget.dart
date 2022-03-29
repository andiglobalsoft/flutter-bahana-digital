part of 'widgets.dart';

class CardProductWidgets extends StatelessWidget {
  final String idProduct;
  final String cover;
  final String title;
  final String canPackage;
  final String canRent;
  final String canBuy;
  final String priceFormat;
  final String rentalPriceFormat;
  final String discountRent;
  final String discountBuy;
  final String discountPriceFormat;
  final String discountPriceFormatRent;
  final bool statuSpricePremierRent;
  final bool productBookDigital;
  final Function onTap;
  const CardProductWidgets(
      {required this.idProduct,
      required this.cover,
      required this.title,
      required this.canPackage,
      required this.canRent,
      required this.canBuy,
      required this.rentalPriceFormat,
      required this.priceFormat,
      required this.discountRent,
      required this.discountBuy,
      required this.discountPriceFormat,
      required this.discountPriceFormatRent,
      this.statuSpricePremierRent = true,
      this.productBookDigital = true,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: 156,
        child: Card(
          elevation: 4,
          color: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // (productBookDigital)
            //     ? ClipRRect(
            //         child: Banner(
            //             message: 'Buku Digital',
            //             color: purpleColor,
            //             location: BannerLocation.topEnd,
            //             child: _imageProduct(cover)),
            //       )
            //     :
            _imageProduct(cover),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 38,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        // textAlign: TextAlign.justify,
                      ),
                    ),
                    // const SizedBox(height: 10),
                    // (canRent == 'N')
                    //     ? const SizedBox(height: 12)
                    //     : (statusDiscount == 'Y')
                    //         ?
                    const SizedBox(height: 0),
                    (canBuy == 'Y')
                        ? (discountBuy == '0')
                            ? const SizedBox(height: 16)
                            : Row(
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
                                        discountBuy + '%',
                                        style: textDiscount,
                                      )),
                                  const SizedBox(width: 6),
                                  Text(
                                    priceFormat,
                                    style: textPriceLineThrough,
                                  ),
                                ],
                              )
                        : (discountRent == '0')
                            ? const SizedBox(height: 6)
                            : Row(
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
                                        discountRent + '%',
                                        style: textDiscount,
                                      )),
                                  const SizedBox(width: 6),
                                  Text(
                                    rentalPriceFormat,
                                    style: textPriceLineThrough,
                                  ),
                                ],
                              ),
                    // : const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // (canRent == 'Y' || rentalPrice != '0')
                        //     ? rentalPrice
                        //     : (discountPrice != '0')
                        //         ? discountPrice
                        //         :
                        (statuSpricePremierRent)
                            ? (discountRent == '0')
                                ? rentalPriceFormat
                                : discountPriceFormatRent
                            : (canBuy == 'Y')
                                ? (discountBuy == '0')
                                    ? priceFormat
                                    : discountPriceFormat
                                : (discountRent == '0')
                                    ? rentalPriceFormat
                                    : discountPriceFormatRent,
                        style: textPrice,
                      ),
                    ),
                  ],
                ))
          ]),
        ),
      ),
    );
  }

  _imageProduct(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: 160,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image:
                  DecorationImage(image: imageProvider, fit: BoxFit.contain)),
          // child: Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Container(
          //     height: 30,
          //     width: 30,
          //     margin: const EdgeInsets.all(4),
          //     decoration: BoxDecoration(
          //         color: Colors.amber, borderRadius: BorderRadius.circular(4)),
          //     child: Text('Sewa'),
          // ),
          // ),
        );
      },
      placeholder: (context, img) {
        return Container(
          height: 148,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image:
                      AssetImage('assets/images/PlaceholderImageProduct.jpeg'),
                  fit: BoxFit.cover)),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          height: 148,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: AssetImage('assets/images/ErrorImageProduct.png'),
                  fit: BoxFit.cover)),
          // child: Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Container(
          //     height: 50,
          //     width: 60,
          //     color: mainColor,
          //   ),
          // ),
        );
      },
    );
  }
}
