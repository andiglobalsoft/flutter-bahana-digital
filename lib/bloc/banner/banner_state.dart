part of 'banner_bloc.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class ListBannerLoaded extends BannerState {
  final List<BannerModel> bannerModel;
  const ListBannerLoaded({required this.bannerModel});

  @override
  List<Object> get props => [bannerModel];
}
