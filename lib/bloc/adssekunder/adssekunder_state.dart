part of 'adssekunder_bloc.dart';

abstract class AdssekunderState extends Equatable {
  const AdssekunderState();

  @override
  List<Object> get props => [];
}

class AdssekunderInitial extends AdssekunderState {}

class ListAdssekunderLoaded extends AdssekunderState {
  final List<AdsModel> adsModel;
  const ListAdssekunderLoaded({required this.adsModel});

  @override
  List<Object> get props => [adsModel];
}
