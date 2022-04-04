part of 'pages_bloc.dart';

abstract class PagesEvent extends Equatable {
  const PagesEvent();

  @override
  List<Object> get props => [];
}

class GoToMainPage extends PagesEvent {
  final int bottomNavBarIndex;
  const GoToMainPage({this.bottomNavBarIndex = 0});

  @override
  List<Object> get props => [bottomNavBarIndex];
}

class GoToSignInPage extends PagesEvent {
  @override
  List<Object> get props => [];
}

class GoToTransactionPage extends PagesEvent {
  @override
  List<Object> get props => [];
}

class GoToDetailTransactionPage extends PagesEvent {
  final String idTransaction;
  const GoToDetailTransactionPage({required this.idTransaction});
  @override
  List<Object> get props => [idTransaction];
}

class GoToCartPage extends PagesEvent {
  @override
  List<Object> get props => [];
}

class GoToSignUpPage extends PagesEvent {
  @override
  List<Object> get props => [];
}

class GoToPDFViewPage extends PagesEvent {
  final String urlPdf;
  const GoToPDFViewPage({required this.urlPdf});
  @override
  List<Object> get props => [urlPdf];
}

class GoToEpubViewPage extends PagesEvent {
  final String idBook;
  final String url;
  const GoToEpubViewPage({required this.idBook, required this.url});

  @override
  List<Object> get props => [idBook, url];
}

class GoToPaymentPage extends PagesEvent {
  final String idTransaction;
  final String totalPrice;
  final String noInvoice;
  const GoToPaymentPage(
      {required this.idTransaction,
      required this.noInvoice,
      required this.totalPrice});

  @override
  List<Object> get props => [idTransaction];
}

class GoToBookshelfPage extends PagesEvent {
  @override
  List<Object> get props => [];
}

class GoToEditProfilePage extends PagesEvent {
  final String nameUser;
  final String email;
  final String linkImage;
  final String noPhone;
  const GoToEditProfilePage(
      {required this.nameUser,
      required this.email,
      required this.linkImage,
      required this.noPhone});

  @override
  List<Object> get props => [nameUser, linkImage, noPhone];
}

class GoToMorePage extends PagesEvent {
  final String idCategory;
  final String searchTitle;
  final String tag;
  final bool tagMore;
  const GoToMorePage(
      {required this.tag,
      required this.idCategory,
      this.searchTitle = '',
      this.tagMore = false});

  @override
  List<Object> get props => [idCategory];
}

class GoToAddPaymentPage extends PagesEvent {
  final AddPaymentModel addPaymentModel;
  const GoToAddPaymentPage({required this.addPaymentModel});

  @override
  List<Object> get props => [addPaymentModel];
}

class GoToProductDetailsPage extends PagesEvent {
  final String idBook;
  const GoToProductDetailsPage({required this.idBook});

  @override
  List<Object> get props => [];
}

class GoToTransactionMidtransPage extends PagesEvent {
  final String url;
  const GoToTransactionMidtransPage({required this.url});
  @override
  List<Object> get props => [url];
}

class GoToAdsDetailPage extends PagesEvent {
  final String tag;
  final String idAds;
  const GoToAdsDetailPage({required this.idAds, required this.tag});
  @override
  List<Object> get props => [idAds, tag];
}

class GoToVerificationEmailPage extends PagesEvent {
  final bool fromSingUp;
  final String? email;
  const GoToVerificationEmailPage({this.fromSingUp = false, this.email});

  @override
  List<Object> get props => [];
}

class GoToEventPage extends PagesEvent {
  @override
  List<Object> get props => [];
}

class GoToDataEventPage extends PagesEvent {
  @override
  List<Object> get props => [];
}

class GoToTicketEventPage extends PagesEvent {
  @override
  List<Object> get props => [];
}

class GoToEventSertifikatPage extends PagesEvent {
  @override
  List<Object> get props => [];
}

class GoToTransactionEventPage extends PagesEvent {
  @override
  List<Object> get props => [];
}

class GoToInfoEventPage extends PagesEvent {
  @override
  List<Object> get props => [];
}

class GoToDetailEventPage extends PagesEvent {
  final String idPromo;
  const GoToDetailEventPage(this.idPromo);
  @override
  List<Object> get props => [idPromo];
}
