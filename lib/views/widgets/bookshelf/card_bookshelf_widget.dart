part of '../widgets.dart';

class CardBookShelfWidget extends StatelessWidget {
  final String idBook;
  final String title;
  final String writer;
  final String cover;
  final String category;
  final String urlPdf;
  const CardBookShelfWidget(
      {required this.idBook,
      required this.title,
      required this.writer,
      required this.cover,
      required this.category,
      required this.urlPdf,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          String format = urlPdf.split('.').last;
          if (format == 'pdf') {
            navigation(context,
                fromEvent: const GoToMainPage(bottomNavBarIndex: 1),
                toEvent: GoToPDFViewPage(urlPdf: urlPdf));
          } else if (format == 'epub') {
            navigation(context,
                fromEvent: const GoToMainPage(bottomNavBarIndex: 1),
                toEvent: GoToEpubViewPage(idBook: idBook, url: urlPdf));
          }
        },
        child: SizedBox(
          width: 150,
          child: Card(
            elevation: 4,
            color: whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _imageProduct(cover),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(title,
                      style: TextStyle(fontFamily: textMain),
                      // textAlign: TextAlign.justify,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(writer,
                      style: textGray,
                      maxLines: 1,
                      overflow: TextOverflow.clip),
                )
              ],
            ),
          ),
        ));
  }

  _imageProduct(String imageUrl) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) {
          return Container(
            height: 170,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          );
        },
        placeholder: (context, img) {
          return Container(
            height: 170,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/PlaceholderImageProduct.jpeg'),
                    fit: BoxFit.cover)),
          );
        },
        errorWidget: (context, url, error) {
          return Container(
              height: 170,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage('assets/images/ErrorImageProduct.png'),
                      fit: BoxFit.cover)));
        });
  }
}
