import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'package:email_validator/email_validator.dart';
//import 'packagpe:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  bool isloading = false;
  bool isHidden = true;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

   void ValidatingEmail(){
    final bool isValid= EmailValidator.validate(email.text.trim());
   
   if(isValid){
   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Your Email is valid"))
   );
   }
   else{
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Your email is not valid"))
    );
   }
   } 

  //Login in
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
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successfully")));

      return true;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Images/Login page background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              width: 400,

              decoration: BoxDecoration(
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
                      'Login/Sign up',

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
                        controller: username,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your  name',
                          labelText: 'User name',
                          labelStyle: TextStyle(
                            //color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          suffixIcon: Icon(Icons.person),
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
                            return "Enter your name please";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    SizedBox(height: 35),

                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: email,
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

                    SizedBox(height: 50),

                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: password,
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

                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 200),
                      child: ElevatedButton(
                        onPressed: isloading
                            ? null // disable button when loading
                            : () async {
                                if (formkey.currentState!.validate()) {

                                   ValidatingEmail();
                                  setState(() {
                                    isloading = true;
                                  });

                                  bool success =
                                      await LoginWithEmailAndPassword(
                                        context,
                                        email.text.trim(),
                                        password.text.trim(),
                                      );

                                  // wait 3 seconds (optional)
                                  await Future.delayed(Duration(seconds: 3));

                                  setState(() {
                                    isloading = false;
                                  });

                                  if (success) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
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

                    SizedBox(height: 25),

                    TextButton(
                      onPressed: () {},
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
