import 'package:bahana_digital/services/services.dart';
import 'package:bahana_digital/shared/shared.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'count_cart_event.dart';
part 'count_cart_state.dart';

class CountCartBloc extends Bloc<CountCartEvent, CountCartState> {
  CountCartBloc() : super(CountCartInitial()) {
    on<FetchDataCountCartItemEvent>((event, emit) async {
      BaCardResult baCardResult =
          await ListEbookServices.baCard('carttotal', idUser, '', status: '');
      emit(CountCartItemLoaded(baCardResult: baCardResult));
    });
  }
}
