part of 'item_cart_bloc.dart';

abstract class ItemCartEvent extends Equatable {
  const ItemCartEvent();

  @override
  List<Object> get props => [];
}

class FetchDataItemCartEvent extends ItemCartEvent {
  final String idUser;
  const FetchDataItemCartEvent({required this.idUser});

  @override
  List<Object> get props => [idUser];
}
