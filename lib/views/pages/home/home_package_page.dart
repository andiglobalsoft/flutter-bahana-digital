part of '../pages.dart';

class HomePackagePage extends StatefulWidget {
  const HomePackagePage({Key? key}) : super(key: key);

  @override
  _HomePackagePageState createState() => _HomePackagePageState();
}

class _HomePackagePageState extends State<HomePackagePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 148,
        width: MediaQuery.of(context).size.width - (16 * 2),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(children: [
          //Image
          Container(
            height: 148,
            width: 106,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: AssetImage('assets/images/PackagePromo.jpeg'),
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(4, 0),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Beli Paket',
                    style: TextStyle(
                        fontFamily: textMain,
                        height: 1,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 110,
                width: MediaQuery.of(context).size.width - (16 * 2) - 126,
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 15,
                        crossAxisSpacing: (layarPhoneTablet) ? 58 : 10,
                        crossAxisCount: (layarPhoneTablet) ? 4 : 2,
                        childAspectRatio: 3 / 1),
                    itemCount: 4,
                    itemBuilder: (_, index) {
                      return const CategoryPackageTypePage(namePackage: 'tes');
                    }),
              )
            ],
          )
        ]));
  }
}
