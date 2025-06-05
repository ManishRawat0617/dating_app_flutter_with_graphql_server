import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<SwipeLeftEvent>(_onSwipeLeftEvent);
    on<SwipeRightEvent>(_onSwipeRightEvent);
  }

  void _onSwipeLeftEvent(SwipeLeftEvent event, Emitter<HomeState> emit) {
    emit(ProfileSwipeState(action: 'dislike'));
    emit(ProfileLoadingState());
  }

  void _onSwipeRightEvent(SwipeRightEvent event, Emitter<HomeState> emit) {
    emit(ProfileSwipeState(action: 'like'));
    emit(ProfileLoadingState());
  }
}