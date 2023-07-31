part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddMealToCartEvent extends CartEvent {
  final MenuModel menuModel;
  AddMealToCartEvent({required this.menuModel});

  @override
  List<Object> get props => [menuModel];
}

class RemoveMealFromCartEvent extends CartEvent {
  final MenuModel menuModel;
  RemoveMealFromCartEvent({required this.menuModel});

  @override
  List<Object> get props => [menuModel];
}

class ClearCartEvent extends CartEvent {}
