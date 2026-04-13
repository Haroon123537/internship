import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,

           elevation: 3.0,
           shadowColor: Colors.black87,
          actions: [
            Icon(Icons.home,
            color: Colors.white,
            size: 25,
            semanticLabel: 'Home',
            ),
            SizedBox(
              width: 22,
            ),
            Icon(Icons.info,
            color: Colors.white,
            size: 25,
            semanticLabel: 'About us',
            ),
            SizedBox(
              width: 22,
            ),
            Icon(Icons.more_vert,
            color: Colors.white,
            size: 25,
            
            ),
            SizedBox(
              width: 20,
            )
            //Icon(Icons)
          ],
        ),
        drawer: Drawer(),

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Images/home_page.jfif'),
              fit: BoxFit.cover
              )
              
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                  SizedBox(
                    height: 100,
                  ),

                  Text(' Welcome to the Glamourous',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.0
                  ),
                  )

                
              ],),
          ),
        ),
      ),
    );
  }
}