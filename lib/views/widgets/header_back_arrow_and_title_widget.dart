part of 'widgets.dart';

///HeaderBackArrowandTitlePage this is widgets App Bar
///wchich contain arrow back and title page.
///
///Widgets this need parameter [titlePage] and [onTap]
///
///[titlePage] in the form String name page and
///[onTap] in the form Fungction action for back.

class HeaderBackArrowandTitlePage extends StatefulWidget {
  final String idBook;
  final String titlePage;
  final Function onTap;
  final bool showCard;
  final bool backgroundTransparent;
  const HeaderBackArrowandTitlePage(this.titlePage,
      {this.showCard = false,
      this.idBook = '',
      required this.onTap,
      this.backgroundTransparent = false,
      Key? key})
      : super(key: key);

  @override
  State<HeaderBackArrowandTitlePage> createState() =>
      _HeaderBackArrowandTitlePageState();
}

class _HeaderBackArrowandTitlePageState
    extends State<HeaderBackArrowandTitlePage> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    // context
    //     .read<CountCartBloc>()
    //     .add(FetchDataCountCartItemEvent( idUser: idUser));
    if (i < 2) {
      Future.delayed(const Duration(seconds: 5), () {
        context
            .read<CountCartBloc>()
            .add(FetchDataCountCartItemEvent(idUser: idUser));
        i++;
        // setState(() {});
      });
    }
    return Container(
      height: 60,
      color: (widget.backgroundTransparent) ? Colors.transparent : mainColor,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              widget.onTap();
            },
            child: Icon(
              // Icons.arrow_back_rounded,
              Icons.arrow_back_ios_new_rounded,
              color: whiteColor,
            ),
          ),
          const SizedBox(width: 10),
          const Spacer(flex: 1),
          Text(widget.titlePage,
              style: TextStyle(
                  fontFamily: textMain,
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          const SizedBox(width: 10),
          const Spacer(flex: 1),
          (widget.showCard)
              ?
              //note: Cart
              GestureDetector(
                  onTap: () {
                    if (detectUser) {
                      navigation(context,
                          fromEvent:
                              GoToProductDetailsPage(idBook: widget.idBook),
                          toEvent: GoToCartPage());
                    } else {
                      // router.push(const SignInRoute());
                      navigation(context,
                          fromEvent:
                              GoToProductDetailsPage(idBook: widget.idBook),
                          toEvent: GoToSignInPage());
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
                                          shape: BoxShape.circle,
                                          color: redColor),
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
                      ],
                    ),
                  ),
                )
              : const SizedBox(
                  height: 32,
                  width: 30,
                )
        ],
      ),
    );
  }
}
