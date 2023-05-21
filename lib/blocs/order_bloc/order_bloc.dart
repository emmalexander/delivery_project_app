import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderInitial(counter: 1)) {
    on<OrderIncrementEvent>((event, emit) {
      emit(IncrementState(state.counter + 1));
    });
    on<OrderDecrementEvent>((event, emit) {
      if (state.counter > 1) {
        emit(DecrementState(state.counter - 1));
      } else {
        emit(const OrderState(counter: 1));
      }
    });
    on<ClearCountEvent>((event, emit) => emit(const OrderState(counter: 1)));
  }
}
