import 'package:flutter/material.dart';
import 'models(b).dart';
//import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Welcome? userData;
  File? selectedImage;
  String errorMessage = " ";

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        
        title: Text("Profile Screen"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 22,
          letterSpacing: 2.3,
        ),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.home, color: Colors.white,)
            ),
            SizedBox(
              width: 20,
            ),
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.logout, color: Colors.white,)
            ),
            SizedBox(
              width: 20,
            )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Login"),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration),
              title: Text("Sign Up"),
              onTap: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
          ],
        ),
      ),
      body: userData == null
          ? errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
            
                  Center(
                    child: Column(
                      children: [
                        ClipOval(
                          child: selectedImage != null
                              ? Image.file(
                                  selectedImage!,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  userData!.results[0].picture.medium,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
            
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.person, size: 80);
                                  },
                                ),
                        ),
                        SizedBox(height: 15),
            
                        TextButton(
                          onPressed: () {
                            pickImage();
                          },
                          child: Text(
                            "Change Profile Picture",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              letterSpacing: 3.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            
                  SizedBox(height: 10),
            
                  // ✅ SAME PADDING FOR BOTH
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(thickness: 1.5, color: Colors.blue),
                        SizedBox(height: 15),
            
                        Text(
                          "Personal Information:",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        ListTile(
                          onTap: (){},
                         trailing: Icon(Icons.person),
                          title: Row(
                            children: [
                              Text(
                                'User name:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                          
                              Text(
                                "${userData!.results[0].name.first} ${userData!.results[0].name.last}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          onTap: (){
            
                          },
                          trailing: Icon(Icons.email),   
                          title: Row(
                            children: [
                              Text(
                                'Email:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(userData!.results[0].email),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          onTap: (){},
                          trailing: Icon(Icons.phone),
                          title: Row(
                            children: [
                              Text(
                                'Phone:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(userData!.results[0].phone),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          onTap: (){},
                          trailing: Icon(Icons.male),
                          title: Row(
                            children: [
                              Text(
                                'Gender:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(userData!.results[0].gender),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          onTap: (){
                            
                          },
                          trailing: Icon(Icons.flag),
                          title: Row(
                            children: [
                              Text(
                                'Nationality:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(userData!.results[0].nat),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          onTap: (){
                            
                          },
                          trailing: Icon(Icons.cell_tower),
                          title: Row(
                            children: [
                              Text(
                                'Cell:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(userData!.results[0].cell),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          onTap: (){
            
                          },
                          trailing: Icon(Icons.location_city),
                          title: Row(
                            children: [
                              Text(
                                'Location:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "${userData!.results[0].location.city}, ${userData!.results[0].location.country}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          onTap: (){
                            
                          },
                          trailing: Icon(Icons.date_range),
                          title: Row(
                            children: [
                              Text(
                                'Date of Birth:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text(userData!.results[0].dob.date.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
    );
  }

  Future<void> fetchUser() async {
    try {
      final response = await http.get(Uri.parse("https://randomuser.me/api/"));

      if (response.statusCode == 200) {
        final data = welcomeFromJson(response.body);

        setState(() {
          userData = data;
        });
      } else {
        setState(() {
          errorMessage = "Failed to load data";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Internet error";
      });
    }
  }
}
