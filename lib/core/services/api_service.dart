import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Replace with your actual API base URL when available
  static const String baseUrl = 'https://fakestoreapi.com';
  
  // Get all products
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
  
  // Search products by query
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    try {
      // Get all products first (in a real app, you'd have a proper search endpoint)
      final products = await getAllProducts();
      
      // Filter products based on query (case insensitive)
      if (query.isEmpty) {
        return products;
      }
      
      final lowercaseQuery = query.toLowerCase();
      return products.where((product) {
        final title = (product['title'] ?? '').toString().toLowerCase();
        final description = (product['description'] ?? '').toString().toLowerCase();
        final category = (product['category'] ?? '').toString().toLowerCase();
        
        return title.contains(lowercaseQuery) || 
               description.contains(lowercaseQuery) ||
               category.contains(lowercaseQuery);
      }).toList();
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }
}
