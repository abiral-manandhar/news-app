import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:untitled3/services/model.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:untitled3/services/news.dart';
import  'package:untitled3/pages/article_view.dart';
import 'package:url_launcher/url_launcher.dart';
class SearchBarDemoHome extends StatefulWidget {
  @override
  _SearchBarDemoHomeState createState() => new _SearchBarDemoHomeState();
}

class _SearchBarDemoHomeState extends State<SearchBarDemoHome> {
  List<ArticleModel>articles = List<ArticleModel>();


  var temp;
  var a = 0;
  var something;


  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        backgroundColor: Colors.white70,
        title: new Text('News', style: TextStyle(
            color: Colors.black38
        )

        ),
        actions: [searchBar.getSearchAction(context)]);
  }

  @override
  void initState() {
    super.initState();
    getNews();}


  getNews() async{
    News news = News();
    await news.getNews();
    setState(() {
      articles = news.news;
    });

  }


  Future getSearched(String key) async{
    Response response = await get(Uri.parse(
        'https://newsapi.org/v2/everything?q=$key&qInTitle=$key&domains=bbc.co.uk, aljazeera.com, cnn.com, huffpost.com, nytimes.comm, washingtonpost.com&sortBy=popularity&apiKey=3164cfcec4834986847368fec8bd33ae'));
    Map data = jsonDecode(response.body);

    Navigator.popAndPushNamed(context, '/searched', arguments: data);
  }
  void onSubmitted(String value) async{
    var term = value;
    await getSearched(term);

  }

  _SearchBarDemoHomeState() {
    searchBar = new SearchBar(
      inBar: false,
      buildDefaultAppBar: buildAppBar,
      setState: setState,
      onSubmitted: onSubmitted,
    );
  }

  @override
    Widget build(BuildContext context) {

    a = a + 1;
    //sleep(Duration(seconds: 3));

       return Scaffold(
         backgroundColor: Colors.grey[900],
           appBar: searchBar.build(context),
           key: _scaffoldKey,
           body:
           Column(

               children: [
                 Expanded(
                   child: ListView.builder(scrollDirection: Axis.vertical,
                     shrinkWrap: true, itemCount: 20, itemBuilder: (context, i) {
      try{
                       return Padding(
                         padding: const EdgeInsets.fromLTRB(70, 15, 70, 15),
                         child: Container(

                              width: 20,
                             height: 225,
                              child: Column(

                               // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: InkWell(

                                        onTap: (){
                                          launch('${articles[i].url}',
                                          forceSafariVC: true,
                                          forceWebView: false);
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 400,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.circular(10)
                                            )

                                          ,
                                            child:
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child:
                                              Image.network(
                                                ('${articles[i].image}'),
                                                fit: BoxFit.cover,),

                                            ),

                                            ),
                                      ),
                                      ),
                        SizedBox(height:5,),

                                 Padding(

                                   padding: EdgeInsets.all(8),
                                    child: Text('${articles[i].title}',maxLines:3,overflow: TextOverflow.ellipsis, style: TextStyle(

                                   color: Colors.white70,
                                   fontSize: 15,


                                 ))
                                 )
                             ]

                              ),
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                  borderRadius: BorderRadius.circular(10),
                              ),



                           ));



      }
      catch(e){


      }
                     },),
                 ),

               ])

       );

  }


}
