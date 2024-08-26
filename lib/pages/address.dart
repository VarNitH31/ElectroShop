import 'package:electroshop/pages/bottomnav.dart';
import 'package:electroshop/services/database.dart';
import 'package:electroshop/services/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:electroshop/pages/signup.dart';
import 'package:electroshop/widget/support_widget.dart';
import 'package:random_string/random_string.dart';

class Addresses extends StatefulWidget {
  const Addresses({Key? key}) : super(key: key);

  @override
  _AddressesState createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  String? email="",name="",address="",pin="",phone="";
    getthesharedpref() async {
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getthesharedpref();
    super.initState();
  }
  
  TextEditingController pincontroller=new TextEditingController();
  TextEditingController addresscontroller=new TextEditingController();
  TextEditingController phonecontroller=new TextEditingController();


  final _formkey=GlobalKey<FormState>();
  
    storeAddress()async{
    if(phonecontroller!="" && addresscontroller.text!="" && pincontroller.text!=""){

      Map<String,dynamic> address={
        "Name":name,
        "Email":email,
        "Address":addresscontroller.text,
        "Phone":phonecontroller.text,
        "pincode":pincontroller.text,
      };
      await DatabaseMethods().addAddress(address).then((value)async{
          pincontroller.text="";
          phonecontroller.text="";
          addresscontroller.text="";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 4, 242, 32),
          content: Text("Address has been uplaoded succesfully",style: TextStyle(fontSize: 20),)));
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 226, 222, 222),
        title: Text("Address", style: AppWidget.boldTextFeildStyle()),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 25.0,
          ),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                            child: Text(
                          "please enter the your address detail below",
                          style: AppWidget.lightTextFeildStyle(),
                        )),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Email",
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
                              validator: (value){
                                if(value==null||value.isEmpty){
                                  return 'please enter address';
                                }
                                return null;
                              },
                              controller: addresscontroller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "flat no,street,city,state",
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Pincode",
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
                              validator: (value){
                                if(value==null||value.isEmpty){
                                  return 'please enter your password';
                                }
                                return null;
                              },
                              controller: pincontroller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "your pincode",
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: Color(0xFFF4F5F9),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              validator: (value){
                                if(value==null||value.isEmpty){
                                  return 'please enter your contact';
                                }
                                return null;
                              },
                              controller: phonecontroller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "+91",
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
                            storeAddress();
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
                                    "SAVE",
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
      ),
    );
  }
}
