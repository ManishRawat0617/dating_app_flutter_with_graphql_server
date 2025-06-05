part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class ProfileLoadingState extends HomeState {}

class ErrorState extends HomeState {
  final String message;

  ErrorState({required this.message});
}

class ProfileSwipeState extends HomeState {
  final String action;

  ProfileSwipeState({required this.action}); // like or dislike
}
