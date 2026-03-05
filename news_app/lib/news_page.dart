import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/client.dart';
import 'package:news_app/detail_news_page.dart';
import 'package:news_app/response_articles.dart';

enum SortOption { terbaru, terlama }

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Article> listArticle = [];
  List<Article> filteredArticle = [];

  bool isLoading = false;
  String searchQuery = "";
  SortOption selectedSort = SortOption.terbaru;

  Future<void> getListArticle() async {
    setState(() => isLoading = true);

    try {
      listArticle = await Client.fetchArticle();
      applyFilterAndSort();
    } catch (e) {
      debugPrint("Error: $e");
    }

    setState(() => isLoading = false);
  }

  void applyFilterAndSort() {
    filteredArticle = listArticle.where((article) {
      return article.title
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    if (selectedSort == SortOption.terbaru) {
      filteredArticle.sort(
          (a, b) => b.publishedAt.compareTo(a.publishedAt));
    } else {
      filteredArticle.sort(
          (a, b) => a.publishedAt.compareTo(b.publishedAt));
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  void initState() {
    super.initState();
    getListArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Top Headlines",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [

                /// ===== SEARCH + SORT =====
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [

                      /// SEARCH FIELD
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Cari berita...",
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                            applyFilterAndSort();
                          });
                        },
                      ),

                      const SizedBox(height: 12),

                      /// SORT DROPDOWN
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Urutkan:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          DropdownButton<SortOption>(
                            value: selectedSort,
                            underline: const SizedBox(),
                            items: const [
                              DropdownMenuItem(
                                value: SortOption.terbaru,
                                child: Text("Terbaru"),
                              ),
                              DropdownMenuItem(
                                value: SortOption.terlama,
                                child: Text("Terlama"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedSort = value!;
                                applyFilterAndSort();
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// ===== LIST =====
                Expanded(
                  child: filteredArticle.isEmpty
                      ? const Center(
                          child: Text("Berita tidak ditemukan"),
                        )
                      : ListView.builder(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: filteredArticle.length,
                          itemBuilder: (context, index) {
                            final article = filteredArticle[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailNewsPage(
                                        article: article),
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.05),
                                      blurRadius: 10,
                                      offset:
                                          const Offset(0, 4),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          const BorderRadius.vertical(
                                              top: Radius.circular(18)),
                                      child: Image.network(
                                        article.urlToImage,
                                        width: double.infinity,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.all(16),
                                      child: Text(
                                        article.title,
                                        maxLines: 2,
                                        overflow:
                                            TextOverflow.ellipsis,
                                        style:
                                            const TextStyle(
                                          fontSize: 18,
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(
                                              left: 16,
                                              right: 16,
                                              bottom: 16),
                                      child: Row(
                                        children: [
                                          const Icon(
                                              Icons.calendar_today,
                                              size: 14,
                                              color:
                                                  Colors.grey),
                                          const SizedBox(
                                              width: 6),
                                          Text(
                                            formatDate(article
                                                .publishedAt),
                                            style:
                                                const TextStyle(
                                              color:
                                                  Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}