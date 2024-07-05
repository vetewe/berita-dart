import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:app_berita/newsDetail.dart';
import 'package:app_berita/login.dart';

const url = "http://localhost:8080/api";
const urlm = "http://localhost:8080/";

Future fetchNews() async{
  final response = await http.get(Uri.parse(url));
  if(response.statusCode == 200){
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }else{
    throw Exception('Gagal memuat data');
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.list),
        title: Center(child: Text('Berita Pagi')),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.login),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchNews(), 
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data['data'].length,
              itemBuilder: (context, index){
                // return Text(snapshot.data['data'][index]['judul']);
                return Container(
                  height: 180,
                  child: Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          padding: EdgeInsets.all(10),
                          child: Image.network(urlm + '/img/' + snapshot.data['data'][index]['gambar']),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, 
                                      MaterialPageRoute(builder: (context)=> NewsDetail(news : snapshot.data['data'][index]))
                                      );
                                    },
                                    child: Text(snapshot.data['data'][index]['judul'], 
                                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(snapshot.data['data'][index]['isi'], maxLines: 6,
                                    style: TextStyle(fontSize: 10.0),),
                                ),
                              ],
                            ),
                          )
                          )
                      ],
                    ),
                  ),
                );
              }
              );
          }else{
            return const Text ('Data Error');
          }
        }
        )
    );
  }
}