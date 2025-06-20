import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'subscription_page_state.dart';
part 'subscription_page_event.dart';

class SubscriptionPageBloc extends Bloc<SubscriptionPageEvent, SubscriptionPageState> {
  String? _selectedPlan;

  SubscriptionPageBloc() : super(const SubscriptionPageInitialPage()) {
    on<SelectOptionEvent>(_onSelectOptionEvent);
    on<TappedToPayEvent>(_onTappedToPayEvent);
    on<TappedToRestorePurchaseEvent>(_onTappedToRestorePurchaseEvent);
  }

  void _onSelectOptionEvent(
      SelectOptionEvent event, Emitter<SubscriptionPageState> emit) {
    _selectedPlan = event.selectedPlan;
    emit(UpdatedSelectionState(_selectedPlan!));
  }

  FutureOr<void> _onTappedToPayEvent(
      TappedToPayEvent event, Emitter<SubscriptionPageState> emit) async {
    if (_selectedPlan == null) return;

    emit(LoadingState(selectedPlan: _selectedPlan));
    await Future.delayed(const Duration(seconds: 1)); // simulate processing

    // Replace with real logic
    emit(PaymentSuccessful(selectedPlan: _selectedPlan));
  }

  FutureOr<void> _onTappedToRestorePurchaseEvent(
      TappedToRestorePurchaseEvent event, Emitter<SubscriptionPageState> emit) async {
    emit(LoadingState(selectedPlan: _selectedPlan));
    await Future.delayed(const Duration(seconds: 1)); // simulate restore logic
    emit(const ErrorState("No previous purchase found."));
  }
}
