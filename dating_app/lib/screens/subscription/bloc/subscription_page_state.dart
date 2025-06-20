part of 'subscription_page_bloc.dart';

abstract class SubscriptionPageState {
  final String? selectedPlan;
  const SubscriptionPageState({this.selectedPlan});
}

class SubscriptionPageInitialPage extends SubscriptionPageState {
  const SubscriptionPageInitialPage();
}

class LoadingState extends SubscriptionPageState {
  const LoadingState({String? selectedPlan})
      : super(selectedPlan: selectedPlan);
}

class PaymentSuccessful extends SubscriptionPageState {
  const PaymentSuccessful({String? selectedPlan})
      : super(selectedPlan: selectedPlan);
}

class ErrorState extends SubscriptionPageState {
  final String message;
  const ErrorState(this.message);
}

class UpdatedSelectionState extends SubscriptionPageState {
  const UpdatedSelectionState(String selectedPlan)
      : super(selectedPlan: selectedPlan);
}
