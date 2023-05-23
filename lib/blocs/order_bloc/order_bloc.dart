import 'package:delivery_project_app/models/meal_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderInitial(quantity: 1, cartItems: [])) {
    on<OrderIncrementEvent>((event, emit) {
      //emit(OrderState(quantity: state.quantity! + 1));
      emit(IncrementState(state.quantity + 1));
    });
    on<OrderDecrementEvent>((event, emit) {
      if (state.quantity > 1) {
        emit(DecrementState(state.quantity - 1));
      } else {
        emit(const OrderState(quantity: 1));
      }
    });
    on<ClearCountEvent>((event, emit) => emit(const OrderState(quantity: 1)));
  }

/*  //this fromJson() method is called after every other restarts
  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  //this toJson() method is called first when the app is installed for the first time
  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }*/
}
