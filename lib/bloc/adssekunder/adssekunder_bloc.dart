import 'package:bahana_digital/models/models.dart';
import 'package:bahana_digital/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'adssekunder_event.dart';
part 'adssekunder_state.dart';

class AdssekunderBloc extends Bloc<AdssekunderEvent, AdssekunderState> {
  AdssekunderBloc() : super(AdssekunderInitial()) {
    on<FetchDataListAdssekunderLoaded>((event, emit) async {
      List<AdsModel> adsModel =
          await AdsService.ads(tag: 'sekunder', idAds: '');
      emit(ListAdssekunderLoaded(adsModel: adsModel));
    });
  }
}
