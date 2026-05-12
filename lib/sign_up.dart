import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internship/Login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Sign Up"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(backgroundColor: Colors.blue),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 2.4,
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 450,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    // filled: true,
                    //fillColor: Colors.white,
                    hintText: 'Enter your  name',
                    labelText: 'User name',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        style: BorderStyle.solid,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                        style: BorderStyle.solid,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your name please";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: 35),

              SizedBox(
                width: 450,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        style: BorderStyle.solid,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                        style: BorderStyle.solid,
                        width: 2.0,
                      ),
                    ),
                    //prefixIcon: Icon(Icons.email),
                    suffixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Enter your email please";
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: 35),
              SizedBox(
                width: 450,
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    hintText: "Enter your password",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 94, 116, 134),
                        style: BorderStyle.solid,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                        style: BorderStyle.solid,
                        width: 2.0,
                      ),
                    ),
                    //prefixIcon: Icon(Icons.email),
                    suffixIcon: Icon(Icons.lock),
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter your password please";
                    }else if(value.length < 6){
                      return "Password must be at least 6 characters";
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("User created successfully"),
                            ),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error creating user")),
                          );
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigate to the login page
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Already have an account? Log in",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
