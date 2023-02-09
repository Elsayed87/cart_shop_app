// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mystore_app/model/product_model.dart';

enum StoreRequest { unknown, requestInProgress, requestSuccess, requestFailure }

class StoreState {
  final  List<ProductModel>  products;
  final StoreRequest productsStatus;
  final Set<int> cartIds;

  StoreState(
      {this.products = const [],
      this.productsStatus = StoreRequest.unknown,
      this.cartIds = const {}});
      

  StoreState copyWith({
     List<ProductModel> ? products,
    StoreRequest? productsStatus,
    Set<int>? cartIds,
  }) {
    return StoreState(
     products: products ?? this.products,
     productsStatus: productsStatus ?? this.productsStatus,
     cartIds: cartIds ?? this.cartIds,
    );
  }
}
