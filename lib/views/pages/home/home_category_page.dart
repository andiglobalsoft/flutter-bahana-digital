part of '../pages.dart';

class HomeCategoryPage extends StatefulWidget {
  final String idCategory;
  const HomeCategoryPage({this.idCategory = '', Key? key}) : super(key: key);

  @override
  _HomeCategoryPageState createState() => _HomeCategoryPageState();
}

class _HomeCategoryPageState extends State<HomeCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (layarPhoneTablet) ? 110 : 200,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: BlocBuilder<CategoryBahanaflixBloc, CategoryBahanaflixState>(
        builder: (context, listCategoryBahanaflixModelState) {
          if (listCategoryBahanaflixModelState is ListCategoryLoaded) {
            List<ListCategoryBahanaflixModel> listCategoryBahanaflixModel =
                listCategoryBahanaflixModelState.listCategoryBahanaflixModel;
            if (listCategoryBahanaflixModel.isEmpty) {
              return const SizedBox();
            } else {
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: (layarPhoneTablet) ? 14 : 8,
                      crossAxisCount: (layarPhoneTablet) ? 10 : 4),
                  itemCount: (listCategoryBahanaflixModel.length >= 8)
                      ? (layarPhoneTablet)
                          ? 10
                          : 8
                      : listCategoryBahanaflixModel.length,
                  itemBuilder: (_, index) {
                    if ((layarPhoneTablet) ? index == 9 : index == 7) {
                      return IconCategoryWidget(
                        idCategory: 'idCategory',
                        name: 'Lainnya',
                        image: 'assets/icons/Lainnya.png',
                        imagelocal: true,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (context) => _buildSheet());
                        },
                      );
                    } else {
                      return IconCategoryWidget(
                          idCategory:
                              listCategoryBahanaflixModel[index].idCategory,
                          name: listCategoryBahanaflixModel[index].name,
                          image: listCategoryBahanaflixModel[index].icon,
                          onTap: () {
                            navigation(context,
                                fromEvent: const GoToMainPage(),
                                toEvent: GoToMorePage(
                                    tag: 'kategoricari',
                                    idCategory:
                                        listCategoryBahanaflixModel[index]
                                            .idCategory));
                          });
                    }
                  });
            }
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  _iconCategory(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: 28,
          width: 28,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        );
      },
      placeholder: (context, img) {
        return Container(
          height: 28,
          width: 28,
          decoration: BoxDecoration(
              color: grayColor, borderRadius: BorderRadius.circular(10)),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          height: 28,
          width: 28,
          decoration: BoxDecoration(
              color: grayColor, borderRadius: BorderRadius.circular(10)),
        );
      },
    );
  }

  Widget _buildSheet() => DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) => Container(
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            child: ListView(
              controller: controller,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Kategori Lainnya',
                      style: TextStyle(
                          fontFamily: textMain,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
                BlocBuilder<CategoryBahanaflixBloc, CategoryBahanaflixState>(
                  builder: (context, listCategoryBahanaflixModelState) {
                    if (listCategoryBahanaflixModelState
                        is ListCategoryLoaded) {
                      List<ListCategoryBahanaflixModel>
                          listCategoryBahanaflixModel =
                          listCategoryBahanaflixModelState
                              .listCategoryBahanaflixModel;

                      return ListView.builder(
                        itemCount: listCategoryBahanaflixModel.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              navigation(context,
                                  fromEvent: const GoToMainPage(),
                                  toEvent: GoToMorePage(
                                      tag: 'kategori',
                                      idCategory:
                                          listCategoryBahanaflixModel[index]
                                              .idCategory));
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      _iconCategory(
                                          listCategoryBahanaflixModel[index]
                                              .icon),
                                      const SizedBox(width: 10),
                                      Text(
                                        listCategoryBahanaflixModel[index]
                                                .name +
                                            ' ' +
                                            '(' +
                                            listCategoryBahanaflixModel[index]
                                                .countBook +
                                            ')',
                                        style: TextStyle(fontFamily: textMain),
                                      )
                                    ],
                                  ),
                                  const Divider(thickness: 1)
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ));
}
