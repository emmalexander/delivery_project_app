part of 'order_bloc.dart';

class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderIncrementEvent extends OrderEvent {}

class OrderDecrementEvent extends OrderEvent {}

class ClearCountEvent extends OrderEvent {}
