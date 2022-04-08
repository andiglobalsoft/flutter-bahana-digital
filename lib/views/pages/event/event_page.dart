part of '../pages.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Scaffold(
        body: Stack(children: [
          //Background
          Container(color: mainColor),
          SafeArea(child: Container(color: backgroundPhoneColor)),

          SafeArea(
              child: ListView(
            padding: const EdgeInsets.only(top: 100, left: 16),
            children: [
              _buttonList(
                titel: 'Acara',
                icon: const Icon(
                  Icons.event,
                  color: Colors.white,
                ),
                color: Colors.teal,
                onTap: () {
                  navigation(context,
                      fromEvent: GoToEventPage(), toEvent: GoToDataEventPage());
                },
              ),
              const SizedBox(height: 12),
              _buttonList(
                titel: 'Tiket',
                icon: const Icon(
                  Icons.discount_rounded,
                  color: Colors.white,
                ),
                color: Colors.teal,
                onTap: () {
                  navigation(context,
                      fromEvent: GoToEventPage(),
                      toEvent: GoToTicketEventPage());
                },
              ),
              const SizedBox(height: 12),
              _buttonList(
                titel: 'Transaksi',
                icon: const Icon(
                  Icons.compare_arrows_rounded,
                  color: Colors.white,
                ),
                color: Colors.teal,
                onTap: () {
                  navigation(context,
                      fromEvent: GoToEventPage(),
                      toEvent: GoToTransactionEventPage());
                },
              ),
              const SizedBox(height: 12),
              _buttonList(
                titel: 'Sertifikat',
                icon: const Icon(
                  Icons.document_scanner_outlined,
                  color: Colors.white,
                ),
                color: Colors.teal,
                onTap: () {
                  navigation(context,
                      fromEvent: GoToEventPage(),
                      toEvent: GoToEventSertifikatPage());
                },
              ),
              // const SizedBox(height: 12),
              // _buttonList(
              //   titel: 'Info',
              //   icon: const Icon(
              //     Icons.info_outline_rounded,
              //     color: Colors.white,
              //   ),
              //   color: Colors.teal,
              //   onTap: () {
              //     navigation(context,
              //         fromEvent: GoToEventPage(), toEvent: GoToInfoEventPage());
              //   },
              // ),
            ],
          )),

          //header
          SafeArea(
            child: HeaderBackArrowandTitlePage('Acara',
                onTap: () => navigationPop(context)),
          )
        ]),
      ),
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
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(right: 10),
                  decoration:
                      BoxDecoration(color: color, shape: BoxShape.circle),
                  child: icon),
              Text(titel,
                  style: TextStyle(
                      fontFamily: textMain,
                      fontWeight: FontWeight.w500,
                      color: blackColor))
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
