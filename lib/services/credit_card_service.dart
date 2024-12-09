import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/credit_card.dart';

class CreditCardService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api/v1/credit-cards';

  // Lấy danh sách tất cả thẻ tín dụng
  Future<List<CreditCard>> getAllCreditCards() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => CreditCard.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load credit cards');
    }
  }

  // Tạo thẻ tín dụng mới (bỏ qua token)
  Future<CreditCard> createCreditCard(CreditCard creditCard) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(creditCard.toJson()), // gửi dữ liệu thẻ tín dụng
    );

    if (response.statusCode == 201) {
      return CreditCard.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create credit card');
    }
  }
}
