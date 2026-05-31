import '../../../data/models/company_model.dart';
import '../../../data/models/portfolio_model.dart';
import '../../../data/models/transaction_model.dart';


class MarketState {
  final List<CompanyModel> companies;
  final List<PortfolioModel> portfolio;
  final List<TransactionModel> transactions;
  final double walletBalance;

  const MarketState({
    required this.companies,
    required this.portfolio,
    required this.walletBalance,
    required this.transactions,
  });

  MarketState copyWith({
    List<CompanyModel>? companies,
    List<PortfolioModel>? portfolio,
    double? walletBalance,
    List<TransactionModel>? transactions,
  }) {
    return MarketState(
      companies: companies ?? this.companies,
      portfolio: portfolio ?? this.portfolio,
      transactions: transactions ?? this.transactions,
      walletBalance: walletBalance ?? this.walletBalance,
    );
  }
}