import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constant/apilist.dart';
import '../models/product.dart';

class ProductRepository {
  final String apiUrl = api_ge_product_list;

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token, // Nếu có token
        },
      );
      print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> products = json.decode(data['products']);
        List<Product> f_products = [];
        print(products);

        final productlist =
            products.map((json) => Product.fromJson(json)).toList();
        return productlist;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load products');
    }

    // final response = await http.get(Uri.parse(apiUrl));
    // print(response.body);
    // if (response.statusCode == 200) {
    //   List<dynamic> data = json.decode(response.body);
    //   return data.map((json) => Product.fromJson(json)).toList();
    // } else {
    //   throw Exception('Failed to load products');
    // }
  }
}
