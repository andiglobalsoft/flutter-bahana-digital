part of '../pages.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<BaTransactionResult> _baTransactionResult =
        TransactionService.baTransaction('listtransaction',
            idUser: idUser,
            totalPay: '',
            idTransaction: '',
            idBook: '',
            status: '',
            discount: '',
            discountPrice: '',
            normalPrice: '');
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

            SafeArea(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(const Duration(seconds: 1), () {
                    _baTransactionResult = TransactionService.baTransaction(
                        'listtransaction',
                        idUser: idUser,
                        totalPay: '',
                        idTransaction: '',
                        idBook: '',
                        status: '',
                        discount: '',
                        discountPrice: '',
                        normalPrice: '');
                  });
                },
                child: FutureBuilder(
                  future: _baTransactionResult,
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      BaTransactionResult baTransactionResult =
                          snapshot.data as BaTransactionResult;

                      List<TransactionModel> transaction = baTransactionResult
                          .transaction as List<TransactionModel>;
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: transaction.length,
                          padding: const EdgeInsets.only(top: 100),
                          itemBuilder: (context, index) {
                            return listTransaction(context,
                                idTransaction: transaction[index].idTransaction,
                                invoice: transaction[index].invoice,
                                purchaseDate: transaction[index].purchaseDate,
                                statusTransaction:
                                    transaction[index].cartStatus,
                                cartStatus: transaction[index].cartStatus,
                                totalPaymentFormat:
                                    transaction[index].totalPaymentFormat);
                          });
                    } else {
                      if (snapshot.hasError) {
                        return Center(
                            child: Lottie.network(
                                'https://assets7.lottiefiles.com/private_files/lf30_hmqi5dfw.json'));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                  },
                ),
              ),
            )),
            SafeArea(
              child: HeaderBackArrowandTitlePage('Transaksi', onTap: () {
                navigationPop(context);
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget listTransaction(
    BuildContext context, {
    required String idTransaction,
    required String invoice,
    required String purchaseDate,
    required String statusTransaction,
    required String cartStatus,
    required String totalPaymentFormat,
  }) {
    return Container(
        height: 104,
        width: MediaQuery.of(context).size.width - 16,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  invoice.replaceAll('0000000', ''),
                  style: TextStyle(fontFamily: textMain, color: grayColor),
                ),
                Text(
                  purchaseDate,
                  style: TextStyle(fontFamily: textMain, color: grayColor),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Status', style: (TextStyle(fontFamily: textMain))),
                const SizedBox(width: 60),
                Text(cartStatus, style: textBold),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Total', style: (TextStyle(fontFamily: textMain))),
                const SizedBox(width: 70),
                Text(totalPaymentFormat, style: textPrice),
                const Spacer(flex: 1),
                GestureDetector(
                  onTap: () {
                    navigation(context,
                        fromEvent: GoToTransactionPage(),
                        toEvent: GoToDetailTransactionPage(
                            idTransaction: idTransaction));
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
        ));
  }
}
