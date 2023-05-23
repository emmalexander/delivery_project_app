part of 'order_bloc.dart';

class OrderState extends Equatable {
  final int quantity;

  const OrderState({this.quantity = 1});

  @override
  List<Object> get props => [quantity];

  /* Map<String, dynamic> toMap() {
    return {
      'cart': cart!.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderState.fromMap(Map<String, dynamic> map) {
    return OrderState(
      cart: List<MealModel>.from(
          map['pendingTasks']?.map((x) => MealModel.fromJson(x))),
      quantity: map['counter'] ?? 1,
    );
  }*/
}

class OrderInitial extends OrderState {
  const OrderInitial(
      {required int quantity, required List<MealModel> cartItems})
      : super(quantity: 1);
}

class IncrementState extends OrderState {
  const IncrementState(int increasedValue) : super(quantity: increasedValue);
}

class DecrementState extends OrderState {
  const DecrementState(int decreasedValue) : super(quantity: decreasedValue);
}
