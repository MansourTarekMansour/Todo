import 'package:flutter/material.dart';
import 'package:todo/news_app/web_view/web_view_screen.dart';

Widget buildDivider() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        //width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
    );

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
);

Widget articleBuilder(list, context, {isSearch = false}) {
  return list.length > 0
      ? ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => buildDivider(),
          itemCount: list.length,
        )
      : Center(
          child: isSearch? Container() : CircularProgressIndicator(),
        );
}

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );
