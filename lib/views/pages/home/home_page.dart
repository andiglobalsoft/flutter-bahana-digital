part of '../pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // if (adsshowDialog) {
    //   _adsshowDialog();
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Background Header
          Container(
            height: (layarPhoneTablet == true) ? 128 : 192,
            decoration: BoxDecoration(
                color: mainColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
          ),

          Container(
            padding: const EdgeInsets.only(top: 80),
            child: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 1), () {
                  context.read<BannerBloc>().add(FetchDataListBannerEvent());
                  context
                      .read<CategoryBahanaflixBloc>()
                      .add(FetchDataListCategoryBahanaflixEvent());
                  context
                      .read<DataListEbookBloc>()
                      .add(FetchDataListEbookEvent());
                  context
                      .read<CountCartBloc>()
                      .add(FetchDataCountCartItemEvent(idUser: idUser));
                });
              },
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: const [
                  //Banner
                  SizedBox(height: 10),
                  BannerPrimaryPage(),
                  // SizedBox(height: 100),

                  //Kouta Package

                  //Category
                  HomeCategoryPage(),

                  //Promo Package
                  // HomePackagePage(),
                  // SizedBox(height: 24),

                  //List Flash Sale
                  // ListCardProductWidget(
                  //   titleCardList: 'Flash Sale',
                  //   eBookDigital: false,
                  //   flashSale: true,
                  // ),
                  // SizedBox(height: 24),

                  //List Book Digital New
                  MagazineProductPage(),
                  SizedBox(height: 24),

                  //Ads Primary
                  AdsPrimary(),
                  SizedBox(height: 24),

                  //List Book hasil_renungan
                  AfterthoughtEbookProductPage(),
                  SizedBox(height: 24),

                  //List Book Digital Rent
                  HomeListRentEbookProductPage(),
                  SizedBox(height: 24),

                  //Ads Second
                  AdsSecond(),
                  SizedBox(height: 24),

                  //List  Book Digital Buy
                  HomeListBuyEbookProductPage(),
                  SizedBox(height: 100)
                ],
              ),
            ),
          ),

          // Header App Bar
          const HeaderSearchChatandCartWidgets(),
        ],
      ),
    );
  }

  // _adsshowDialog() async {
  //   adsshowDialog = false;
  //   await Future.delayed(const Duration(milliseconds: 50));
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 230),
  //           color: whiteColor,
  //         );
  //       });
  // }
}
