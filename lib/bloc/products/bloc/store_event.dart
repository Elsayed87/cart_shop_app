abstract class StoreEvent {
  const StoreEvent();
}

class StroreProductsRequsted extends StoreEvent {}

class StroreProductsAddedToCart extends StoreEvent {
  final int cartId;

  StroreProductsAddedToCart(this.cartId);
}

class StroreProductsRemovedFromCart extends StoreEvent {
   final int cartId;

  StroreProductsRemovedFromCart(this.cartId);
}
