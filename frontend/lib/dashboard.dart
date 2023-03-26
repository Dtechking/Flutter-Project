
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        child: Center(
          child: Container(
            height: 400,
            width: 300,
            child: Center(
              child: Text(
                'Login Successful',
                style: TextStyle(
                  fontSize: 35,
                  fontStyle: FontStyle.italic,
                  color: Colors.cyan,
                ),
              ),
            ),

          ),
        ),
      ),
    );
  }
}
