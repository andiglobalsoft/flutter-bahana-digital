part of 'category_bahanaflix_bloc.dart';

abstract class CategoryBahanaflixState extends Equatable {
  const CategoryBahanaflixState();

  @override
  List<Object> get props => [];
}

class CategoryBahanaflixInitial extends CategoryBahanaflixState {}

class ListCategoryLoaded extends CategoryBahanaflixState {
  final List<ListCategoryBahanaflixModel> listCategoryBahanaflixModel;
  const ListCategoryLoaded({required this.listCategoryBahanaflixModel});

  @override
  List<Object> get props => [listCategoryBahanaflixModel];
}
