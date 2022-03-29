import 'package:bahana_digital/models/models.dart';
import 'package:bahana_digital/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ads_event.dart';
part 'ads_state.dart';

class AdsBloc extends Bloc<AdsEvent, AdsState> {
  AdsBloc() : super(AdsInitial()) {
    on<FetchDataListAdsLoaded>((event, emit) async {
      List<AdsModel> adsModel = await AdsService.ads(tag: 'primary', idAds: '');
      emit(ListAdsLoaded(adsModel: adsModel));
    });
  }
}
