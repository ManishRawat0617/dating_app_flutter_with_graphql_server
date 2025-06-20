part of 'home_page_bloc.dart';

/// Base class for all HomePage events.
abstract class HomePageEvent {
  const HomePageEvent();
}

/// Triggered when a user swipes left (dislike) on a profile.
class SwipeLeftEvent extends HomePageEvent {
  final String profileId; // ID of the profile swiped left

  const SwipeLeftEvent(this.profileId);
}

/// Triggered when a user swipes right (like) on a profile.
class SwipeRightEvent extends HomePageEvent {
  final String profileId; // ID of the profile swiped right

  const SwipeRightEvent(this.profileId);
}
