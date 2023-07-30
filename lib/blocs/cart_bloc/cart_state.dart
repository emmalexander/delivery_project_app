part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<MenuModel> cartItems;
  const CartState({required this.cartItems});

  @override
  List<Object?> get props => [cartItems];
}
