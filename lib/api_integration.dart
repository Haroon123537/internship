import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internship/models.dart';

class ApiIntegration extends StatefulWidget {
  const ApiIntegration({super.key});

  @override
  State<ApiIntegration> createState() => _ApiIntegrationState();
}

class _ApiIntegrationState extends State<ApiIntegration> {
  
  List<Welcome> welcome =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("API INTEGRATION"),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          letterSpacing: 2.5
        ),
      ),
      drawer: Drawer(),

      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot){
          if(snapshot.hasData){
         return ListView.builder(
          itemCount: welcome.length,
          itemBuilder: (context, index){
            return Container(
              height: 110,
              color: Colors.limeAccent,
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.symmetric(vertical: 10.0 , horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("UserId: ${welcome[index].userId}",),
                  Text("Id: ${welcome[index].id}",),
                  Text("Title: ${welcome[index].title}",),
                  Text("Body: ${welcome[index].body}",
                  maxLines: 1,
                  style: TextStyle(
                    
                  ),
                  ),
                ],
              ),
        
            );
          }
        
         );
         
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
        }
      )
    );
  }
  Future<List<Welcome>> getData() async{
     final response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
     var data= jsonDecode(response.body.toString());

     if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        welcome.add(Welcome.fromJson(index));
      }
      return welcome;
     }else{
      return welcome;
     }
  }
}
