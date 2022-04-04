part of '../pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void lauchWhatsapp() async {
    CustomerServiceResult customerServiceResult =
        await CustomerServiceService.customerService();
    String url =
        "https://wa.me/${customerServiceResult.noCustomerService}/?text=";
    await canLaunch(url) ? launch(url) : log("Can't open whatsapp");
  }

  @override
  Widget build(BuildContext context) {
    Future<AuthenticationResult> authenticationResult =
        AuthenticationServices.getUser(idUser);
    if (!detectUser) {
      navigation(context,
          fromEvent: const GoToMainPage(), toEvent: GoToSignInPage());
    }
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1), () {
          authenticationResult = AuthenticationServices.getUser(idUser);
          setState(() {});
        });
      },
      child: FutureBuilder(
          future: authenticationResult,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              AuthenticationResult authenticationResult =
                  snapshot.data as AuthenticationResult;

              if (authenticationResult.statusCode == 200) {
                UserModel userModel =
                    authenticationResult.userModel as UserModel;
                return SafeArea(
                  child: Stack(
                    children: [
                      //Background
                      SafeArea(child: Container(color: backgroundPhoneColor)),

                      ListView(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 60, bottom: 50),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: userModel.imageProfile,
                                imageBuilder: (context, imageProvider) {
                                  return CircleAvatar(
                                      radius: 40,
                                      backgroundImage: imageProvider);
                                },
                                placeholder: (context, img) {
                                  return const CircleAvatar(
                                      radius: 40,
                                      backgroundImage: AssetImage(
                                          'assets/images/ImgDefaul.png'));
                                },
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userModel.name[0].toUpperCase() +
                                        userModel.name.substring(1),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: textMain,
                                        fontWeight: FontWeight.bold,
                                        color: blackColor),
                                  ),
                                  Text(
                                    userModel.email,
                                    style: TextStyle(
                                        fontFamily: textMain,
                                        fontWeight: FontWeight.w500,
                                        color: grayColor),
                                  ),
                                  (userModel.statusReferal.trim() == 'Y')
                                      ? Text(userModel.baReferal,
                                          style: TextStyle(
                                              fontFamily: textMain,
                                              fontWeight: FontWeight.w500,
                                              color: grayColor))
                                      : ElevatedButton(
                                          onPressed: () {
                                            AuthenticationServices
                                                .generateReferal();
                                            Future.delayed(
                                                const Duration(seconds: 1), () {
                                              authenticationResult =
                                                  AuthenticationServices
                                                          .getUser(idUser)
                                                      as AuthenticationResult;

                                              setState(() {});
                                            });
                                          },
                                          child: const Text('Dapatkan Referal'))
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(thickness: 1),
                          const SizedBox(height: 20),
                          _buttonList(
                              icon: Icon(
                                Icons.edit_rounded,
                                color: whiteColor,
                              ),
                              titel: 'Ubah Data',
                              color: Colors.green,
                              onTap: () {
                                navigation(context,
                                    fromEvent: const GoToMainPage(
                                        bottomNavBarIndex: 2),
                                    toEvent: GoToEditProfilePage(
                                        nameUser: userModel.name,
                                        email: userModel.email,
                                        linkImage: userModel.imageProfile,
                                        noPhone: userModel.noPhone));
                              }),
                          // const SizedBox(height: 30),
                          // _buttonList(
                          //     icon: Icon(
                          //       Icons.menu_book_rounded,
                          //       color: whiteColor,
                          //     ),
                          //     titel: 'Rak Buku Saya',
                          //     color: Colors.amber,
                          //     onTap: () {
                          //       navigation(context,
                          //           fromEvent: const GoToMainPage(
                          //               bottomNavBarIndex: 2),
                          //           toEvent: GoToBookshelfPage());
                          //     }),
                          const SizedBox(height: 30),
                          _buttonList(
                              icon: Icon(
                                Icons.money_rounded,
                                color: whiteColor,
                              ),
                              titel: 'Transaksi',
                              color: Colors.amber,
                              onTap: () {
                                navigation(context,
                                    fromEvent: const GoToMainPage(
                                        bottomNavBarIndex: 2),
                                    toEvent: GoToTransactionPage());
                              }),
                          const SizedBox(height: 30),
                          _buttonList(
                              icon: Icon(
                                Icons.event,
                                color: whiteColor,
                                size: 30,
                              ),
                              titel: 'Acara',
                              color: Colors.blueAccent,
                              onTap: () {
                                navigation(context,
                                    fromEvent: const GoToMainPage(
                                        bottomNavBarIndex: 2),
                                    toEvent: GoToEventPage());
                              }),
                          const SizedBox(height: 30),
                          _buttonList(
                              icon: Icon(
                                Icons.account_circle,
                                color: whiteColor,
                              ),
                              titel: 'Pelayanan Pelanggan',
                              color: Colors.blue,
                              onTap: () {
                                lauchWhatsapp();
                              }),
                          const SizedBox(height: 30),
                          _buttonList(
                              icon: Icon(
                                Icons.info_outline_rounded,
                                color: whiteColor,
                                size: 30,
                              ),
                              titel: 'Lisensi',
                              color: Colors.blueGrey,
                              onTap: () async {
                                String url =
                                    "https://andipublisher.com/privacy_policy.html";
                                await canLaunch(url)
                                    ? launch(url)
                                    : log("Can't");
                              }),
                          const SizedBox(height: 30),
                          _buttonList(
                              icon: Icon(
                                Icons.help_outline,
                                color: whiteColor,
                                size: 30,
                              ),
                              titel: 'Tentang',
                              color: Colors.grey,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (builder) {
                                      return _showAboutDialog();
                                    });
                              }),
                          const SizedBox(height: 50),
                          const Divider(thickness: 1),
                          TextButton(
                              onPressed: () {
                                AuthenticationServices.signOut();
                                navigation(context,
                                    fromEvent: const GoToMainPage(),
                                    toEvent: GoToSignInPage());
                              },
                              child: Text(
                                'Keluar',
                                style: TextStyle(color: redColor),
                              ))
                        ],
                      ),

                      // const BackgroundProfileWidget(),

                      // const Padding(
                      //     padding: EdgeInsets.only(top: 200),
                      //     child: ProfileContentPage()),
                      // _buttonMore(context),
                      // //Pion
                      // // Positioned(
                      // //   top: 156,
                      // //   left: 18,
                      // //   child: Row(
                      // //     children: [
                      // //       Image.asset(
                      // //         'assets/icons/coinPoin.png',
                      // //         scale: 4,
                      // //       ),
                      // //       const SizedBox(width: 4),
                      // //       Text(
                      // //         '128',
                      // //         style: TextStyle(
                      // //             fontFamily: textMain,
                      // //             fontSize: 16,
                      // //             color: whiteColor,
                      // //             fontWeight: FontWeight.bold),
                      // //       )
                      // //     ],
                      // //   ),
                      // // ),
                      // Positioned(
                      //     top: 20,
                      //     left: 16,
                      //     child: Row(
                      //       children: [
                      //         SizedBox(
                      //           height: 90,
                      //           width: 80,
                      //           child: Stack(
                      //             children: [
                      //               CircleAvatar(
                      //                 radius: 40,
                      //                 backgroundImage:
                      //                     NetworkImage(userModel.imageProfile),
                      //               ),
                      //               Align(
                      //                 alignment: Alignment.bottomCenter,
                      //                 child: Container(
                      //                   height: 24,
                      //                   width: 24,
                      //                   decoration: BoxDecoration(
                      //                       color: redColor,
                      //                       shape: BoxShape.circle),
                      //                   child: Icon(
                      //                     Icons.close,
                      //                     color: whiteColor,
                      //                     size: 16,
                      //                   ),
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         const SizedBox(width: 10),
                      //         Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Row(
                      //               children: [
                      //                 Text(
                      //                   userModel.name,
                      //                   style: textTitleAppBar,
                      //                 ),
                      //                 Container(
                      //                   height: 18,
                      //                   width: 18,
                      //                   alignment: Alignment.center,
                      //                   decoration: BoxDecoration(
                      //                       color: redColor,
                      //                       shape: BoxShape.circle),
                      //                   child: Icon(
                      //                     Icons.edit_rounded,
                      //                     size: 16,
                      //                     color: whiteColor,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             const SizedBox(height: 4),
                      //             Text(
                      //               userModel.email,
                      //               style: textProfil,
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Text(
                      //                   userModel.noPhone,
                      //                   style: textProfil,
                      //                 ),
                      //                 const SizedBox(width: 4),
                      //                 Text(
                      //                   'Ubah',
                      //                   style: TextStyle(
                      //                       fontFamily: textMain,
                      //                       fontSize: 12,
                      //                       color: redColor,
                      //                       fontWeight: FontWeight.bold),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         )
                      //       ],
                      //     )),
                    ],
                  ),
                );
              } else {
                SharedPreferencesUser().deleteUser();
                return navigation(context,
                    fromEvent: const GoToMainPage(), toEvent: GoToSignInPage());
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget _showAboutDialog() {
    return AlertDialog(
      title: const Center(child: Text('Tentang Aplikasi')),
      content: Text(
        'Bahana Digital merupakan platform digital untuk saudara-saudara terkasih, terlebih bagi para pembaca setia majalah bahana. \n\n Versi Apps : $versiApp',
        textAlign: TextAlign.justify,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Tutup'))
      ],
    );
  }

  Widget _buttonList(
      {required String titel,
      required Color color,
      required Function onTap,
      required Icon icon}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Row(
        children: [
          Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: icon),
          Text(titel,
              style: TextStyle(
                  fontFamily: textMain,
                  fontWeight: FontWeight.w500,
                  color: blackColor))
        ],
      ),
    );
  }

  // Widget _buttonMore(BuildContext context) {
  //   return Positioned(
  //     top: 144,
  //     right: 58,
  //     child: GestureDetector(
  //       onTap: () {
  //         showModalBottomSheet<dynamic>(
  //             isScrollControlled: true,
  //             barrierColor: Colors.transparent,
  //             backgroundColor: Colors.transparent,
  //             context: context,
  //             builder: (_) {
  //               return SizedBox(
  //                 height: MediaQuery.of(context).size.height - 150,
  //                 child: Stack(children: [
  //                   Positioned(
  //                       bottom: 0,
  //                       child: GestureDetector(
  //                         onTap: () {
  //                           Navigator.pop(context);
  //                         },
  //                         child: Container(
  //                           color: whiteColor.withOpacity(0.8),
  //                           height: MediaQuery.of(context).size.height - 240,
  //                           width: MediaQuery.of(context).size.width,
  //                         ),
  //                       )),
  //                   Positioned(
  //                       top: 25,
  //                       right: 58,
  //                       child: Container(
  //                         height: 250,
  //                         width: 62,
  //                         decoration: BoxDecoration(
  //                             color: mainColor,
  //                             borderRadius: BorderRadius.circular(29)),
  //                         child: Column(
  //                           children: [
  //                             subListBtnMore(context, onTap: () {
  //                               Navigator.pop(context);
  //                             },
  //                                 icon: const Icon(Icons.close),
  //                                 padding: 14,
  //                                 color: whiteColor.withOpacity(0.4)),
  //                             const SizedBox(height: 56),
  //                             //Add Address Home
  //                             // subListBtnMore(context,
  //                             //     onTap: () {},
  //                             //     icon: Icon(
  //                             //       Icons.add_location_rounded,
  //                             //       color: mainColor,
  //                             //     ),
  //                             //     padding: 12,
  //                             //     color: whiteColor),
  //                             const SizedBox(height: 12),
  //                             subListBtnMore(context,
  //                                 onTap: () {},
  //                                 icon: Icon(
  //                                   Icons.vpn_key_rounded,
  //                                   color: mainColor,
  //                                 ),
  //                                 padding: 12,
  //                                 color: whiteColor),
  //                             const SizedBox(height: 12),
  //                             subListBtnMore(context, onTap: () {
  //                               AuthenticationServices.signOut();
  //                               Navigator.pop(context);
  //                               navigation(context,
  //                                   fromEvent: const GoToMainPage(),
  //                                   toEvent: GoToSignInPage());
  //                             },
  //                                 icon: Icon(
  //                                   Icons.logout_rounded,
  //                                   color: mainColor,
  //                                 ),
  //                                 padding: 12,
  //                                 color: whiteColor),
  //                           ],
  //                         ),
  //                       ))
  //                 ]),
  //               );
  //             });
  //       },
  //       child: Container(
  //           height: 62,
  //           width: 62,
  //           padding: const EdgeInsets.only(bottom: 16),
  //           decoration: BoxDecoration(
  //             color: mainColor,
  //             shape: BoxShape.circle,
  //             boxShadow: [
  //               BoxShadow(
  //                 color: grayColor,
  //                 blurRadius: 8,
  //                 offset: const Offset(2, 2),
  //               ),
  //             ],
  //           ),
  //           child: Image.asset(
  //             'assets/icons/details-more.png',
  //             scale: 4,
  //             alignment: Alignment.bottomCenter,
  //           )),
  //     ),
  //   );
  // }

  Widget subListBtnMore(BuildContext context,
      {required Function onTap,
      required Icon icon,
      required double padding,
      required Color color}) {
    return ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: EdgeInsets.all(padding),
            primary: color),
        child: icon);
  }
}
