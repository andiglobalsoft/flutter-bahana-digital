part of '../pages.dart';

class EventSertifikatPage extends StatelessWidget {
  const EventSertifikatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Background
          Container(color: mainColor),
          SafeArea(child: Container(color: backgroundPhoneColor)),

          //Content
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: FutureBuilder(
              future: EventService.getSertifikat('sertifikat'),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  List<SertifikatEventModel> sertifikatEventModel =
                      snapshot.data as List<SertifikatEventModel>;

                  return ListView.builder(
                    itemCount: sertifikatEventModel.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 130,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: grayColor,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    sertifikatEventModel[index].filePromo),
                                fit: BoxFit.cover)),
                        child: Container(
                          height: 130,
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 4),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                                begin: const FractionalOffset(0.0, 1.0),
                                end: const FractionalOffset(0.0, 0.0),
                                stops: const [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(sertifikatEventModel[index].namaPromo,
                                style: textBold.copyWith(color: whiteColor)),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  if (snapshot.hasError) {
                    return Center(
                      child:
                          Text('Sertifikat Anda Belum Ada!', style: textGray),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          )),

          //header
          SafeArea(
            child: HeaderBackArrowandTitlePage('Sertifikat',
                onTap: () => navigationPop(context)),
          )
        ],
      ),
    );
  }
}
