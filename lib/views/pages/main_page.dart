part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int bottomNavBarIndex;
  const MainPage({this.bottomNavBarIndex = 0, Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavBarIndex = 0;
  final List _listOfText = const [
    HomePage(),
    BookshelfPage(),
    // PromoPage(),
    // NotificationsPage(),
    ProfilePage()
  ];
  // late DateTime _lastQuitTime;
  @override
  void initState() {
    _bottomNavBarIndex = widget.bottomNavBarIndex;

    SharedPreferencesUser().getIdUser().then((value) {
      log('User Id : $value');
      detectUser = (value.isEmpty) ? false : true;
    });

    super.initState();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Keluar'),
            content: const Text('Apa anda yakin ingin keluar dari aplikasi'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            layarPhoneTablet = (constraints.maxWidth > 600) ? true : false;
            log('Is device Large Screen : $layarPhoneTablet');
            return Stack(children: [
              Container(color: mainColor),
              SafeArea(child: Container(color: backgroundPhoneColor)),
              PageView(children: [_listOfText[_bottomNavBarIndex]]),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavigationBar(
                  currentIndex: _bottomNavBarIndex,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: mainColor,
                  selectedLabelStyle: textTitleNavBar,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_rounded), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.book_rounded), label: "Rak Buku"),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.label_rounded), label: "Promo"),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.notifications_active_rounded),
                    //     label: "Notifikasi"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person_rounded), label: "Profile")
                  ],
                  onTap: (index) {
                    setState(() {
                      _bottomNavBarIndex = index;
                    });
                  },
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
