part of 'tab_bar_bloc.dart';

abstract class TabBarEvent {}

class TabBarTappedEvent extends TabBarEvent {
  final int index;

  TabBarTappedEvent({required this.index});
}
