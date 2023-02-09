import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore_app/bloc/products/bloc/store_bloc.dart';
import 'package:mystore_app/bloc/products/bloc/store_event.dart';
import 'package:mystore_app/model/product_model.dart';
import 'package:mystore_app/widget/empty_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    
    final hasEmpty =
        context.select<StoreBloc, bool>((value) => value.state.cartIds.isEmpty);


    final cartProducts = context.select<StoreBloc, List<ProductModel>>(
      (b) => b.state.products
          .where((element) => b.state.cartIds.contains(element.id))
          .toList(),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("MyCart"),
        backgroundColor: Colors.purple,
      ),
      body: hasEmpty
          ? const EmptyCard()
          : GridView.builder(
              itemCount: cartProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, i) {
                final product = cartProducts[i];

                return Card(
                  key: ValueKey(product.id),
                  child: Column(children: [
                    Flexible(child: Image.network(product.image!)),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Text(
                      product.title!,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      onPressed: () => context
                          .read<StoreBloc>()
                          .add(StroreProductsRemovedFromCart(product.id!)),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.remove_shopping_cart),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Remove From cart"),
                            ]),
                      ),
                    ),
                  ]),
                );
              }),
    );
  }
}
