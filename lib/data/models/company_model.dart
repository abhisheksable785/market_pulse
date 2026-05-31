class CompanyModel {
  final String name;
  final double currentPrice;
  final double priceChange;

  CompanyModel({
    required this.name,
    required this.currentPrice,
    required this.priceChange,
  });

  CompanyModel copyWith({
    double? currentPrice,
    double? priceChange,
  }) {
    return CompanyModel(
      name: name,
      currentPrice: currentPrice ?? this.currentPrice,
      priceChange: priceChange ?? this.priceChange,
    );
  }
}