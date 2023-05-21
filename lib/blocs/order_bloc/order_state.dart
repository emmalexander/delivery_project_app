part of 'order_bloc.dart';

class OrderState extends Equatable {
  final int counter;
  const OrderState({required this.counter});

  @override
  List<Object> get props => [counter];
}

class OrderInitial extends OrderState {
  const OrderInitial({required int counter}) : super(counter: 1);
}

class IncrementState extends OrderState {
  const IncrementState(int increasedValue) : super(counter: increasedValue);
}

class DecrementState extends OrderState {
  const DecrementState(int decreasedValue) : super(counter: decreasedValue);
}
