import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  final String apiKey = "3c0bff5ef12a47f1b501a6e2b3005931";
  final String keyword = "Diet";
  final String baseUri = "https://newsapi.org/v2/everything";

  Future<Map<String, dynamic>> apiData() async {
    final url = Uri.parse("$baseUri?q=$keyword&from=2024-05-26&sortBy=publishedAt&apiKey=$apiKey");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error: ${response.statusCode}");
    }
  }
}
