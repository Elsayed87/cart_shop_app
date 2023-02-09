
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore_app/bloc/products/bloc/store_event.dart';
import 'package:mystore_app/bloc/products/bloc/store_state.dart';
import 'package:mystore_app/repository/store_repo.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreState()) {
    on<StroreProductsRequsted>(_handelStroreProductsRequest);
    on<StroreProductsAddedToCart>(_handelAddToCart);
    on<StroreProductsRemovedFromCart>(_handelRemovedFromCart);
  }
  final StoreRepository api = StoreRepository();

  Future<void> _handelStroreProductsRequest(
      StroreProductsRequsted event, Emitter<StoreState> emit) async {
    try {
      emit(state.copyWith(productsStatus: StoreRequest.requestInProgress));
      final response = await api.getData();

      emit(state.copyWith(
          productsStatus: StoreRequest.requestSuccess, products: response));
    } catch (e) {
      emit(state.copyWith(productsStatus: StoreRequest.requestFailure));
    }
  }

  Future<void> _handelAddToCart(
      StroreProductsAddedToCart event, Emitter<StoreState> emit) async {
    emit(state.copyWith(cartIds: {...state.cartIds, event.cartId}));
  }

  Future<void> _handelRemovedFromCart(
      StroreProductsRemovedFromCart event, Emitter<StoreState> emit) async {
    emit(state.copyWith(cartIds: {...state.cartIds}..remove(event.cartId)));
  }
}
