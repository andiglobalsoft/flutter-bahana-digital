part of '../pages.dart';

class DetailEventPage extends StatefulWidget {
  final String idPromo;
  const DetailEventPage(this.idPromo, {Key? key}) : super(key: key);

  @override
  State<DetailEventPage> createState() => _DetailEventPageState();
}

class _DetailEventPageState extends State<DetailEventPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController namaSertifikat = TextEditingController();

    final formKey = GlobalKey<FormState>();
    late bool eventFree;
    late String hargaTotal;

    return Scaffold(
      body: Stack(children: [
        //Background
        Container(color: mainColor),
        SafeArea(child: Container(color: backgroundPhoneColor)),

        SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: FutureBuilder(
            future: EventService.getEvent('listevent', idPromo: widget.idPromo),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<EventModel> eventModel = snapshot.data as List<EventModel>;

                return ListView.builder(
                  itemCount: eventModel.length,
                  itemBuilder: (context, index) {
                    eventFree =
                        (eventModel[index].hargaEvent == 'Rp0') ? true : false;
                    hargaTotal =
                        eventModel[index].hargaEvent!.replaceAll('Rp', '');
                    return Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(eventModel[index].namaPromo!,
                                      style: textBold),
                                  Text(eventModel[index].tanggalAcaraEvent!,
                                      style: TextStyle(
                                          fontFamily: textMain,
                                          fontStyle: FontStyle.italic,
                                          color: grayColor)),
                                  Text(eventModel[index].deskripsiPromo!,
                                      style: TextStyle(fontFamily: textMain)),
                                  Text(
                                      (eventModel[index].hargaEvent == 'Rp0')
                                          ? 'Gratis'
                                          : eventModel[index].hargaEvent!,
                                      style:
                                          textBold.copyWith(color: mainColor)),
                                  const SizedBox(height: 20),
                                  Text(
                                    '*Nama ini akan Dicantumkan di Sertifikat',
                                    style: TextStyle(fontFamily: textMain),
                                  ),
                                  Form(
                                      key: formKey,
                                      child: TextFormField(
                                        controller: namaSertifikat,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: TextStyle(
                                            fontFamily: textMain, height: 1),
                                        decoration: InputDecoration(
                                            fillColor: whiteColor,
                                            isDense: true,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            hintText: 'Nama Lengkap',
                                            hintStyle: TextStyle(
                                              fontFamily: textMain,
                                              fontSize: 14,
                                              height: 1,
                                              color: grayColor,
                                            )),
                                        validator: (val) {
                                          return (val != '')
                                              ? null
                                              : 'Nama Anda Masih Kosong';
                                        },
                                      ))
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
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        )),

        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () async {
              if (formKey.currentState!.validate()) {
                if (eventFree) {
                  log('Gratis');
                  AddTransaksiEventModel addTransaksiEventModel =
                      await EventService.addTransaksiEventFree('addfreeevent',
                          idPromo: widget.idPromo,
                          eventNamaTransaksi: namaSertifikat.text,
                          jumlahbayar: '0');

                  if (addTransaksiEventModel.pesan ==
                      'Berhasil menambahkan transaksi! ') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return showDialogSucced();
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(addTransaksiEventModel.pesan),
                            actions: [
                              TextButton(
                                child: const Text('Mengerti'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }
                } else {
                  log('bayar');
                  AddTransaksiEventModel addTransaksiEventModel =
                      await EventService.addTransaksiEvent('addtransaksievent',
                          idPromo: widget.idPromo,
                          eventNamaTransaksi: namaSertifikat.text,
                          jumlahbayar: hargaTotal.replaceAll('.', ''));

                  if (addTransaksiEventModel.pesan ==
                      'Berhasil menambahkan transaksi! ') {
                  } else {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(addTransaksiEventModel.pesan),
                            actions: [
                              TextButton(
                                child: const Text('Mengerti'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }
                }
              }
            },
            child: Container(
              height: 40,
              width: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 8, left: 26, right: 26),
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(8)),
              child: Text(
                'Daftar',
                style: textBold.copyWith(color: whiteColor),
              ),
            ),
          ),
        ),

        //header
        SafeArea(
          child: HeaderBackArrowandTitlePage('Detail Acara',
              onTap: () => navigationPop(context)),
        )
      ]),
    );
  }

  Widget showDialogSucced() {
    return AlertDialog(
      title: SizedBox(
        height: 60,
        child: Lottie.network(
            'https://assets2.lottiefiles.com/packages/lf20_rgdnbvya.json'),
      ),
      content: Text(
        'Pendaftaran Anda Berhasil',
        style: TextStyle(fontFamily: textMain),
      ),
      actions: [
        TextButton(
          child: const Text('Oke'),
          onPressed: () {
            Navigator.of(context).pop();
            navigation(context,
                fromEvent: const GoToMainPage(bottomNavBarIndex: 2),
                toEvent: GoToEventPage());
          },
        ),
      ],
    );
  }
}
