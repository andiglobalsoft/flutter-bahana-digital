part of '../pages.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({Key? key}) : super(key: key);

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

          //Content
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
            child: FutureBuilder(
              future: EventService.getTiketEvent('listsudahdibeli'),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<TiketEventModel> tiketEventModel =
                      snapshot.data as List<TiketEventModel>;

                  return ListView.builder(
                    itemCount: tiketEventModel.length,
                    itemBuilder: (context, index) {
                      return cardTiket(
                          img: tiketEventModel[index].filePromo,
                          namaPromo: tiketEventModel[index].namaPromo,
                          tanggalAcaraEvent:
                              tiketEventModel[index].tanggalAcaraEvent,
                          deskripsiPromo: tiketEventModel[index].deskripsiPromo,
                          ketEvent: tiketEventModel[index].ketEvent,
                          linkPromo: tiketEventModel[index].linkPromo);
                    },
                  );
                } else {
                  if (snapshot.hasError) {
                    return Center(
                      child:
                          Text('Belum Mempunyai Tiket Acara', style: textGray),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          )),

          //header
          SafeArea(
            child: HeaderBackArrowandTitlePage('Tiket',
                onTap: () => navigationPop(context)),
          )
        ]),
      ),
    );
  }

  Widget cardTiket(
      {required String img,
      namaPromo,
      deskripsiPromo,
      ketEvent,
      tanggalAcaraEvent,
      linkPromo}) {
    return GestureDetector(
      onTap: () async {
        if (ketEvent != 'Event akan datang') {
          await canLaunch(linkPromo) ? launch(linkPromo) : log("Can't open");
        }
      },
      child: Column(
        children: [
          ClipPath(
            clipper: ClipPathTiketTop(),
            child: Container(
              height: 114,
              width: double.infinity,
              decoration: BoxDecoration(
                color: grayColor,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: NetworkImage(img), fit: BoxFit.cover),
              ),
            ),
          ),
          ClipPath(
            clipper: ClipPathTiketBottom(),
            child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      namaPromo,
                      style: textBold.copyWith(color: whiteColor),
                    ),
                    Text(
                      tanggalAcaraEvent,
                      style: TextStyle(
                          fontFamily: textMain,
                          fontStyle: FontStyle.italic,
                          color: whiteColor),
                    ),
                    Text(
                      deskripsiPromo,
                      style: TextStyle(fontFamily: textMain, color: whiteColor),
                    ),
                    const SizedBox(height: 10),
                    Center(
                        child: Text(ketEvent,
                            style: textBold.copyWith(color: whiteColor))),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class ClipPathTiketBottom extends CustomClipper<Path> {
  // final double right;
  // final double holeRadius;
  // const ClipPathTiket({required this.right, required this.holeRadius});

  // @override
  // Path getClip(Size size) {
  //   final path = Path()
  //     ..moveTo(0, 0)
  //     ..lineTo(size.width - right - holeRadius, 0.0)
  //     ..arcToPoint(
  //       Offset(size.width - right, 0),
  //       clockwise: false,
  //       radius: const Radius.circular(1),
  //     )
  //     ..lineTo(size.width, 0.0)
  //     ..lineTo(size.width, size.height)
  //     ..lineTo(size.width - right, size.height)
  //     ..arcToPoint(
  //       Offset(size.width - right - holeRadius, size.height),
  //       clockwise: false,
  //       radius: const Radius.circular(1),
  //     );
  //   path.lineTo(0.0, size.height);
  //   path.close();
  //   return path;
  // }
  double radius = 15;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width - radius, radius, size.width - radius, 0);
    path.lineTo(radius, 0);
    path.quadraticBezierTo(radius, radius, 0, radius);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class ClipPathTiketTop extends CustomClipper<Path> {
  double radius = 15;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(radius, size.height - radius, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(size.width - radius, size.height - radius,
        size.width, size.height - radius);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
