part of 'widgets.dart';

///HeaderBackArrowSearchShareandCard this is widget App Bar
///wchich contain arrow back, search, Sheare, and card.
///
///value defaul [activeShear] is false, which means icon Shear in the App Bar, can't show
///[onTap] in the form Fungction action for back.

class HeaderBackArrowSearchShareandCard extends StatelessWidget {
  final bool activeShear;
  final Function onTap;
  final PagesEvent fromEvent;
  final PagesEvent toEvent;
  final String idCategory;
  final Function onTapCard;
  final String tag;
  final String titleProduct;
  final String linkProduct;
  const HeaderBackArrowSearchShareandCard(
      {this.activeShear = false,
      required this.onTap,
      required this.onTapCard,
      required this.tag,
      required this.fromEvent,
      required this.toEvent,
      required this.idCategory,
      this.titleProduct = '',
      this.linkProduct = '',
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> share() async {
      await FlutterShare.share(
          title: titleProduct,
          text: titleProduct,
          linkUrl: shareLinkProduk + linkProduct,
          chooserTitle: titleProduct);
    }

    return Container(
      height: 80,
      alignment: Alignment.centerLeft,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            // color: Colors.black.withOpacity(0.1),
            color: mainColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //note : Arrow Back
            GestureDetector(
              onTap: () {
                onTap();
              },
              child: Icon(
                // Icons.arrow_back_rounded,
                Icons.arrow_back_ios_new_rounded,
                color: whiteColor,
              ),
            ),

            const SizedBox(width: 10),
            //note : Search
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: MediaQuery.of(context).size.width / 2,
              child: TextField(
                style: TextStyle(fontFamily: textMain),
                textInputAction: TextInputAction.search,
                cursorHeight: 20,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_rounded, size: 20),
                    fillColor: whiteColor,
                    isDense: true,
                    filled: true,
                    hintText: 'Pencarian',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintStyle: TextStyle(
                        fontFamily: textMain, fontSize: 15, height: 1)),
                onSubmitted: (value) {
                  //Action to Go
                  if (value.isNotEmpty) {
                    log(value);
                    moreTag = tag;
                    moreSearchTitle = value;
                    // navigation(context,
                    //     fromEvent: GoToMorePage(tag: tag, idCategory: idCategory),
                    //     toEvent: GoToMorePage(
                    //         tag: moreTag ?? 'kategoricari',
                    //         idCategory: idCategory,
                    //         searchTitle: moreSearchTitle ?? value));
                    context.read<PagesBloc>().add(GoToMorePage(
                        tag: moreTag ?? 'kategoricari',
                        idCategory: idCategory,
                        searchTitle: moreSearchTitle ?? value));
                  }
                },
              ),
            ),

            //note : Sheare
            const Spacer(flex: 4),
            (activeShear)
                ? GestureDetector(
                    onTap: () {
                      if (linkProduct.isNotEmpty && titleProduct.isNotEmpty) {
                        share();
                      }
                    },
                    child: Icon(
                      Icons.share_rounded,
                      color: whiteColor,
                      size: 24,
                    ),
                  )
                : Container(),
            const Spacer(flex: 1),

            //note: Cart
            GestureDetector(
              onTap: () {
                onTapCard();
              },
              child: SizedBox(
                height: 32,
                width: 30,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        color: whiteColor,
                        size: 24,
                      ),
                    ),
                    (itemCardProduct != 0)
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 18,
                              width: 18,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: redColor),
                              child: Text(
                                itemCardProduct.toString(),
                                style: textItemCardProduct,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
