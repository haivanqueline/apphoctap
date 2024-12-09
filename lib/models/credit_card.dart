class CreditCard {
  final int? id;
  final int userId;
  final String cardNumber;
  final String cardHolderName;
  final String cvv;
  final String expirationMonth;
  final String expirationYear;

  CreditCard({
    this.id,
    required this.userId,
    required this.cardNumber,
    required this.cardHolderName,
    required this.cvv,
    required this.expirationMonth,
    required this.expirationYear,
  });

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(
      id: json['id'],
      userId: json['user_id'],
      cardNumber: json['card_number'],
      cardHolderName: json['card_holder_name'],
      cvv: json['cvv'],
      expirationMonth: json['expiration_month'],
      expirationYear: json['expiration_year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'card_number': cardNumber,
      'card_holder_name': cardHolderName,
      'cvv': cvv,
      'expiration_month': expirationMonth,
      'expiration_year': expirationYear,
    };
  }
}