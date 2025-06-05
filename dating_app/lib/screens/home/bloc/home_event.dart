part of 'home_bloc.dart';

abstract class HomeEvent {}

class SwipeLeftEvent extends HomeEvent {
  SwipeLeftEvent();
}

class SwipeRightEvent extends HomeEvent {
  SwipeRightEvent();
}
