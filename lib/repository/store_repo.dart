import 'package:dio/dio.dart';
import 'package:mystore_app/model/product_model.dart';

class StoreRepository {
  var dio = Dio(BaseOptions(
    baseUrl: "https://fakestoreapi.com/products",
  ));
  Future<List<ProductModel>> getData() async {
    final response = await dio.get("");
    var product = Product.fromJson(response.data);

    return product.list!;
  }
}
