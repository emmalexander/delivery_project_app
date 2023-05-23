import 'dart:async';

/// The variables necessary for proper functionality in the FlexibleHeader
class FlexibleHeaderState {
  double? initialHeight;
  double? currentHeight;

  double? opacityFlexible = 1;
  double? opacityAppBar = 0;

  FlexibleHeaderState();
}

/// Used in a StreamBuilder to provide business logic with how the opacity is updated.
/// depending on changes to the height initially
/// available when flutter builds the widget the first time.
class FlexibleHeaderBloc {
  StreamController<FlexibleHeaderState> controller =
      StreamController<FlexibleHeaderState>();
  Sink get sink => controller.sink;
  Stream<FlexibleHeaderState> get stream => controller.stream;

  FlexibleHeaderBloc();

  _updateOpacity(FlexibleHeaderState state) {
    if (state.initialHeight == null || state.currentHeight == null) {
      state.opacityFlexible = 1;
      state.opacityAppBar = 0;
    } else {
      double offset = (1 / 3) * state.initialHeight!;
      double opacity =
          (state.currentHeight! - offset) / (state.initialHeight! - offset);

      //Lines below prevents exceptions
      opacity <= 1 ? opacity = opacity : opacity = 1;
      opacity >= 0 ? opacity = opacity : opacity = 0;

      state.opacityFlexible = opacity;
      state.opacityAppBar = (1 - opacity).abs(); // Inverse the opacity
    }
  }

  update(FlexibleHeaderState state, double currentHeight) {
    state.initialHeight ??= currentHeight;
    state.currentHeight = currentHeight;
    _updateOpacity(state);
    _update(state);
  }

  FlexibleHeaderState initial() {
    return FlexibleHeaderState();
  }

  void dispose() {
    controller.close();
  }

  void _update(FlexibleHeaderState state) {
    sink.add(state);
  }
}
