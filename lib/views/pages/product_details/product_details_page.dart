part of '../pages.dart';

class ProductDetailsPage extends StatefulWidget {
  final String idBook;
  const ProductDetailsPage({required this.idBook, Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 2), () {
    //   setState(() {});
    // });
    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            //Background
            // Container(color: mainColor),
            Container(color: backgroundPhoneColor),
            SafeArea(child: Container(color: backgroundPhoneColor)),

            //Content
            ProductDetailsContentPage(idBook: widget.idBook),

            SafeArea(
                child: HeaderBackArrowandTitlePage(
              '',
              backgroundTransparent: true,
              idBook: widget.idBook,
              showCard: true,
              onTap: () {
                navigationPop(context);
              },
            )),
          ],
        ),
      ),
    );
  }
}
