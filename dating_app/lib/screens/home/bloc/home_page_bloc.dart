import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomeBloc extends Bloc<HomePageEvent, HomePageState> {
  HomeBloc() : super(const HomeInitialState()) {
    on<SwipeLeftEvent>(_onSwipeLeftEvent);
    on<SwipeRightEvent>(_onSwipeRightEvent);
  }

  Future<void> _onSwipeLeftEvent(
      SwipeLeftEvent event, Emitter<HomePageState> emit) async {
    emit(const ProfileSwipeState(action: 'dislike'));

    // Simulate loading next profile (e.g., API call)
    emit(const ProfileLoadingState());
    await Future.delayed(const Duration(milliseconds: 300));

    // You can fetch and emit the next profile state here
    emit(const HomeInitialState());
  }

  Future<void> _onSwipeRightEvent(
      SwipeRightEvent event, Emitter<HomePageState> emit) async {
    emit(const ProfileSwipeState(action: 'like'));

    // Simulate loading next profile
    emit(const ProfileLoadingState());
    await Future.delayed(const Duration(milliseconds: 300));

    // Fetch and emit next profile state here
    emit(const HomeInitialState());
  }
}
