import 'dart:convert';
import 'package:news/models/articalModel.dart';
import 'package:http/http.dart' as http;

class News {

  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&apiKey=63a668ab9f25492e8462b951f1867ffd";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData['articles'].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = new ArticleModel(
            title: element['title'],
            content: element['content'],
            author: element['author'],
            desc: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage']
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoriesNewsClass{
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=63a668ab9f25492e8462b951f1867ffd";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData['articles'].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = new ArticleModel(
              title: element['title'],
              content: element['content'],
              author: element['author'],
              desc: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage']
          );
          news.add(articleModel);
        }
      });
    }
  }
}
