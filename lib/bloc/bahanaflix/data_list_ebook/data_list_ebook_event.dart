part of 'data_list_ebook_bloc.dart';

abstract class DataListEbookEvent extends Equatable {
  const DataListEbookEvent();

  @override
  List<Object> get props => [];
}

class FetchDataListCategoryEbookEvent extends DataListEbookEvent {
  final String idCategory;
  const FetchDataListCategoryEbookEvent({required this.idCategory});

  @override
  List<Object> get props => [idCategory];
}

class FetchDataListEbookEvent extends DataListEbookEvent {
  @override
  List<Object> get props => [];
}
