part of '../pages.dart';

class AdsPrimary extends StatelessWidget {
  const AdsPrimary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdsBloc, AdsState>(
      builder: (context, state) {
        if (state is ListAdsLoaded) {
          List<AdsModel> adsModel = state.adsModel;
          if (adsModel.isEmpty) {
            return const SizedBox();
          } else {
            return Container(
              height: 125,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: adsModel.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      navigation(context,
                          fromEvent: const GoToMainPage(),
                          toEvent: GoToAdsDetailPage(
                              idAds: adsModel[index].idIklan, tag: 'primary'));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 16,
                      child: CachedNetworkImage(
                          imageUrl: adsModel[index].fileIklan,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: (layarPhoneTablet) ? 125 * 2 : 125,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: MediaQuery.of(context).size.width / 2 - 16,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.fill)),
                            );
                          },
                          placeholder: (context, img) {
                            return Container(
                              height: (layarPhoneTablet) ? 125 * 2 : 125,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: MediaQuery.of(context).size.width / 2 - 16,
                              decoration: BoxDecoration(
                                color: grayColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Container(
                              height: (layarPhoneTablet) ? 125 * 2 : 125,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: MediaQuery.of(context).size.width / 2 - 16,
                              decoration: BoxDecoration(
                                color: grayColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            );
                          }),
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class AdsSecond extends StatelessWidget {
  const AdsSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdssekunderBloc, AdssekunderState>(
        builder: (context, state) {
      if (state is ListAdssekunderLoaded) {
        List<AdsModel> adsModel = state.adsModel;
        if (adsModel.isEmpty) {
          return const SizedBox();
        } else {
          return Container(
            height: 125,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: ListView.builder(
              itemCount: adsModel.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    navigation(context,
                        fromEvent: const GoToMainPage(),
                        toEvent: GoToAdsDetailPage(
                            idAds: adsModel[index].idIklan, tag: 'sekunder'));
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 16,
                    child: CachedNetworkImage(
                        imageUrl: adsModel[index].fileIklan,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: (layarPhoneTablet) ? 125 * 2 : 125,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: MediaQuery.of(context).size.width / 2 - 16,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.fill)),
                          );
                        },
                        placeholder: (context, img) {
                          return Container(
                            height: (layarPhoneTablet) ? 125 * 2 : 125,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: MediaQuery.of(context).size.width / 2 - 16,
                            decoration: BoxDecoration(
                              color: grayColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                            height: (layarPhoneTablet) ? 125 * 2 : 125,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: MediaQuery.of(context).size.width / 2 - 16,
                            decoration: BoxDecoration(
                              color: grayColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        }),
                  ),
                );
              },
            ),
          );
        }
      } else {
        return const SizedBox();
      }
    });
  }
}
