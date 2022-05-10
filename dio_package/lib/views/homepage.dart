import 'package:flutter/material.dart';

import '../dio/dio_client.dart';
import '../models/posts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool requesting = false;
  late DioClient dioClient;
  late Future<Post> post;

  @override
  void initState(){
    super.initState();
    dioClient = DioClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if(requesting)
                FutureBuilder<Post>(future: post,
                builder: (context, snapshot){
                  if(snapshot.hasData)
                    {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text("${snapshot.data!.title}"),
                            Text("${snapshot.data!.id}"),
                            // Add new data to be displayed.
                          ],
                        ),
                      );
                    }
                  else if(snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                },),
            ElevatedButton(onPressed: (){
              post = dioClient.fetchPost(1);
              setState(() {
                requesting = true;
              });
            }, child: Text("Get data"),),
          ],
        ),
      ),
    );
  }
}
