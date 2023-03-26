import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_app/signup_page.dart';
import 'package:login_app/user.dart';
import 'package:http/http.dart' as http;

import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  Future save() async{
    http.Response res = await http.post(Uri.parse('http://10.0.2.2:5000/login'),headers: <String, String>{
      'Context-Type':'application/json;charSet=UTF-8'
    },
    body: <String, String>{
      'username': user.username,
      'password': user.password,
    },
    );
    String resp = jsonDecode(res.body);
    print(resp);
    if(resp == 'Username Not Found!'){
      const no_user =  SnackBar(content:
      Center(
        child: Text('User Details Not Found!'),
      ),
        backgroundColor: Colors.cyan,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(no_user);
    }
    else{
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => DashBoard()) );
    }
  }

  User user = User('','');
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.cyan,
                Colors.cyan,
                Colors.cyan
              ]
            )
          ),
          child: Form(
            key: _formKey,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Center(
                    child: Text(
                      'Login',
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 60,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                )
                              ),
                              child: TextFormField(
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                controller: TextEditingController(text: user.username),
                                onChanged: (value){
                                  user.username = value;
                                },
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Enter a Username";
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  icon: Icon(Icons.person_2_sharp, color: Colors.grey,),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey),
                                  )
                              ),
                              child: TextField(
                                controller: TextEditingController(text: user.password),
                                onChanged: (value){
                                  user.password = value;
                                },
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                obscureText: hidePassword,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  icon: Icon(Icons.lock, color: Colors.grey,),
                                    suffixIcon:IconButton(onPressed: () {
                                      setState(() {
                                        hidePassword = !hidePassword;
                                      });
                                    },
                                      icon: Icon(
                                        hidePassword ? Icons.visibility_off : Icons.visibility,
                                      ),)
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 70,),

                      InkWell(
                        onTap: (){
                          if( _formKey.currentState!.validate()){
                            save();
                            print("Okk!");
                          }
                          else("Not Ok!");
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),
                      Text("Don't have an account?", style: TextStyle(color: Colors.grey,),),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage(),),
                        );
                    },
                        child:Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
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
                      )
                    ],
                  ),
                ),
              )),

            ],
        ),
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
