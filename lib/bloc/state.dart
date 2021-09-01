import 'package:equatable/equatable.dart';
import 'package:untitled/models/products_model.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/repository/authentication_repository.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends HomePageState {}

class SearchStateLoading extends HomePageState {}

class SearchStateSuccess extends HomePageState {
  const SearchStateSuccess(this.items);

  final List<ProductModel> items;

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchStateSuccess { items: ${items.length} }';
}

class SearchStateError extends HomePageState {
  const SearchStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}