import 'package:bahana_digital/services/services.dart';
import 'package:bahana_digital/shared/shared.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'item_cart_event.dart';
part 'item_cart_state.dart';

class ItemCartBloc extends Bloc<ItemCartEvent, ItemCartState> {
  ItemCartBloc() : super(ItemCartInitial()) {
    on<FetchDataItemCartEvent>((event, emit) async {
      BaCardResult baCardResult =
          await ListEbookServices.baCard('listcart', idUser, '', status: '');
      emit(ItemCartLoaded(baCardResult: baCardResult));
    });
  }
}
