import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internship/Login_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
//import 'package:cloud_firestore/cloud_firestore.dart' as FirebaseFiresStore;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isTextLoading = false;
  bool isHidden = true;
  late AnimationController _controller;
  bool animate = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,

      duration: Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  void dispose() {
    _controller.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'signup',
      child: Scaffold(
        body: AnimatedBuilder(
          animation: _controller,

          builder: (context, child) {
            return Container(
              height: MediaQuery.of(context).size.height,

              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,

                  end: Alignment.bottomRight,

                  colors: [
                    Color.lerp(Colors.blue, Colors.purple, _controller.value)!,

                    Color.lerp(Colors.black, Colors.indigo, _controller.value)!,
                  ],
                ),
              ),

              child: child,
            );
          },

          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: formKey,
                child: TweenAnimationBuilder(
                  duration: Duration(seconds: 2),

                  tween: Tween<double>(
                    begin: -300, // starts from left side
                    end: 0, // ends at center
                  ),

                  builder: (context, double value, child) {
                    return Transform.translate(
                      offset: Offset(value, 0),

                      child: Opacity(
                        opacity: value == 0 ? 1 : 0.8,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      ColorizeAnimatedTextKit(
                        isRepeatingAnimation: true,
                        repeatForever: true,
                         text: [
                          "Sign Up Please",
                         ],
                          textStyle: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ), 
                          colors: [
                            Colors.blue,
                            Colors.purple,
                            Colors.indigo,

                          ],
                        ),
                      
                      SizedBox(height: 25),
                      SizedBox(
                        width: 450,
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter your  name',
                            labelText: 'User name',
                            labelStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            suffixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,

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
                      SizedBox(height: 25),

                      SizedBox(
                        width: 450,
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                            ),
                            hintText: "Enter your email",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
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
                            if (value!.isEmpty) {
                              return "Enter your email please";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                        width: 450,
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                            ),
                            hintText: "Enter your password",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
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
                             suffixIcon: IconButton(
                              icon: Icon(
                                isHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  isHidden = !isHidden;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your password please";
                            } else if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 35),
                      ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });

                                try {
                                  UserCredential userCredential =
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim(),
                                          );

                                  User? user = userCredential.user;

                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(user!.uid)
                                      .set({
                                        "name": nameController.text.trim(),
                                        "email": emailController.text.trim(),
                                      });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "User created successfully",
                                      ),
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
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }

                                setState(() {
                                  isLoading = false;
                                });
                              },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                            horizontal: 100,
                            vertical: 15,
                          ),
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
                        onPressed: isTextLoading
                            ? null
                            : () async {
                                setState(() {
                                  isTextLoading = true;
                                });

                                await Future.delayed(Duration(seconds: 2));

                                Navigator.pushNamed(context, '/login');

                                setState(() {
                                  isTextLoading = false;
                                });
                              },

                        child: isTextLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "Already have an account? Log in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
