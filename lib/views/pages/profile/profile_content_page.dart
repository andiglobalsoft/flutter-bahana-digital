part of '../pages.dart';

class ProfileContentPage extends StatelessWidget {
  const ProfileContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Banner
              // Container(
              //   height: 128,
              //   width: MediaQuery.of(context).size.width,
              //   margin: const EdgeInsets.only(bottom: 18, top: 16),
              //   child: ListView.builder(
              //     itemCount: 2,
              //     padding: const EdgeInsets.symmetric(horizontal: 16),
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         height: 128,
              //         width: 266,
              //         margin: const EdgeInsets.symmetric(horizontal: 5),
              //         decoration: BoxDecoration(
              //             color: Colors.green,
              //             borderRadius: BorderRadius.circular(15)),
              //       );
              //     },
              //   ),
              // ),
              const SizedBox(height: 18),
              MenuButton(
                  titleMenu: 'Rak Buku',
                  icon: Icon(
                    Icons.menu_book_rounded,
                    color: whiteColor,
                  ),
                  onTap: () {
                    navigation(context,
                        fromEvent: const GoToMainPage(bottomNavBarIndex: 2),
                        toEvent: GoToBookshelfPage());
                  }),
              const SizedBox(height: 18),
              MenuButton(
                  titleMenu: 'Transaksi',
                  icon: Icon(
                    Icons.money_rounded,
                    color: whiteColor,
                  ),
                  onTap: () {
                    navigation(context,
                        fromEvent: const GoToMainPage(bottomNavBarIndex: 2),
                        toEvent: GoToTransactionPage());
                  }),
              const SizedBox(height: 18),

              // MenuButton(
              //     titleMenu: 'Voucher & Paket',
              //     icon: const Icon(Icons.abc),
              //     onTap: () {}),
              // const SizedBox(height: 18),
              // MenuButton(
              //     titleMenu: 'Poin Berhadiah',
              //     icon: const Icon(Icons.abc),
              //     onTap: () {}),
              // const SizedBox(height: 18),
              // MenuButton(
              //     titleMenu: 'Bantuan',
              //     icon: const Icon(Icons.abc),
              //     onTap: () {}),
              // const SizedBox(height: 18),
              // MenuButton(
              //     titleMenu: 'Rating Aplikasi',
              //     icon: const Icon(Icons.abc),
              //     onTap: () {}),
              // const SizedBox(height: 18),
              // MenuButton(
              //     titleMenu: 'Tentang',
              //     icon: const Icon(Icons.abc),
              //     onTap: () {}),
            ],
          ),
        )
      ],
    );
  }
}
