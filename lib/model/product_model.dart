class Product {
  List<ProductModel>? list;

  Product({required this.list});
  factory Product.fromJson(json) {
    return Product(list: getList(json)); //response.data
  }
  static List<ProductModel> getList(List<dynamic> list) {
    List<ProductModel> pList =
        list.map((e) => ProductModel.fromJson(e)).toList();
    return pList;
  }
}

class ProductModel {
  int? id;
  String? title;
  dynamic price;
  String? description;
  String? category;
  String? image;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      price: json["price"],
      description: json["description"],
      category: json["category"],
      image: json["image"],
    );
  }
}
