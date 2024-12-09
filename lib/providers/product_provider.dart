import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../repository/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final productListProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.fetchProducts();
});
