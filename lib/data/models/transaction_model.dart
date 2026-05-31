class TransactionModel {
  final String companyName;
  final bool isBuy;
  final int quantity;
  final double pricePerShare;
  final double totalAmount;
  final DateTime transactionTime;

  const TransactionModel({
    required this.companyName,
    required this.isBuy,
    required this.quantity,
    required this.pricePerShare,
    required this.totalAmount,
    required this.transactionTime,
  });

  TransactionModel copyWith({
    String? companyName,
    bool? isBuy,
    int? quantity,
    double? pricePerShare,
    double? totalAmount,
    DateTime? transactionTime,
  }) {
    return TransactionModel(
      companyName: companyName ?? this.companyName,
      isBuy: isBuy ?? this.isBuy,
      quantity: quantity ?? this.quantity,
      pricePerShare: pricePerShare ?? this.pricePerShare,
      totalAmount: totalAmount ?? this.totalAmount,
      transactionTime:
      transactionTime ?? this.transactionTime,
    );
  }
}