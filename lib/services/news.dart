import 'dart:convert';

import 'package:untitled3/services/model.dart';
import 'package:http/http.dart';
class News{
  List<ArticleModel> news =[];
  Future<void> getNews() async{
    String url =  'https://newsapi.org/v2/top-headlines?country=us&apiKey=3164cfcec4834986847368fec8bd33ae';
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
   data['articles'].forEach((e){
      if(e['urlToImage'] != null){
        ArticleModel model1  = ArticleModel(
          title: e['title'],
          image: e['urlToImage'],
          url: e['url'],
        );
        news.add(model1);
      }
    });

  }
}