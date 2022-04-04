part of '../pages.dart';

class DataEventPage extends StatefulWidget {
  const DataEventPage({Key? key}) : super(key: key);

  @override
  State<DataEventPage> createState() => _DataEventPageState();
}

class _DataEventPageState extends State<DataEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        //Background
        Container(color: mainColor),
        SafeArea(child: Container(color: backgroundPhoneColor)),

        //Conten
        SafeArea(
            child: FutureBuilder(
          future: EventService.getEvent('listevent'),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> eventModel = snapshot.data as List<EventModel>;

              return Padding(
                padding: const EdgeInsets.only(top: 60),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: eventModel.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          navigation(context,
                              fromEvent: GoToDataEventPage(),
                              toEvent: GoToDetailEventPage(
                                  eventModel[index].idPromo));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 20, left: 16, right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3)),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 116),
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            eventModel[index].filePromo!))),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(eventModel[index].namaPromo!,
                                          style: textBold),
                                      Text(eventModel[index].tanggalAcaraEvent!,
                                          style: TextStyle(
                                              fontFamily: textMain,
                                              fontStyle: FontStyle.italic,
                                              color: grayColor)),
                                      Text(eventModel[index].deskripsiPromo!,
                                          style:
                                              TextStyle(fontFamily: textMain)),
                                      Text(
                                          (eventModel[index].hargaEvent ==
                                                  'Rp0')
                                              ? 'Gratis'
                                              : eventModel[index].hargaEvent!,
                                          style: textBold.copyWith(
                                              color: mainColor)),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 130,
                                decoration: BoxDecoration(
                                  color: grayColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                ),
              );
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Saat Ini Belum Ada Acara Yang Tersedia',
                      style: textGray),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }
          },
        )),

        //header
        SafeArea(
          child: HeaderBackArrowandTitlePage('Acara',
              onTap: () => navigationPop(context)),
        )
      ]),
    );
  }
}
