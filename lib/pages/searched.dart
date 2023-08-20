import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class Searched extends StatefulWidget {
 void back(int i){

  }
  @override
  _SearchedState createState() => new _SearchedState();
}

class _SearchedState extends State<Searched> {
 Map searched_term;

  Future fetchNews() async {
    Response response = await get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=3164cfcec4834986847368fec8bd33ae'));
    Map data = jsonDecode(response.body);
    return data;
  }

  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        backgroundColor: Colors.white70,
        // title: new Text('News', style: TextStyle(
        //     color: Colors.black38
        // )
        //
        // ),
        actions: [
          Row(
        children:[
       IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
         Navigator.popAndPushNamed(context, '/details');
       }),

          SizedBox(width: 330,),
          searchBar.getSearchAction(context),

      ])]);
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

  _SearchedState() {
    searchBar = new SearchBar(
      inBar: false,
      buildDefaultAppBar: buildAppBar,
      setState: setState,
      onSubmitted: onSubmitted,
    );
  }

  @override
  Widget build(BuildContext context) {

    searched_term = ModalRoute.of(context).settings.arguments;
    //sleep(Duration(seconds: 3));
    print(searched_term);
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
    return
                        Padding(
                                padding: const EdgeInsets.fromLTRB(70, 15, 70, 15),
                                child:


                                Container(

                                   width: 20,
                                   height: 225,
                                   child: Column(

                                     // mainAxisAlignment: MainAxisAlignment.start,
                                       children: [

                                         Align(
                                           alignment: Alignment.topLeft,
                                           child: InkWell(
                                             onTap: (){
                                          launch('${searched_term['articles'][i]['url']}');
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
                                                   ('${searched_term['articles'][i]['urlToImage']}'),
                                                   fit: BoxFit.cover,),

                                               ),

                                             ),
                                           ),
                                         ),
                                         SizedBox(height:5,),
                                         Padding(
                                             padding: EdgeInsets.all(8),
                                             child: Text('${searched_term['articles'][i]['title']}',maxLines:3,overflow: TextOverflow.ellipsis, style: TextStyle(
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



                                 ),
                          );



                        }
                        catch(e){


                        }
                      },),
                  ),

                ]),
       );

  }


}
