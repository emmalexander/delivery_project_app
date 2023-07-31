import 'package:delivery_project_app/models/menu_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(cartItems: [])) {
    on<AddMealToCartEvent>((event, emit) {
      //final state = this.state;
      //  final cartItems = state.cartItems ?? [];
      emit(CartState(
        //quantity: state.quantity,
        cartItems: List.from(state.cartItems)..add(event.menuModel),
      ));
      //state.cart!.add(event.meal);
    });
    on<RemoveMealFromCartEvent>((event, emit) {
      final updatedCart = List<MenuModel>.from(state.cartItems)
        ..remove(event.menuModel);
      emit(CartState(cartItems: updatedCart));
    });
    on<ClearCartEvent>((event, emit) {
      final updatedCart = List<MenuModel>.from(state.cartItems)..clear();
      emit(CartState(cartItems: updatedCart));
    });
  }
}
