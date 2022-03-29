part of '../widgets.dart';

class ListCardProductWidget extends StatelessWidget {
  final String titleCardList;
  final String tag;
  final List<ListEbookModel> listEbookModel;
  final bool eBookDigital;
  final bool flashSale;
  const ListCardProductWidget(
      {required this.titleCardList,
      this.tag = '',
      required this.listEbookModel,
      required this.eBookDigital,
      this.flashSale = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            height: (flashSale)
                ? 354
                : (eBookDigital)
                    ? 200
                    : 304,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
            decoration: BoxDecoration(
                color: (eBookDigital) ? backgrounpurpleColor : whiteColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: (flashSale) ? 4 : 0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 106,
                            child: Text(
                              titleCardList,
                              style: TextStyle(
                                  fontFamily: textMain,
                                  fontSize: 16,
                                  color:
                                      (eBookDigital) ? whiteColor : mainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        (flashSale)
                            ? const Text('Berakhir dalam')
                            : const SizedBox()
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        navigation(context,
                            fromEvent: const GoToMainPage(),
                            toEvent: GoToMorePage(
                                tag: tag,
                                idCategory: '',
                                searchTitle: '',
                                tagMore: true));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Lainnya',
                            style: TextStyle(
                                fontSize: 12,
                                color: whiteColor,
                                fontFamily: textMain),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: (eBookDigital) ? whiteColor : grayColor,
                            size: 18,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
              height: 264,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: (flashSale) ? 78 : 38),
              child: ListView.builder(
                  itemCount: listEbookModel.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (_, index) {
                    return CardProductWidgets(
                        idProduct: listEbookModel[index].idBook,
                        cover: listEbookModel[index].cover,
                        title: listEbookModel[index].title,
                        canBuy: listEbookModel[index].canBuy,
                        canPackage: listEbookModel[index].canPackage,
                        canRent: listEbookModel[index].canRent,
                        priceFormat: listEbookModel[index].priceFormat,
                        rentalPriceFormat:
                            listEbookModel[index].rentalPriceFormat,
                        discountBuy: listEbookModel[index].discountBuy,
                        discountRent: listEbookModel[index].discountRent,
                        discountPriceFormat:
                            listEbookModel[index].discountPriceFormatBuy,
                        statuSpricePremierRent:
                            (tag == 'hasil_beli') ? false : true,
                        discountPriceFormatRent:
                            listEbookModel[index].discountPriceFormatRent,
                        productBookDigital: (eBookDigital) ? true : false,
                        onTap: () {
                          navigation(context,
                              fromEvent: const GoToMainPage(),
                              toEvent: GoToProductDetailsPage(
                                  idBook: listEbookModel[index].idBook));
                        });
                  })),
        ],
      ),
    );
  }
}
