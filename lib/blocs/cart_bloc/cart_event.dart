part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddMealToCartEvent extends CartEvent {
  final MealModel meal;
  AddMealToCartEvent({required this.meal});

  @override
  List<Object> get props => [meal];
}

class RemoveMealFromCartEvent extends CartEvent {
  final MealModel meal;
  RemoveMealFromCartEvent({required this.meal});

  @override
  List<Object> get props => [meal];
}
