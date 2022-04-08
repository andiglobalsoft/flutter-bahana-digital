import 'package:bahana_digital/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pages_event.dart';
part 'pages_state.dart';

class PagesBloc extends Bloc<PagesEvent, PagesState> {
  PagesBloc() : super(const OnMainPage(bottomNavBarIndex: 0)) {
    on<GoToMainPage>((event, emit) =>
        emit(OnMainPage(bottomNavBarIndex: event.bottomNavBarIndex)));
    on<GoToMorePage>((event, emit) => emit(OnMorePage(
        tag: event.tag, idCategory: event.idCategory, tagMore: event.tagMore)));
    on<GoToProductDetailsPage>(
        (event, emit) => emit(OnProductDetailsPage(idBook: event.idBook)));
    on<GoToSignInPage>((event, emit) => emit(OnSignInPage()));
    on<GoToSignUpPage>((event, emit) => emit(OnSignUpPage()));
    on<GoToCartPage>((event, emit) => emit(OnCartPage()));
    on<GoToBookshelfPage>((event, emit) => emit(OnBookshelfPage()));
    on<GoToTransactionPage>((event, emit) => emit(OnTransactionPage()));
    on<GoToAdsDetailPage>((event, emit) =>
        emit(OnAdsDetailPage(idAds: event.idAds, tag: event.tag)));
    on<GoToDetailTransactionPage>((event, emit) =>
        emit(OnDetailTransactionPage(idTransaction: event.idTransaction)));
    on<GoToPDFViewPage>(
        (event, emit) => emit(OnPDFViewPage(urlPdf: event.urlPdf)));
    on<GoToEpubViewPage>((event, emit) =>
        emit(OnEpubViewPage(idBook: event.idBook, url: event.url)));
    on<GoToPaymentPage>((event, emit) => emit(OnPaymentPage(
        noInvoice: event.noInvoice,
        idTransaction: event.idTransaction,
        totalPrice: event.totalPrice)));
    on<GoToAddPaymentPage>((event, emit) => emit(OnAddPaymentPage(
        addPaymentModel: event.addPaymentModel, isEvent: event.isEvent)));
    on<GoToEditProfilePage>((event, emit) => emit(OnEditProfilePage(
        nameUser: event.nameUser,
        email: event.email,
        linkImage: event.linkImage,
        noPhone: event.noPhone)));
    on<GoToVerificationEmailPage>((event, emit) => emit(OnVerificationEmailPage(
        fromSingUp: event.fromSingUp, email: event.email)));
    on<GoToTransactionMidtransPage>(
        (event, emit) => emit(OnTransactionMidtransPage(url: event.url)));
    on<GoToEventPage>((event, emit) => emit(OnEventPage()));
    on<GoToDataEventPage>((event, emit) => emit(OnDataEventPage()));
    on<GoToTicketEventPage>((event, emit) => emit(OnTicketEventPage()));
    on<GoToEventSertifikatPage>((event, emit) => emit(OnEventSertifikatPage()));
    on<GoToTransactionEventPage>(
        (event, emit) => emit(OnTransactionEventPage()));
    on<GoToInfoEventPage>((event, emit) => emit(OnInfoEventPage()));
    on<GoToDetailEventPage>(
        (event, emit) => emit(OnDetailEventPage(event.idPromo)));
    on<GoToPaymentEventPage>((event, emit) => emit(OnPaymentEventPage(
        idTransaksi: event.idTransaksi, noInvoice: event.noInvoice)));
    on<GoToDetailTransaksiEventPage>((event, emit) =>
        emit(OnDetailTransaksiEventPage(idTransaksi: event.idTransaksi)));
  }
}
