import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_bar_event.dart';
part 'tab_bar_state.dart';

class TabBarBloc extends Bloc<TabBarEvent,TabBarState>{
  int currentIndex = 0;
  bool isSelected = false;

  TabBarBloc():super(TabBarInitial()){
    on<TabBarTappedEvent>(_onTabBarTappedEvent);
  }

  void _onTabBarTappedEvent(TabBarTappedEvent event, Emitter<TabBarState> emit) {
    currentIndex = event.index;
    isSelected = true;
    emit(TabBarItemSelectedState(index: currentIndex));
  }
  

}