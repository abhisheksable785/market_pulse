class PortfolioModel {
  final String companyName;
  final int shares;
  final double averageBuyPrice;

  PortfolioModel({
    required this.companyName,
    required this.shares,
    required this.averageBuyPrice,
  });

  PortfolioModel copyWith({
    int? shares,
    double? averageBuyPrice,
  }) {
    return PortfolioModel(
      companyName: companyName,
      shares: shares ?? this.shares,
      averageBuyPrice:
      averageBuyPrice ??
          this.averageBuyPrice,
    );
  }
}