part of 'item_cart_bloc.dart';

abstract class ItemCartState extends Equatable {
  const ItemCartState();

  @override
  List<Object> get props => [];
}

class ItemCartInitial extends ItemCartState {}

class ItemCartLoaded extends ItemCartState {
  final BaCardResult baCardResult;
  const ItemCartLoaded({required this.baCardResult});

  @override
  List<Object> get props => [baCardResult];
}
