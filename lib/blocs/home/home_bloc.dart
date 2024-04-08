import 'package:bloc/bloc.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/models/user.dart';
import 'package:ecom/repositories/repo_client/repos_register.dart';
import 'package:ecom/utils/session_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:ecom/repositories/home_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepo repository;

  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is FetchHome) {
        emit(const ProductsLoading());
        try {
          List<ProductModel> products = await repository.fetchProducts();
          UserModel? user = await repo.get<SessionManager>().getAuthentication();

          emit(ProductsLoaded(products: products, user: user));
        } on Exception catch (e) {
          emit(ProductsFailed(e.toString()));
        }
      }
    });
  }
}
