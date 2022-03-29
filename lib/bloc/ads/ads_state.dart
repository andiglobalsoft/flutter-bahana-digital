part of 'ads_bloc.dart';

abstract class AdsState extends Equatable {
  const AdsState();

  @override
  List<Object> get props => [];
}

class AdsInitial extends AdsState {}

class ListAdsLoaded extends AdsState {
  final List<AdsModel> adsModel;
  const ListAdsLoaded({required this.adsModel});

  @override
  List<Object> get props => [adsModel];
}
