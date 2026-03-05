import 'dart:convert';

ResponseArticles responseArticlesFromJson(String str) =>
    ResponseArticles.fromJson(json.decode(str));

String responseArticlesToJson(ResponseArticles data) =>
    json.encode(data.toJson());

class ResponseArticles {
  final String status;
  final int totalResults;
  final List<Article> articles;

  ResponseArticles({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ResponseArticles.fromJson(Map<String, dynamic> json) {
    return ResponseArticles(
      status: json["status"] ?? "",
      totalResults: json["totalResults"] ?? 0,
      articles: json["articles"] != null
          ? List<Article>.from(
              json["articles"].map((x) => Article.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles.map((x) => x.toJson()).toList(),
      };
}

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json["source"] ?? {}),
      author: json["author"] ?? "Tidak ada author",
      title: json["title"] ?? "Tidak ada title",
      description: json["description"] ?? "Tidak ada description",
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ??
          "https://via.placeholder.com/400x200.png?text=No+Image",
      publishedAt: json["publishedAt"] != null
          ? DateTime.parse(json["publishedAt"])
          : DateTime.now(),
      content: json["content"] ?? "Tidak ada konten",
    );
  }

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

class Source {
  final String? id;
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json["id"],
      name: json["name"] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}