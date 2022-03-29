part of '../widgets.dart';

class CardProductCart extends StatefulWidget {
  final String idBook;
  final String title;
  final String cover;
  final String totalDiscount;
  final String priceFormat;
  final String discountPriceFormat;
  const CardProductCart(
      {required this.idBook,
      required this.title,
      required this.cover,
      required this.totalDiscount,
      required this.priceFormat,
      required this.discountPriceFormat,
      Key? key})
      : super(key: key);

  @override
  State<CardProductCart> createState() => _CardProductCartState();
}

class _CardProductCartState extends State<CardProductCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      width: MediaQuery.of(context).size.width - 32,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4)),
          ]),
      child: Row(
        children: [
          const Spacer(flex: 1),
          // SizedBox(width: 24),
          // const Spacer(flex: 1),
          CachedNetworkImage(
            imageUrl: widget.cover,
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 106,
                width: 76,
                decoration: BoxDecoration(
                    color: grayColor,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              );
            },
            placeholder: (context, img) {
              return Container(
                height: 106,
                width: 76,
                decoration: BoxDecoration(
                    color: grayColor,
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage(
                            'assets/images/PlaceholderImageProduct.jpeg'),
                        fit: BoxFit.cover)),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                height: 106,
                width: 76,
                decoration: BoxDecoration(
                    color: grayColor,
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image:
                            AssetImage('assets/images/ErrorImageProduct.png'),
                        fit: BoxFit.cover)),
              );
            },
          ),
          const Spacer(flex: 1),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - (32 + 76 + 48),
                child: Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              (widget.totalDiscount == '0')
                  ? const SizedBox()
                  : Row(
                      children: [
                        Text(widget.priceFormat, style: textPriceLineThrough),
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: redColor,
                            ),
                            child: Text(
                              widget.totalDiscount + '%',
                              style: textDiscount,
                            )),
                      ],
                    ),
              Text(
                  (widget.totalDiscount == '0')
                      ? widget.priceFormat
                      : widget.discountPriceFormat,
                  style: textPrice),
              GestureDetector(
                onTap: () async {
                  BaCardResult baCardResult = await ListEbookServices.baCard(
                      'deletecart', idUser, widget.idBook,
                      status: '');

                  if (baCardResult.statusCode == 200) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(baCardResult.massage.toString()),
                            actions: [
                              TextButton(
                                child: const Text('Mengerti'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  context.read<ItemCartBloc>().add(
                                      FetchDataItemCartEvent(idUser: idUser));
                                },
                              ),
                            ],
                          );
                        });
                  }
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         content: const Text(
                  //             'Apakah anda yakin untuk menghapus Produk ini ?'),
                  //         actions: [
                  //           TextButton(
                  //             child: const Text('Tidak'),
                  //             onPressed: () {
                  //               Navigator.of(context).pop();
                  //             },
                  //           ),
                  //           TextButton(
                  //             child: const Text('Ya'),
                  //             onPressed: () async {
                  //               Navigator.of(context).pop();

                  //               Navigator.of(context).pop();
                  //             },
                  //           )
                  //         ],
                  //       );
                  //     });
                },
                child: Icon(
                  Icons.delete_rounded,
                  color: grayColor,
                ),
              )
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
