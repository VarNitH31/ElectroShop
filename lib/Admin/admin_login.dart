import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electroshop/Admin/home_admin.dart';
import 'package:electroshop/widget/support_widget.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({ Key? key }) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller =new TextEditingController();
  TextEditingController userpasswordcontroller =new TextEditingController();
  @override
  Widget build(BuildContext context) {
 return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 25.0,
          ),
          child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/banner1.webp"),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          "Admin Login",
                          style: AppWidget.boldTextFeildStyle(),
                        )),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "User Name",
                          style: AppWidget.semiboldTextFeildStyle(),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: Color(0xFFF4F5F9),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: usernamecontroller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "User name",
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Password",
                          style: AppWidget.semiboldTextFeildStyle(),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: Color(0xFFF4F5F9),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: userpasswordcontroller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "your password",
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: (){
                            loginAdmin();
                          },
                          child: Center(
                            child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        )
                      ]),
                ),
            SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      
    );
  }
 loginAdmin(){

 FirebaseFirestore.instance.collection("Admin").get().then((snapshop){
 snapshop.docs.forEach((result) {
  if(result.data()['username']!=usernamecontroller.text.trim()){
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("incorrect user name",style: TextStyle(fontSize: 20),)));
  }
  else if(result.data()['password']!=userpasswordcontroller.text.trim()){
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("incorrect user name",style: TextStyle(fontSize: 20),)));
  }
  else{
    Navigator.push(context,MaterialPageRoute(builder: (context)=> HomeAdmin()));
  }
  });

 });
 }
}
  
