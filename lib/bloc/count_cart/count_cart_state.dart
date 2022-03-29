part of 'count_cart_bloc.dart';

abstract class CountCartState extends Equatable {
  const CountCartState();

  @override
  List<Object> get props => [];
}

class CountCartInitial extends CountCartState {}

class CountCartItemLoaded extends CountCartState {
  final BaCardResult baCardResult;
  const CountCartItemLoaded({required this.baCardResult});

  @override
  List<Object> get props => [baCardResult];
}
