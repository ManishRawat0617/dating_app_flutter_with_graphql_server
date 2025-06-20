part of 'home_page_bloc.dart';

/// Base class for all HomePage states.
abstract class HomePageState {
  const HomePageState();
}

/// Initial state when the HomePage is first loaded.
class HomeInitialState extends HomePageState {
  const HomeInitialState();
}

/// State when general loading is in progress.
class LoadingState extends HomePageState {
  const LoadingState();
}

/// State when profile data is being fetched.
class ProfileLoadingState extends HomePageState {
  const ProfileLoadingState();
}

/// State when an error occurs.
class ErrorState extends HomePageState {
  final String message;

  const ErrorState({required this.message});
}

/// State emitted when a profile is swiped (left/right).
class ProfileSwipeState extends HomePageState {
  final String action; // "like" or "dislike"

  const ProfileSwipeState({required this.action});
}
