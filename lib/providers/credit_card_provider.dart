import 'package:flutter/foundation.dart';
import '../models/credit_card.dart';
import '../repository/credit_card_repository.dart';

class CreditCardProvider with ChangeNotifier {
  final CreditCardRepository _repository = CreditCardRepository();
  List<CreditCard> _creditCards = [];
  bool _isLoading = false;
  String _error = '';

  List<CreditCard> get creditCards => _creditCards;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadCreditCards() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      _creditCards = await _repository.getAllCreditCards();
      print('Đã tải ${_creditCards.length} thẻ');
      
    } catch (e) {
      print('Lỗi trong provider khi tải danh sách thẻ: $e');
      _error = e.toString();
      throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCreditCard(CreditCard creditCard) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      final newCard = await _repository.addCreditCard(creditCard);
      _creditCards.add(newCard);
      
      print('Thêm thẻ thành công: ${newCard.id}');
      
    } catch (e) {
      print('Lỗi trong provider khi thêm thẻ: $e');
      _error = e.toString();
      throw e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCreditCard(int id) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      await _repository.deleteCreditCard(id);
      _creditCards.removeWhere((card) => card.id == id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
