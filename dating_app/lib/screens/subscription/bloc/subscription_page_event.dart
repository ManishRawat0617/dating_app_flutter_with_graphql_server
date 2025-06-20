part of 'subscription_page_bloc.dart';

abstract class SubscriptionPageEvent {
  const SubscriptionPageEvent();
}

class SelectOptionEvent extends SubscriptionPageEvent {
  final String selectedPlan;
  const SelectOptionEvent(this.selectedPlan);
}


class TappedToPayEvent extends SubscriptionPageEvent {
  const TappedToPayEvent();
}

class TappedToRestorePurchaseEvent extends SubscriptionPageEvent {
  const TappedToRestorePurchaseEvent();
}


