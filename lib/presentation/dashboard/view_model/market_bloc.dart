import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/company_model.dart';
import '../../../data/models/portfolio_model.dart';

import '../../../data/models/transaction_model.dart';
import 'market_event.dart';
import 'market_state.dart';

class MarketBloc
    extends Bloc<MarketEvent, MarketState> {

  late Timer timer;

  MarketBloc()
      : super(
    MarketState(
      walletBalance: 10000,
      portfolio: [],
      transactions: [],
      companies: [
        CompanyModel(
          name: "Apple",
          currentPrice: 100 + Random().nextInt(401).toDouble(),
          priceChange: 0,
        ),
        CompanyModel(
          name: "Tesla",
          currentPrice: 100 + Random().nextInt(401).toDouble(),
          priceChange: 0,
        ),
        CompanyModel(
          name: "Amazon",
          currentPrice: 100 + Random().nextInt(401).toDouble(),
          priceChange: 0,
        ),
        CompanyModel(
          name: "Google",
          currentPrice: 100 + Random().nextInt(401).toDouble(),
          priceChange: 0,
        ),
        CompanyModel(
          name: "Microsoft",
          currentPrice: 100 + Random().nextInt(401).toDouble(),
          priceChange: 0,
        ),
      ],
    ),
  ) {
    on<UpdatePricesEvent>(_updatePrices);
    on<BuyShareEvent>(_buyShare);
    on<SellShareEvent>(_sellShare);

    timer = Timer.periodic(
      const Duration(seconds: 2),
          (_) {
        add(UpdatePricesEvent());
      },
    );
  }

  void _updatePrices(
      UpdatePricesEvent event,
      Emitter<MarketState> emit,
      ) {
    final random = Random();

    final updatedCompanies =
    state.companies.map((company) {

      final movement =
          random.nextInt(20) + 1;

      final increase =
      random.nextBool();

      double newPrice = increase
          ? company.currentPrice + movement
          : company.currentPrice - movement;

      if (newPrice < 1) {
        newPrice = 1;
      }

      return company.copyWith(
        currentPrice: newPrice,
        priceChange:
        newPrice - company.currentPrice,
      );
    }).toList();

    emit(
      state.copyWith(
        companies: updatedCompanies,
      ),
    );
  }

  void _buyShare(
      BuyShareEvent event,
      Emitter<MarketState> emit,
      ) {
    final company = state.companies.firstWhere(
          (e) => e.name == event.companyName,
    );

    final totalCost =
        company.currentPrice *
            event.quantity;

    if (state.walletBalance < totalCost) {
      return;
    }

    final portfolio =
    List<PortfolioModel>.from(
      state.portfolio,
    );

    final transactions =
    List<TransactionModel>.from(
      state.transactions,
    );

    final index = portfolio.indexWhere(
          (e) =>
      e.companyName ==
          event.companyName,
    );

    if (index == -1) {
      portfolio.add(
        PortfolioModel(
          companyName:
          event.companyName,
          shares: event.quantity,
          averageBuyPrice: company.currentPrice,
        ),
      );
    }else {

  final oldShares =
  portfolio[index].shares;

  final oldAvgPrice =
  portfolio[index].averageBuyPrice;

  final newShares =
  oldShares + event.quantity;

  final newAveragePrice =
  ((oldShares * oldAvgPrice) +
  (event.quantity *
  company.currentPrice)) /
  newShares;

  portfolio[index] =
  portfolio[index].copyWith(
  shares: newShares,
  averageBuyPrice:
  newAveragePrice,
  );
  }

    transactions.insert(
      0,
      TransactionModel(
        companyName:
        company.name,
        isBuy: true,
        quantity: event.quantity,
        pricePerShare:
        company.currentPrice,
        totalAmount: totalCost,
        transactionTime:
        DateTime.now(),
      ),
    );

    emit(
      state.copyWith(
        walletBalance:
        state.walletBalance -
            totalCost,
        portfolio: portfolio,
        transactions: transactions,
      ),
    );
  }

  void _sellShare(
      SellShareEvent event,
      Emitter<MarketState> emit,
      ) {
    final company = state.companies.firstWhere(
          (e) => e.name == event.companyName,
    );

    final portfolio =
    List<PortfolioModel>.from(
      state.portfolio,
    );

    final transactions =
    List<TransactionModel>.from(
      state.transactions,
    );

    final index = portfolio.indexWhere(
          (e) =>
      e.companyName ==
          event.companyName,
    );

    if (index == -1) return;

    if (portfolio[index].shares <
        event.quantity) {
      return;
    }

    final amount =
        company.currentPrice *
            event.quantity;

    final remainingShares =
        portfolio[index].shares -
            event.quantity;

    if (remainingShares == 0) {
      portfolio.removeAt(index);
    } else {
      portfolio[index] =
          portfolio[index].copyWith(
            shares: remainingShares,
          );
    }

    transactions.insert(
      0,
      TransactionModel(
        companyName:
        company.name,
        isBuy: false,
        quantity: event.quantity,
        pricePerShare:
        company.currentPrice,
        totalAmount: amount,
        transactionTime:
        DateTime.now(),
      ),
    );

    emit(
      state.copyWith(
        walletBalance:
        state.walletBalance +
            amount,
        portfolio: portfolio,
        transactions: transactions,
      ),
    );
  }

  @override
  Future<void> close() {
    timer.cancel();
    return super.close();
  }
}