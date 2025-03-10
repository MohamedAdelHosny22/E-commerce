import '../../../../core/services/api_service.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ApiService _apiService;

  ProductRepository({ApiService? apiService}) 
      : _apiService = apiService ?? ApiService();

  Future<List<Product>> getAllProducts() async {
    try {
      final data = await _apiService.getAllProducts();
      return data.map((item) => Product.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final data = await _apiService.searchProducts(query);
      return data.map((item) => Product.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }
}
