part of '../pages.dart';

class MorePage extends StatelessWidget {
  final String idCategory;
  final String searchTitle;
  final String tag;
  final bool tagMore;
  const MorePage(
      {required this.tag,
      this.idCategory = '',
      this.searchTitle = '',
      this.tagMore = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: MoreContentPage(
              tag: moreTag ?? tag,
              idCategory: idCategory,
              searchTitle: moreSearchTitle ?? searchTitle,
              tagMore: tagMore,
            ),
          )),

          //Header
          SafeArea(
              child: HeaderBackArrowSearchShareandCard(
                  tag: moreTag ?? tag,
                  idCategory: idCategory,
                  fromEvent: GoToMorePage(tag: tag, idCategory: idCategory),
                  toEvent: GoToMorePage(tag: tag, idCategory: idCategory),
                  onTap: () {
                    navigationPop(context);
                  },
                  onTapCard: () {
                    if (detectUser) {
                      navigation(context,
                          fromEvent: GoToMorePage(
                              idCategory: idCategory,
                              tag: moreTag ?? tag,
                              searchTitle: searchTitle),
                          toEvent: GoToCartPage());
                    } else {
                      navigation(context,
                          fromEvent: GoToMorePage(
                              idCategory: idCategory,
                              tag: moreTag ?? tag,
                              searchTitle: moreSearchTitle ?? searchTitle),
                          toEvent: GoToSignInPage());
                    }
                  })),
        ]),
      ),
    );
  }
}
