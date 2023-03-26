import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_app/login_page.dart';
import 'package:login_app/user.dart';
import 'package:http/http.dart' as http;


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  Future save() async{
    http.Response res = await http.post(Uri.parse('http://10.0.2.2:5000/signup'),headers: <String, String>{
      'Context-Type':'application/json;charSet=UTF-8'
    },
        body: <String, String>{
          'username': user.username,
          'password': user.password,
        }
    );
    print(user.username);
    print(user.password);
    var resp2 = jsonDecode(res.body);
    if(resp2 == "Already Login Exists."){
      const no_user =  SnackBar(content:
      Center(
        child: Text('Already Registered, Please Login'),
      ),
        backgroundColor: Colors.cyan,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(no_user);
    }
  }
  late String pw1;
  late String pw2;
  User user = User('','');
  bool hidePassword1 = true;
  bool hidePassword2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.cyan,
                  Colors.cyan,
                  Colors.cyan
                ]
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80,),
            const Padding(
              padding: EdgeInsets.all(4),
              child: Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(child: Container(
              decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    )
              ),
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 70,),
                      Form(
                        key: _formKey,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                    )
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  controller: TextEditingController(text: user.username),
                                  onChanged: (value){
                                    user.username = value;
                                  },
                                  decoration: InputDecoration(

                                    hintText: 'New Username',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    icon: Icon(Icons.person_2_sharp, color: Colors.grey,),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                    )
                                ),
                                child: TextField(
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  obscureText: hidePassword1,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    hintText: 'Enter New Password',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    icon: Icon(Icons.lock, color: Colors.grey,),
                                    suffixIcon:IconButton(onPressed: () {
                                      setState(() {
                                        hidePassword1 = !hidePassword1;
                                      });
                                    },
                                    icon: Icon(
                                      hidePassword1 ? Icons.visibility_off : Icons.visibility,
                                    ),)
                                  ),
                                  onChanged: (value){
                                    pw1 = value;
                                  },
                                ),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                    )
                                ),
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  obscureText: hidePassword2,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    hintText: 'Confirm New Password',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    icon: Icon(Icons.lock, color: Colors.grey,),
                                      suffixIcon:IconButton(onPressed: () {
                                        setState(() {
                                          hidePassword2 = !hidePassword2;
                                        });
                                      },
                                        icon: Icon(
                                          hidePassword2 ? Icons.visibility_off : Icons.visibility,
                                        ),)
                                  ),
                                  onChanged: (value){
                                    pw2 = value;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 70,),
                      InkWell(
                        onTap: () {
                          if(pw1 == pw2){
                            user.password = pw1;
                            print(pw1);
                            save();
                          }
                          else{
                              const no_match =  SnackBar(content:
                              Center(
                                  child: Text('Password does not match'),

                              ),
                                backgroundColor: Colors.cyan,
                                duration: Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(no_match);
                            //print(pw1);
                            }
                          },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ),
                      SizedBox(height: 25,),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage(),),
                          );
                          },
                        child: const Center(
                            child: Text(
                              '<<- Back to Login ->>',
                              style: TextStyle(
                                color: Colors.cyan,
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                          )
                        )
                      )
                    ],
                  ),
              ),
            ),
                ),

          ],
        ),
      ),
    );
  }
}


// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(
//         title: Text(
//             'Login Page',
//             style: TextStyle(
//               fontStyle: FontStyle.italic,
//               fontWeight: FontWeight.bold,
//             )),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text(
//           'CONTENT',
//           style: TextStyle(
//             fontStyle: FontStyle.italic,
//           ),
//         ),
//       ),
//     ),
//   ));
// }
//
