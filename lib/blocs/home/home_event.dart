part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchHome extends HomeEvent {
  const FetchHome();

  @override
  List<Object> get props => [];
}
