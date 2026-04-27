import 'package:flutter/material.dart';
import 'package:internship/shared_prefereneces_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {

  SharedPreferenecesHelper _preferenecesHelper= SharedPreferenecesHelper();

   int count=0;

   void loadCounter() async {
  final prefs = await SharedPreferences.getInstance();

  int savedValue = prefs.getInt('counter') ?? 0;

  print("Loaded value: $savedValue");

  setState(() {
    count = prefs.getInt('counter') ?? 0;
  });

}

@override
void initState() {
  super.initState();
  loadCounter(); // load saved value when app starts
}



  // The function for a counter app
   void increment() async {
  final prefs = await SharedPreferences.getInstance();

  setState(() {
    count++;
  });

  await prefs.setInt('counter', count);
  print("Saved value: $count"); // save value
}

   void decrement() async {
  final prefs = await SharedPreferences.getInstance();

  setState(() {
    count--;
  });

  await prefs.setInt('counter', count); // save value
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 3.0,
        shadowColor: Colors.blueGrey,
        centerTitle: true,
        title: Text(
          "Counter App",
          style: TextStyle(
            fontSize: 18,
            
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2.3,

          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Images/Counter app background.png"),
            fit: BoxFit.cover
            )
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
        
            children: [
              SizedBox(
                height: 65,
              ),
              Text(
                "Lets Count a bit",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Colors.amberAccent,
                  letterSpacing: 2.5
                ),
        
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 45,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                
                   ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 150),
                    child: ElevatedButton(
                      onPressed: (){
                        increment();
                      }, 
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        alignment: Alignment.center,
                        elevation: 2.0,
                        shadowColor: Colors.blueGrey
        
                        
                      ),
                      child: Icon(
                        Icons.add,
                        size: 12.5,
                        color: Colors.white,
                    
                      )
                      ),
                  ),
                
                SizedBox(
                  height: 20,
                ),
                ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 150),
                    child: ElevatedButton(
                      onPressed: (){
                        decrement();
                      }, 
                       style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        alignment: Alignment.center,
                        elevation: 2.0,
                        shadowColor: Colors.blueGrey
        
                        
                      ),
                      
                     
                      child: Icon(
                        Icons.remove,
                        size: 12.5,
                        color: Colors.white,
                    
                      )
                      ),
                  ),
        
            ],
            
          ),
        ),
      ),

    );
  }
}
