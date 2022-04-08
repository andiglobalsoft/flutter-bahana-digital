part of '../pages.dart';

class DetailTransaksiEventPage extends StatefulWidget {
  final String idTransaksi;
  const DetailTransaksiEventPage({required this.idTransaksi, Key? key})
      : super(key: key);

  @override
  State<DetailTransaksiEventPage> createState() =>
      _DetailTransaksiEventPageState();
}

class _DetailTransaksiEventPageState extends State<DetailTransaksiEventPage> {
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
            padding: const EdgeInsets.only(top: 100),
            child: FutureBuilder(
              future: EventService.getListDetailTransaksi(
                  'listevent_transaction',
                  idTransaksi: widget.idTransaksi),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ListDetailTransaksiModel listTransaksiModel =
                      snapshot.data as ListDetailTransaksiModel;
                  return ListView(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 36,
                        margin: const EdgeInsets.only(left: 16, right: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Transaksi',
                                    style: TextStyle(
                                        fontFamily: textMain,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(flex: 1),
                                Text(
                                    listTransaksiModel
                                        .result[0].keteranganStatus,
                                    style: TextStyle(
                                        fontFamily: textMain,
                                        color: {'7', '3'}.contains(
                                                listTransaksiModel
                                                    .result[0].statusTransaksi)
                                            ? mainColor
                                            : {'9'}.contains(listTransaksiModel
                                                    .result[0].statusTransaksi)
                                                ? redColor
                                                : grayColor,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const Divider(thickness: 1),
                            Row(
                              children: [
                                Text('Nomor Invoice',
                                    style: TextStyle(
                                        fontFamily: textMain,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(flex: 1),
                                Text(listTransaksiModel.result[0].invoice,
                                    style: TextStyle(fontFamily: textMain)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 36,
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Detail Produk',
                                style: TextStyle(
                                    fontFamily: textMain,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            const Divider(thickness: 1),
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
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
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, left: 4, right: 4),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              listTransaksiModel
                                                  .result[0].namaPromo,
                                              style: textBold),
                                          Text(
                                              listTransaksiModel
                                                  .result[0].tanggalAcaraEvent,
                                              style: TextStyle(
                                                  fontFamily: textMain,
                                                  fontStyle: FontStyle.italic,
                                                  color: grayColor)),
                                          Text(
                                              listTransaksiModel
                                                  .result[0].deskripsiPromo,
                                              style: TextStyle(
                                                  fontFamily: textMain)),
                                          Text(
                                              (listTransaksiModel.result[0]
                                                          .hargaFormat ==
                                                      'Rp0')
                                                  ? 'Gratis'
                                                  : listTransaksiModel
                                                      .result[0].hargaFormat,
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
                                      image: DecorationImage(
                                          image: NetworkImage(listTransaksiModel
                                              .result[0].filePromo),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(thickness: 1),
                            Row(
                              children: [
                                Text('Total Harga : ',
                                    style: TextStyle(fontFamily: textMain)),
                                Text(listTransaksiModel.result[0].hargaFormat,
                                    style: textPrice)
                              ],
                            )
                          ],
                        ),
                      ),
                      (listTransaksiModel.result[0].statusPayment == '0')
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 26),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    navigation(context,
                                        fromEvent: GoToDetailTransaksiEventPage(
                                            idTransaksi: widget.idTransaksi),
                                        toEvent: GoToPaymentEventPage(
                                          idTransaksi: widget.idTransaksi,
                                          noInvoice: listTransaksiModel
                                              .result[0].invoice,
                                        ));
                                  },
                                  child: const Text('Lanjutkan Pembayaran')),
                            )
                          : (listTransaksiModel.result[0].statusPayment == '1')
                              ? ({'1', '2'}.contains(listTransaksiModel
                                      .result[0].statusTransaksi))
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 26),
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            String url = listTransaksiModel
                                                .result[0].urlPayment;

                                            navigation(context,
                                                fromEvent:
                                                    GoToDetailTransaksiEventPage(
                                                        idTransaksi:
                                                            widget.idTransaksi),
                                                toEvent:
                                                    GoToTransactionMidtransPage(
                                                        url: url));
                                          },
                                          child: const Text(
                                              'Lanjutkan Pembayaran')),
                                    )
                                  : const SizedBox()
                              : Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          36,
                                      margin: const EdgeInsets.all(16),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: whiteColor),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Info Pembayaran',
                                              style: TextStyle(
                                                  fontFamily: textMain,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          const Divider(thickness: 1),
                                          Row(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            listTransaksiModel
                                                                .dataTransaksiEvent
                                                                .iconPayment))),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(listTransaksiModel
                                                  .dataTransaksiEvent
                                                  .metodePembayaran),
                                              const Spacer(),
                                              Text(listTransaksiModel
                                                  .dataTransaksiEvent
                                                  .penerimaPayment)
                                            ],
                                          ),
                                          Text('Nomer Rekening : ' +
                                              listTransaksiModel
                                                  .dataTransaksiEvent
                                                  .nomorPayment)
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          String url =
                                              "https://wa.me/${listTransaksiModel.dataTransaksiEvent.nomorTelp}/?text=${Uri.parse(listTransaksiModel.dataTransaksiEvent.pesan.toString())}";
                                          await canLaunch(url)
                                              ? launch(url)
                                              : log("Can't open whatsapp");
                                        },
                                        child:
                                            const Text('Lakukan Konfirmasi')),
                                  ],
                                ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          )),
          //header
          SafeArea(
            child: HeaderBackArrowandTitlePage('Detail Transaksi',
                onTap: () => navigationPop(context)),
          )
        ],
      )),
    );
  }
}
