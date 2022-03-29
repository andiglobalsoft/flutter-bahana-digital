part of '../widgets.dart';

class IconCategoryWidget extends StatelessWidget {
  final String idCategory;
  final String name;
  final String image;
  final bool imagelocal;
  final Function onTap;
  const IconCategoryWidget(
      {required this.idCategory,
      required this.name,
      required this.image,
      this.imagelocal = false,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          (imagelocal)
              ? Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                )
              : _iconCategory(image),
          const SizedBox(height: 2),
          SizedBox(
            height: 38,
            child: Center(
              child: Text(
                name,
                style: TextStyle(fontFamily: textMain, fontSize: 12),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          )
        ],
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
}
