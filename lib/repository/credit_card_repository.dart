import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/credit_card.dart';
import '../constant/apilist.dart';

class CreditCardRepository {
  Future<List<CreditCard>> getAllCreditCards() async {
    try {
      final response = await http.get(
        Uri.parse(api_credit_cards),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Get cards response: ${response.statusCode}');
      print('Get cards body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return jsonData.map((card) => CreditCard.fromJson(card)).toList();
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          final List<dynamic> cards = jsonData['data'];
          return cards.map((card) => CreditCard.fromJson(card)).toList();
        }
        throw Exception('Định dạng response không hợp lệ');
      } else {
        throw Exception('Lỗi ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Repository error - getAllCreditCards: $e');
      throw Exception('Không thể lấy danh sách thẻ: $e');
    }
  }

  Future<CreditCard> addCreditCard(CreditCard creditCard) async {
    try {
      final requestData = jsonEncode(creditCard.toJson());
      print('Request data: $requestData');
      
      final response = await http.post(
        Uri.parse(api_add_credit_card),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: requestData,
      );

      print('Status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        if (responseData is Map<String, dynamic>) {
          final cardData = responseData['data'] ?? responseData;
          try {
            return CreditCard.fromJson(cardData);
          } catch (e) {
            print('Lỗi khi parse card data: $e');
            throw Exception('Dữ liệu thẻ không hợp lệ');
          }
        }
        throw Exception('Response không đúng định dạng');
      }
      
      final responseData = jsonDecode(response.body);
      if (responseData.containsKey('errors')) {
        final errors = responseData['errors'];
        final messages = errors.values.map((e) => e[0]).join(', ');
        throw Exception(messages);
      }
      
      throw Exception('Lỗi không xác định từ server');
    } catch (e) {
      print('Lỗi khi thêm thẻ: $e');
      throw Exception('Không thể thêm thẻ tín dụng: $e');
    }
  }

  Future<void> deleteCreditCard(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$api_delete_credit_card/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Delete card response: ${response.statusCode}');
      print('Delete card body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Lỗi ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Repository error - deleteCreditCard: $e');
      throw Exception('Không thể xóa thẻ tín dụng: $e');
    }
  }
}
