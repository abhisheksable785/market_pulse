abstract class MarketEvent {}

class UpdatePricesEvent extends MarketEvent {}

class BuyShareEvent extends MarketEvent {
  final String companyName;
  final int quantity;

  BuyShareEvent({
    required this.companyName,
    required this.quantity,
  });
}

class SellShareEvent extends MarketEvent {
  final String companyName;
  final int quantity;

  SellShareEvent({
    required this.companyName,
    required this.quantity,
  });
}