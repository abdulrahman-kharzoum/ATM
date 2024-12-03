class TransactionModel {
  final int id;
  final String type;
  final double amount;

  TransactionModel(
      {required this.id, required this.amount, required this.type});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      type: json['type'],
      amount: double.parse(json['amount']),
    );
  }
}
