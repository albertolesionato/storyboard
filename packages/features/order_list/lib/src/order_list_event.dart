part of 'order_list_bloc.dart';

abstract class OrderListEvent extends Equatable {
  const OrderListEvent();

  @override
  List<Object?> get props => [];
}

class OrderListFilterByExpeditedToggled extends OrderListEvent {
  const OrderListFilterByExpeditedToggled();
}

class OrderListTagChanged extends OrderListEvent {
  const OrderListTagChanged(
    this.orderTag,
  );

  final OrderTag? orderTag;

  @override
  List<Object?> get props => [
        orderTag,
      ];
}

class OrderListSearchTermChanged extends OrderListEvent {
  const OrderListSearchTermChanged(
    this.searchTerm,
  );

  final String searchTerm;

  @override
  List<Object?> get props => [
        searchTerm,
      ];
}

class OrderListRefreshed extends OrderListEvent {
  const OrderListRefreshed();
}

class OrderListNextPageRequested extends OrderListEvent {
  const OrderListNextPageRequested({
    required this.pageNumber,
  });

  final int pageNumber;
}

abstract class OrderListItemRushToggled extends OrderListEvent {
  const OrderListItemRushToggled(
    this.id,
  );

  final int id;
}

class OrderListItemRushed extends OrderListItemRushToggled {
  const OrderListItemRushed(
    int id,
  ) : super(id);
}

class OrderListItemUnrushed extends OrderListItemRushToggled {
  const OrderListItemUnrushed(
    int id,
  ) : super(id);
}

class OrderListFailedFetchRetried extends OrderListEvent {
  const OrderListFailedFetchRetried();
}

class OrderListUsernameObtained extends OrderListEvent {
  const OrderListUsernameObtained();
}

class OrderListItemUpdated extends OrderListEvent {
  const OrderListItemUpdated(this.updatedOrder);

  final Order updatedOrder;
}
