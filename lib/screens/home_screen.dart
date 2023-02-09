import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore_app/bloc/products/bloc/store_bloc.dart';
import 'package:mystore_app/bloc/products/bloc/store_state.dart';
import 'package:mystore_app/screens/cart_screen.dart';

import '../bloc/products/bloc/store_event.dart';
import '../repository/store_repo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _addToCart(int cartId) {
    context.read<StoreBloc>().add(StroreProductsAddedToCart(cartId));
  }

  void _removeFromCart(int cartId) {
    context.read<StoreBloc>().add(StroreProductsRemovedFromCart(cartId));
  }

  void _viewCart() {
    Navigator.push(
        context,
        PageRouteBuilder(
          transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: BlocProvider.value(
              value: context.read<StoreBloc>(),
              child: child,
            ),
          );
        },
        pageBuilder: (_, __, ___) {
          return const CartScreen();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Store app"),
        elevation: 0.0,
      ),
      body: Center(
        child: BlocBuilder<StoreBloc, StoreState>(
          builder: (context, state) {
          if (state.productsStatus == StoreRequest.requestInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.productsStatus == StoreRequest.requestFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Problem loading products"),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                    onPressed: ()  {
                      context.read<StoreBloc>().add(StroreProductsRequsted());
                  
                    },
                    child: const Text("Try again"))
              ],
            );
          }
          if (state.productsStatus == StoreRequest.unknown) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shop_outlined,
                  size: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("No products to view"),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                    onPressed: () {
                      context.read<StoreBloc>().add(StroreProductsRequsted());
                    },
                    child: const Text("Load Products"))
              ],
            );
          } else if (state.productsStatus == StoreRequest.requestSuccess) {
            return GridView.builder(
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, i) {
                  final product = state.products[i];
                  final inCart = state.cartIds.contains(product.id);
                  return Card(
                    // color: Colors.white,
                  //  key: ValueKey(product.id),
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
                        onPressed: inCart
                            ? () => _removeFromCart(product.id!)
                            : () => _addToCart(product.id!),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: inCart
                                ? const [
                                    Icon(Icons.remove_shopping_cart),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Remove From cart"),
                                  ]
                                : const [
                                    Icon(Icons.add_shopping_cart),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Add to cart"),
                                  ],
                          ),
                        ),
                      ),
                    ]),
                  );
                });
          }
          return const Center(
              child: Text(
            "done",
            style: TextStyle(color: Colors.red),
          ));

          // if(state.productsStatus==StoreRequest.requestSuccess){}
        }),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            tooltip: "View Cart",
            onPressed: _viewCart,
            child: const Icon(Icons.shopping_cart),
          ),
          BlocBuilder<StoreBloc, StoreState>(builder: (context, state) {
            if (state.cartIds.isEmpty) {
              return Container();
            }
           return Positioned(
            right: -4,
            bottom: 40,
                child: CircleAvatar(
                  radius: 12,
              backgroundColor: Colors.red,
              child: Center(child: Text(state.cartIds.length.toString())),
            ));
          
          }),
        ],
      ),
    );
  }
}
