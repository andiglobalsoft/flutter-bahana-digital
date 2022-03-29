part of '../pages.dart';

class MoreContentPage extends StatefulWidget {
  final String idCategory;
  final String tag;
  final bool tagMore;
  final String searchTitle;
  const MoreContentPage(
      {required this.tag,
      this.tagMore = false,
      required this.idCategory,
      this.searchTitle = '',
      Key? key})
      : super(key: key);

  @override
  State<MoreContentPage> createState() => _MoreContentPageState();
}

class _MoreContentPageState extends State<MoreContentPage> {
  final ScrollController _scrollController = ScrollController();
  late List<ListEbookModel> _listEbookModel = [];
  int limit = 10;
  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      if (widget.tagMore) {
        ListEbookServices.getListMore(
                more: widget.tag,
                limit: limit.toString(),
                q: widget.searchTitle)
            .then((value) {
          setState(() {
            _listEbookModel = _listEbookModel + value.listEBookInCard;
            limit = limit * 2;
          });
        });
      } else {
        ListEbookServices.getListCetegoryEbook(
                limit: limit,
                offset: 10,
                idCategory: widget.idCategory,
                tag: widget.tag,
                search: widget.searchTitle)
            .then((value) {
          setState(() {
            _listEbookModel = _listEbookModel + value;

            limit = limit * 2;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(onScroll);
    return FutureBuilder(
        future: (widget.tagMore)
            ? ListEbookServices.getListMore(
                more: widget.tag, limit: '0', q: widget.searchTitle)
            : ListEbookServices.getListCetegoryEbook(
                limit: 0,
                offset: 10,
                idCategory: widget.idCategory,
                tag: widget.tag,
                search: widget.searchTitle),
        builder: (_, snapshot) {
          log('cke data more ' + snapshot.hasError.toString());

          if (snapshot.hasData) {
            if (widget.tagMore) {
              BaCardResult baCardResult = snapshot.data as BaCardResult;
              if (widget.tag == moreTag ||
                  widget.searchTitle == moreSearchTitle) {
                _listEbookModel = baCardResult.listEBookInCard;
              }

              if (_listEbookModel.isEmpty) {
                _listEbookModel = baCardResult.listEBookInCard;
              }
            } else {
              List<ListEbookModel> listEbookModel =
                  snapshot.data as List<ListEbookModel>;
              if (widget.tag == moreTag ||
                  widget.searchTitle == moreSearchTitle) {
                _listEbookModel = listEbookModel;
              }

              if (_listEbookModel.isEmpty) {
                _listEbookModel = listEbookModel;
              }
            }

            return GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 28,
                  mainAxisSpacing: 8,
                  childAspectRatio: (MediaQuery.of(context).size.width < 411.0)
                      ? 2 / 3.8
                      : 2 / 3.3,
                ),
                padding: const EdgeInsets.only(
                    top: 100, left: 28, right: 28, bottom: 50),
                itemCount: _listEbookModel.length,
                itemBuilder: (context, index) {
                  if (index < _listEbookModel.length) {
                    return CardProductWidgets(
                        idProduct: _listEbookModel[index].idBook,
                        cover: _listEbookModel[index].cover,
                        title: _listEbookModel[index].title,
                        canPackage: _listEbookModel[index].canPackage,
                        canRent: _listEbookModel[index].canRent,
                        canBuy: _listEbookModel[index].canBuy,
                        rentalPriceFormat:
                            _listEbookModel[index].rentalPriceFormat,
                        priceFormat: _listEbookModel[index].priceFormat,
                        discountBuy: _listEbookModel[index].discountBuy,
                        discountRent: _listEbookModel[index].discountRent,
                        discountPriceFormat:
                            _listEbookModel[index].discountPriceFormatBuy,
                        discountPriceFormatRent:
                            _listEbookModel[index].discountPriceFormatRent,
                        statuSpricePremierRent:
                            (widget.tag == 'hasil_beli') ? false : true,
                        onTap: () {
                          navigation(context,
                              fromEvent: GoToMorePage(
                                  tag: widget.tag,
                                  tagMore: widget.tagMore,
                                  idCategory: widget.idCategory),
                              toEvent: GoToProductDetailsPage(
                                  idBook: _listEbookModel[index].idBook));
                        });
                  } else {
                    return CardProductWidgets(
                        idProduct: _listEbookModel[index].idBook,
                        cover: _listEbookModel[index].cover,
                        title: _listEbookModel[index].title,
                        canPackage: _listEbookModel[index].canPackage,
                        canRent: _listEbookModel[index].canRent,
                        canBuy: _listEbookModel[index].canBuy,
                        rentalPriceFormat:
                            _listEbookModel[index].rentalPriceFormat,
                        priceFormat: _listEbookModel[index].priceFormat,
                        discountBuy: _listEbookModel[index].discountBuy,
                        discountRent: _listEbookModel[index].discountRent,
                        discountPriceFormatRent:
                            _listEbookModel[index].discountPriceFormatRent,
                        discountPriceFormat:
                            _listEbookModel[index].discountPriceFormatBuy,
                        statuSpricePremierRent:
                            (widget.tag == 'hasil_beli') ? false : true,
                        onTap: () {
                          navigation(context,
                              fromEvent: GoToMorePage(
                                  tag: widget.tag,
                                  tagMore: widget.tagMore,
                                  idCategory: widget.idCategory),
                              toEvent: GoToProductDetailsPage(
                                  idBook: _listEbookModel[index].idBook));
                        });
                  }
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Lottie.network(
                  'https://assets4.lottiefiles.com/private_files/lf30_cgfdhxgx.json'),
            );
          } else {
            return const LoadedListProductVertikal();
          }
        });
  }
}
