part of '../pages.dart';

class AdsDetailPage extends StatelessWidget {
  final String tag;
  final String idAds;
  const AdsDetailPage({required this.tag, required this.idAds, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Scaffold(
          body: Stack(
        children: [
          //Background
          Container(color: mainColor),
          SafeArea(child: Container(color: backgroundPhoneColor)),

          SafeArea(
            child: FutureBuilder(
              future: AdsService.ads(tag: tag, idAds: idAds),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<AdsModel> adsModel = snapshot.data as List<AdsModel>;
                  return ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 100),
                    children: [
                      CachedNetworkImage(
                          imageUrl: adsModel[0].fileIklan,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    image:
                                        DecorationImage(image: imageProvider)));
                          },
                          placeholder: (context, img) {
                            return Container(
                              height: 200,
                              width: 200,
                              color: grayColor,
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Container(
                              height: 200,
                              width: 200,
                              color: grayColor,
                            );
                          }),
                      const SizedBox(height: 10),
                      Text(
                        adsModel[0].namaIklan,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(adsModel[0].statusIklan),
                      const SizedBox(height: 10),
                      (adsModel[0].linkIklan.isEmpty)
                          ? const SizedBox()
                          : ElevatedButton(
                              onPressed: () async {
                                await canLaunch(adsModel[0].linkIklan)
                                    ? launch(adsModel[0].linkIklan)
                                    : log("Can't open ");
                              },
                              child: const Text('Buka'))
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),

          SafeArea(
            child: HeaderBackArrowandTitlePage('', onTap: () {
              navigationPop(context);
            }),
          )
        ],
      )),
    );
  }
}
