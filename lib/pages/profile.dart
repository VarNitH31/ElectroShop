import 'dart:io';

import 'package:electroshop/pages/onboarding.dart';
import 'package:electroshop/services/auth.dart';
import 'package:electroshop/services/shared_preference.dart';
import 'package:electroshop/widget/support_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? image, name, email;

  getthesharedpref() async {
    image = await SharedPreferenceHelper().getUserImage();
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

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    uploadItem();
    setState(() {});
  }

  uploadItem() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImage").child(addId);

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();
      await SharedPreferenceHelper().saveUserImage(downloadUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 226, 222, 222),
        title:  Text("Profile", style: AppWidget.boldTextFeildStyle()),
      ),
      backgroundColor: Color.fromARGB(255, 226, 222, 222),
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Column(
                children: [
                  selectedImage != null
                      ? GestureDetector(
                        onTap: (){
                                getImage();
                        },
                        child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.file(
                              selectedImage!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                              ),
                            )),
                      )
                      : GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Center(
                            child: ClipRRect(
                                     borderRadius: BorderRadius.circular(60),
                              child: Image.asset(
                              "images/boy.jpg",
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                                                        ),
                            )),
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Material(
                          elevation: 3.0,
                            borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.circular(10) ),
                            child: Row(
                                children: [
                                  Icon(Icons.person_2_outlined,size: 35,),
                                  SizedBox(width: 10.0,),
                                  Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Text("Name",style: AppWidget.lightTextFeildStyle(),),
                                      Text(name!,style: AppWidget.semiboldTextFeildStyle(),),
                                    ]
                                  )
                                ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: Material(
                          elevation: 3.0,
                            borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.circular(10) ),
                            child: Row(
                                children: [
                                  Icon(Icons.mail_outlined,size: 35,),
                                  SizedBox(width: 10.0,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Email",style: AppWidget.lightTextFeildStyle(),),
                                      Text(email!,style: AppWidget.semiboldTextFeildStyle(),),
                                    ]
                                  )
                                ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      GestureDetector(
                        onTap: ()async{
                          await AuthMethods().SignOut().then((value){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Onboarding()));
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Material(
                            elevation: 3.0,
                              borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.circular(10) ),
                              child: Row(
                                  children: [
                                    Icon(Icons.logout,size: 35,),
                                    SizedBox(width: 10.0,),
                                    Text("LogOut",style: AppWidget.semiboldTextFeildStyle(),),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios_outlined),
                                  ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      GestureDetector(
                        onTap: ()async{
                          await AuthMethods().deleteuser().then((value){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Onboarding()));
                          });
                        },

                        child: Container(
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Material(
                            elevation: 3.0,
                              borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: Colors.white,borderRadius:BorderRadius.circular(10) ),
                              child: Row(
                                  children: [
                                    Icon(Icons.delete,size: 35,),
                                    SizedBox(width: 10.0,),
                                    Text("Delete Account",style: AppWidget.semiboldTextFeildStyle(),),
                                    Spacer(),
                                    Icon(Icons.arrow_forward_ios_outlined),
                                  ],
                              ),
                            ),
                          ),
                        ),
                      )
                ],
              ),
            ),
    );
  }
}
