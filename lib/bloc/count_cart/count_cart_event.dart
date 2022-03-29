part of 'count_cart_bloc.dart';

abstract class CountCartEvent extends Equatable {
  const CountCartEvent();

  @override
  List<Object> get props => [];
}

class FetchDataCountCartItemEvent extends CountCartEvent {
  final String idUser;
  const FetchDataCountCartItemEvent({required this.idUser});

  @override
  List<Object> get props => [idUser];
}
