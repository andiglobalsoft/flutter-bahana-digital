part of '../pages.dart';

class TransactionEventPage extends StatefulWidget {
  const TransactionEventPage({Key? key}) : super(key: key);

  @override
  State<TransactionEventPage> createState() => _TransactionEventPageState();
}

class _TransactionEventPageState extends State<TransactionEventPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Scaffold(
          body: Stack(
        children: [
          //Background
          Container(color: mainColor),
          SafeArea(child: Container(color: backgroundPhoneColor)),

          //Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: FutureBuilder(
                future: EventService.getListTransaksi('listtransaksi'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ListTransaksiModel> listTransaksiModel =
                        snapshot.data as List<ListTransaksiModel>;
                    return ListView.builder(
                      itemCount: listTransaksiModel.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width - 16,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    listTransaksiModel[index].invoice,
                                    style: TextStyle(
                                        fontFamily: textMain, color: grayColor),
                                  ),
                                  Text(
                                    listTransaksiModel[index].tanggalAcaraEvent,
                                    style: TextStyle(
                                        fontFamily: textMain,
                                        fontSize: 12,
                                        color: grayColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text('Acara',
                                      style: (TextStyle(fontFamily: textMain))),
                                  const SizedBox(width: 60),
                                  Text(listTransaksiModel[index].namaPromo,
                                      style: textBold),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text('Status',
                                      style: (TextStyle(fontFamily: textMain))),
                                  const SizedBox(width: 60),
                                  Text(
                                      listTransaksiModel[index]
                                          .ketStatusTransaksi,
                                      style: textBold.copyWith(
                                          color: (listTransaksiModel[index]
                                                      .statusTransaksi ==
                                                  '1')
                                              ? Colors.green
                                              : (listTransaksiModel[index]
                                                          .statusTransaksi ==
                                                      '7')
                                                  ? Colors.blue
                                                  : grayColor)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text('Total',
                                      style: (TextStyle(fontFamily: textMain))),
                                  const SizedBox(width: 70),
                                  Text(
                                      (listTransaksiModel[index].hargaNormal ==
                                              'Rp0')
                                          ? 'Gratis'
                                          : listTransaksiModel[index]
                                              .hargaNormal,
                                      style: textPrice),
                                  const Spacer(flex: 1),
                                  GestureDetector(
                                    onTap: () {
                                      navigation(context,
                                          fromEvent: GoToTransactionEventPage(),
                                          toEvent: GoToDetailTransaksiEventPage(
                                              idTransaksi: listTransaksiModel[0]
                                                  .idTransaksi));
                                    },
                                    child: Text('Lihat Detail',
                                        style: TextStyle(
                                            fontFamily: textMain,
                                            fontWeight: FontWeight.bold,
                                            color: mainColor)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(
                          child: Text('Belum melakukan transaksi apa pun',
                              style: TextStyle(fontFamily: textMain)));
                    }
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          //header
          SafeArea(
            child: HeaderBackArrowandTitlePage('Transaksi',
                onTap: () => navigationPop(context)),
          )
        ],
      )),
    );
  }
}
