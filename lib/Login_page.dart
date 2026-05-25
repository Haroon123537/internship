// ignore: file_names


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'packagpe:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final formkey = GlobalKey<FormState>();
  bool isloading = false;
  bool isHidden = true;
  bool isTextLoading = false;
  bool isHovering = false;
  bool animate = false;
  late AnimationController _controller;

  //TextEditingController username = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  @override
void initState() {

  super.initState();

  _controller = AnimationController(

    vsync: this,

    duration: Duration(seconds: 4),

  )..repeat(reverse: true);
}

@override
void dispose() {

  _controller.dispose();

  super.dispose();
}

  // ignore: non_constant_identifier_names
  void ValidatingEmail() {
    final bool isValid = EmailValidator.validate(emailcontroller.text.trim());

    if (isValid) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Your Email is valid")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Your email is not valid")));
    }
  }

  Future<void> forgetpassword(BuildContext context) async {
    final email = emailcontroller.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter your email")));
      return;
    }
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("Password reset email sent")));
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //Login in
  // ignore: non_constant_identifier_names
  Future<bool> LoginWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successfully")));

      return true;
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Hero(
            tag: 'signup',
            child: IconButton(
              color: Colors.amberAccent,
              onPressed: (){
                Navigator.pushNamed(context, '/signup');
              },
               icon: Icon(Icons.app_registration_outlined)
               
               ),
          ),
             SizedBox(width: 20),
        ],
      ),
      body: AnimatedBuilder(

  animation: _controller,

  builder: (context, child) {

    return Container(

      decoration: BoxDecoration(

        gradient: LinearGradient(

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,

          colors: [

            Color.lerp(
              Colors.blue,
              Colors.purple,
              _controller.value,
            )!,

            Color.lerp(
              Colors.black,
              Colors.indigo,
              _controller.value,
            )!,
          ],
        ),
      ),

      child: child,
    );
  },


        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(65.0),
            child: TweenAnimationBuilder(
              duration: Duration(seconds: 2),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (BuildContext context, double value, Widget? child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(-200 * (1 - value), 0),
                    child: child,
                  ),
                );
              },
              child: Container(
                width: 400,

                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    width: 3.0,
                    color: Colors.white,
                    style: BorderStyle.solid,
                  ),
                ),

                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Login/Sign in',

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                          wordSpacing: 2.0,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 40),

                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter your email',
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              //color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            suffixIcon: Icon(Icons.mail),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amberAccent,
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
                              return "Enter your email please";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      SizedBox(height: 30),

                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: passwordcontroller,
                          obscureText: isHidden,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              //color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),

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

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amberAccent,
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
                              return "Enter your password please";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      SizedBox(height: 45),

                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            isHovering = true;
                          });
                        },

                        onExit: (_) {
                          setState(() {
                            isHovering = false;
                          });
                        },

                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                            boxShadow: [
                              BoxShadow(
                                color: isHovering
                                    ? Colors.amberAccent
                                    : Colors.transparent,

                                blurRadius: isHovering ? 20 : 0,

                                spreadRadius: isHovering ? 2 : 0,
                              ),
                            ],
                          ),

                          child: Transform.scale(
                            scale: isHovering ? 1.05 : 1.0,

                            child: ConstrainedBox(
                              constraints: BoxConstraints.tightFor(width: 200),

                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isHovering
                                      ? Colors.amber
                                      : Colors.white,
                                ),

                                onPressed: isloading
                                    ? null
                                    : () async {
                                        if (formkey.currentState!.validate()) {
                                          ValidatingEmail();

                                          setState(() {
                                            isloading = true;
                                          });

                                          bool success =
                                              await LoginWithEmailAndPassword(
                                                context,
                                                emailcontroller.text.trim(),
                                                passwordcontroller.text.trim(),
                                              );

                                          await Future.delayed(
                                            Duration(seconds: 3),
                                          );

                                          setState(() {
                                            isloading = false;
                                          });

                                          if (success) {
                                            final prefs =
                                                await SharedPreferences.getInstance();

                                            await prefs.setBool(
                                              "isLoggedIn",
                                              true,
                                            );

                                            Navigator.pushReplacement(
                                              context,

                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage(),
                                              ),
                                            );
                                          }
                                        }
                                      },

                                child: isloading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,

                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        "Sign in",

                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      TextButton(
                        onPressed: () {
                          forgetpassword(context);
                        },
                        child: Text(
                          'Forget your password!! ',
                          style: TextStyle(color: Colors.amberAccent),
                        ),

                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextButton(
                        onPressed: isTextLoading
                            ? null
                            : () async {
                                setState(() {
                                  isTextLoading = true;
                                });

                                await Future.delayed(Duration(seconds: 3));

                                Navigator.pushNamed(context, '/signup');

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
                                "Don't have an account? Sign up here!! ",
                                style: TextStyle(
                                  color: Colors.amberAccent,
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
