part of 'data_list_ebook_bloc.dart';

abstract class DataListEbookState extends Equatable {
  const DataListEbookState();

  @override
  List<Object> get props => [];
}

class DataListEbookInitial extends DataListEbookState {}

class DataListEbookLoaded extends DataListEbookState {
  final DataListEbookModel dataListEbookModel;
  const DataListEbookLoaded({required this.dataListEbookModel});

  @override
  List<Object> get props => [dataListEbookModel];
}
