import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'Huba.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dunia extends StatefulWidget {
  const Dunia({Key? key}) : super(key: key);

  @override
  State<Dunia> createState() => _DuniaState();
}

class _DuniaState extends State<Dunia> {
  List<Baloch> photoList = [];
  Future<List<Baloch>> getApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        photoList.add(Baloch.fromJson(i));
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150.0,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              title: Text(
                'Messages',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              actions: [
                Icon(
                  Icons.more_vert_sharp,
                  color: Colors.black,
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    SizedBox(height: 90.0),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white10),
                        child: TextField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search),
                            hintText: 'Search People',
                            filled: true,
                            fillColor: Color.fromRGBO(244, 248, 255, 25),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Container(
                color: Colors.white,
                child: FutureBuilder(
                    future: getApi(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading');
                      } else {
                        return ListView.builder(
                            itemCount: photoList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(600),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1523285367489-d38aec03b6bd',
                                    ),
                                  ),
                                  title:
                                      Text(photoList[index].title.toString()),
                                  trailing:
                                      Text(photoList[index].id.toString()),
                                ),
                              );
                            });
                      }
                    }),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
