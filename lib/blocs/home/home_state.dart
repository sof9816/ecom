part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class ProductsLoaded extends HomeState {
  final List<ProductModel> products;
  final UserModel? user;
  const ProductsLoaded({required this.products, this.user});
  @override
  List<Object> get props => [];
}

class ProductsFailed extends HomeState {
  final String error;
  const ProductsFailed(this.error);
  @override
  List<Object> get props => [error];
}

class ProductsLoading extends HomeState {
  const ProductsLoading();
  @override
  List<Object> get props => [];
}
