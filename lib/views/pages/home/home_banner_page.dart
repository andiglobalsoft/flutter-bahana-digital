part of '../pages.dart';

class BannerPrimaryPage extends StatelessWidget {
  const BannerPrimaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, bannerModelState) {
        if (bannerModelState is ListBannerLoaded) {
          List<BannerModel> bannerModel = bannerModelState.bannerModel;
          if (bannerModel.isEmpty) {
            return const SizedBox();
          } else {
            return SizedBox(
              height: 130,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: bannerModel.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      if (bannerModel[index].link.isNotEmpty) {
                        await canLaunch(bannerModel[index].link)
                            ? launch(bannerModel[index].link)
                            : log("Can't open");
                      }
                    },
                    child: CachedNetworkImage(
                        imageUrl: bannerModel[index].image,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width - 60,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          );
                        },
                        placeholder: (context, img) {
                          return Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width - 60,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image:
                                        AssetImage('assets/images/banner.png'),
                                    fit: BoxFit.cover)),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width - 60,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image:
                                        AssetImage('assets/images/banner.png'),
                                    fit: BoxFit.cover)),
                          );
                        }),
                  );
                },
              ),
            );
          }
        } else {
          return const LoadedBanner();
        }
      },
    );
  }
}
