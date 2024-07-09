import 'package:electroshop/pages/signup.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 235, 231),
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
        Image.asset("images/headphone.PNG"),

        Padding(
          padding: const EdgeInsets.only(left:20.0),
          child: Text("Explore\nThe Best\nProducts", style: TextStyle(color:Colors.black,fontSize: 30.0,fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 20.0,),
        Row(
          mainAxisAlignment:MainAxisAlignment.end,
          children: [
            GestureDetector(
               onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
                    },
              child: Container(
                margin: EdgeInsets.only(right: 20.0),
                padding: EdgeInsets.only(left: 25,right: 25,top: 19,bottom: 19),
                decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(90)),
                child: Text("Next", style: TextStyle(color:Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        )
      ],
      ),
      ),
    );
  }
}