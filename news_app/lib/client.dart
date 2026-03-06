import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/response_articles.dart';

class Client {
  static Future<List<Article>> fetchArticle() async {
    const String apiKey = "80da7b78986f4991b697377611d5d22b";

    final Uri url = Uri.parse(
      "https://newsapi.org/v2/everything?q=Indonesia&sortBy=publishedAt&apiKey=$apiKey",
    );

    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      ResponseArticles responseArticles =
          ResponseArticles.fromJson(responseBody);

      return responseArticles.articles;
    } else {
      throw Exception(
          "Failed to load article. Status Code: ${response.statusCode}");
    }
  }
}