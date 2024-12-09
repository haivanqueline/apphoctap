class CreditCard {
  final int? id;
  final int? userId;
  final String? cardNumber;
  final String? cardHolderName;
  final String? cvv;

  CreditCard({
    this.id,
    this.userId,
    this.cardNumber,
    this.cardHolderName,
    this.cvv,
  });

  // Phương thức chuyển đổi từ JSON sang CreditCard
  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      cardNumber: json['card_number'] as String?,
      cardHolderName: json['card_holder_name'] as String?,
      cvv: json['cvv'] as String?,
    );
  }

  get icon => null;

  // Phương thức chuyển đổi từ CreditCard sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'card_number': cardNumber,
      'card_holder_name': cardHolderName,
      'cvv': cvv,
    };
  }
}
