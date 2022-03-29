part of 'widgets.dart';

/// This is widgets Header or App Bar for home_page and blog_page.
///
/// There is File searching, button Chat WhatsApp and button Cart.

class HeaderSearchChatandCartWidgets extends StatefulWidget {
  const HeaderSearchChatandCartWidgets({Key? key}) : super(key: key);

  @override
  State<HeaderSearchChatandCartWidgets> createState() =>
      _HeaderSearchChatandCartWidgetsState();
}

class _HeaderSearchChatandCartWidgetsState
    extends State<HeaderSearchChatandCartWidgets> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    // void lauchWhatsapp(
    //     {required String number, required String message}) async {
    //   String url = "https://wa.me/$number/?text=${Uri.parse(message)}";
    //   await canLaunch(url) ? launch(url) : log("Can't open whatsapp");
    // }

    if (i < 1) {
      Future.delayed(const Duration(seconds: 1), () {
        context
            .read<CountCartBloc>()
            .add(FetchDataCountCartItemEvent(idUser: idUser));
        i++;
      });
    }

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(color: mainColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //note : File Input
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TextField(
              style: TextStyle(fontFamily: textMain),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Pencarian',
                  fillColor: whiteColor,
                  isDense: true,
                  filled: true,
                  labelStyle: TextStyle(fontFamily: textMain),
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  hintStyle:
                      TextStyle(fontFamily: textMain, fontSize: 15, height: 1)),
              onSubmitted: (value) {
                //Action to Go
                if (value.isNotEmpty) {
                  log(value);
                  moreTag = 'semua';
                  moreSearchTitle = value;

                  navigation(context,
                      fromEvent: const GoToMainPage(),
                      toEvent: GoToMorePage(
                          tag: 'semua', idCategory: '', searchTitle: value));
                }
              },
            ),
          ),
          const Spacer(flex: 4),

          //note : Chat WhatsApp
          // GestureDetector(
          //   onTap: () {
          //     lauchWhatsapp(number: numberWhatsApp, message: messageWhatsApp);
          //   },
          //   child: Image.asset(
          //     'assets/icons/IconWhatsApp.png',
          //     scale: 15,
          //   ),
          // ),
          const Spacer(flex: 1),

          //note: Cart
          GestureDetector(
            onTap: () {
              if (detectUser) {
                navigation(context,
                    fromEvent: const GoToMainPage(), toEvent: GoToCartPage());
              } else {
                navigation(context,
                    fromEvent: const GoToMainPage(), toEvent: GoToSignInPage());
              }
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
                  // StreamBuilder<int>(
                  //   stream: generateNumbers,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       if (itemCardProduct != 0) {
                  //         return
                  //       } else {
                  //         return const SizedBox();
                  //       }
                  //     } else {
                  //       return const SizedBox();
                  //     }
                  //   },
                  // ),
                  BlocBuilder<CountCartBloc, CountCartState>(
                    builder: (context, state) {
                      if (state is CountCartItemLoaded) {
                        itemCardProduct =
                            state.baCardResult.cartCheckout!.totalItem;

                        if (itemCardProduct != 0) {
                          return Align(
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
                              ));
                        } else {
                          return const SizedBox();
                        }
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),

                  // (itemCardProduct != 0)
                  //     ? Align(
                  //         alignment: Alignment.topRight,
                  //         child: Container(
                  //           height: 18,
                  //           width: 18,
                  //           alignment: Alignment.center,
                  //           decoration: BoxDecoration(
                  //               shape: BoxShape.circle, color: redColor),
                  //           child: Text(
                  //             itemCardProduct.toString(),
                  //             style: textItemCardProduct,
                  //           ),
                  //         ),
                  //       )
                  //     : const SizedBox(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
