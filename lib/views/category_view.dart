import 'package:flutter/material.dart';
import 'package:news/hepler/news.dart';
import 'package:news/models/articalModel.dart';
import 'package:news/views/artical_view.dart';

class CategoryView extends StatefulWidget {
  final String category;

  CategoryView(this.category);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ArticleModel> article = new List<ArticleModel>();

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoriesNewsClass newsClass = CategoriesNewsClass();
    await newsClass.getNews(widget.category);
    article = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 29),
          )
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'News',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 23,
              ),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
            child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: article.length,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BlogTile(
                            imageUrl: article[index].urlToImage,
                            title: article[index].title,
                            desc: article[index].desc,
                            url: article[index].url,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
          ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String title, imageUrl, desc, url;

  BlogTile({this.imageUrl, this.desc, this.title, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(url),
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        margin: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(height: 3),
            Text(
              title,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text(
              desc,
              style: TextStyle(color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
