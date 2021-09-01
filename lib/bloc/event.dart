import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class CategoryChanged extends HomePageEvent {
  const CategoryChanged({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

// class AuthenticationLogoutRequested extends HomePageEvent {
//
// }
