part of 'pages_bloc.dart';

abstract class PagesState extends Equatable {
  const PagesState();

  @override
  List<Object> get props => [];
}

class PagesInitial extends PagesState {}

class OnMainPage extends PagesState {
  final int bottomNavBarIndex;
  const OnMainPage({required this.bottomNavBarIndex});

  @override
  List<Object> get props => [bottomNavBarIndex];
}

class OnSignInPage extends PagesState {
  @override
  List<Object> get props => [];
}

class OnSignUpPage extends PagesState {
  @override
  List<Object> get props => [];
}

class OnCartPage extends PagesState {
  @override
  List<Object> get props => [];
}

class OnEpubViewPage extends PagesState {
  final String idBook;
  final String url;
  const OnEpubViewPage({required this.idBook, required this.url});

  @override
  List<Object> get props => [idBook, url];
}

class OnBookshelfPage extends PagesState {
  @override
  List<Object> get props => [];
}

class OnAddPaymentPage extends PagesState {
  final AddPaymentModel addPaymentModel;
  final bool isEvent;
  const OnAddPaymentPage({required this.addPaymentModel, this.isEvent = false});

  @override
  List<Object> get props => [addPaymentModel, isEvent];
}

class OnPaymentPage extends PagesState {
  final String idTransaction;
  final String noInvoice;
  final String totalPrice;
  const OnPaymentPage(
      {required this.noInvoice,
      required this.idTransaction,
      required this.totalPrice});

  @override
  List<Object> get props => [idTransaction];
}

class OnPDFViewPage extends PagesState {
  final String urlPdf;
  const OnPDFViewPage({required this.urlPdf});
  @override
  List<Object> get props => [urlPdf];
}

class OnTransactionPage extends PagesState {
  @override
  List<Object> get props => [];
}

class OnDetailTransactionPage extends PagesState {
  final String idTransaction;
  const OnDetailTransactionPage({required this.idTransaction});
  @override
  List<Object> get props => [idTransaction];
}

class OnEditProfilePage extends PagesState {
  final String nameUser;
  final String email;
  final String linkImage;
  final String noPhone;
  const OnEditProfilePage(
      {required this.nameUser,
      required this.email,
      required this.linkImage,
      required this.noPhone});

  @override
  List<Object> get props => [nameUser, email, linkImage, noPhone];
}

class OnMorePage extends PagesState {
  final String idCategory;
  final String searchTitle;
  final String tag;
  final bool tagMore;
  const OnMorePage(
      {required this.tag,
      this.idCategory = '',
      this.searchTitle = '',
      this.tagMore = false});

  @override
  List<Object> get props => [];
}

class OnProductDetailsPage extends PagesState {
  final String idBook;
  const OnProductDetailsPage({required this.idBook});
  @override
  List<Object> get props => [idBook];
}

class OnTransactionMidtransPage extends PagesState {
  final String url;
  const OnTransactionMidtransPage({required this.url});
  @override
  List<Object> get props => [url];
}

class OnVerificationEmailPage extends PagesState {
  final bool fromSingUp;
  final String? email;
  const OnVerificationEmailPage({this.fromSingUp = false, this.email});

  @override
  List<Object> get props => [];
}

class OnAdsDetailPage extends PagesState {
  final String tag;
  final String idAds;
  const OnAdsDetailPage({required this.idAds, required this.tag});
  @override
  List<Object> get props => [idAds, tag];
}

class OnEventPage extends PagesState {
  @override
  List<Object> get props => [];
}

class OnDataEventPage extends PagesState {
  @override
  List<Object> get props => [];
}

class OnTicketEventPage extends PagesState {
  @override
  List<Object> get props => [];
}

class OnEventSertifikatPage extends PagesState {
  @override
  List<Object> get props => [];
}

class OnTransactionEventPage extends PagesState {
  @override
  List<Object> get props => [];
}

class OnInfoEventPage extends PagesState {
  @override
  List<Object> get props => [];
}

class OnDetailEventPage extends PagesState {
  final String idPromo;
  const OnDetailEventPage(this.idPromo);
  @override
  List<Object> get props => [idPromo];
}

class OnPaymentEventPage extends PagesState {
  final String idTransaksi;
  final String noInvoice;
  const OnPaymentEventPage(
      {required this.idTransaksi, required this.noInvoice});
  @override
  List<Object> get props => [idTransaksi, noInvoice];
}

class OnDetailTransaksiEventPage extends PagesState {
  final String idTransaksi;
  const OnDetailTransaksiEventPage({required this.idTransaksi});

  @override
  List<Object> get props => [idTransaksi];
}
