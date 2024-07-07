import 'dart:async';
import 'dart:io';

import 'package:electroshop/services/database.dart';
import 'package:electroshop/widget/support_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({ Key? key }) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
 
  final ImagePicker _picker=ImagePicker();
  File? selectedImage;
  TextEditingController nameController=new TextEditingController();
  TextEditingController priceController=new TextEditingController();
  TextEditingController detailController=new TextEditingController();


  Future getImage()async{
    var image=await _picker.pickImage(source: ImageSource.gallery);
    selectedImage=File(image!.path);
    setState(() {
      
    });
  }

  uploadItem()async{
    if(selectedImage!=null && nameController.text!=""){
      String addId=randomAlphaNumeric(10);
      Reference firebaseStorageRef=FirebaseStorage.instance.ref().child("blogImage").child(addId);

      final UploadTask task=firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl= await (await task).ref.getDownloadURL();

      Map<String,dynamic> addProduct={
        "Name":nameController.text,
        "Details":detailController.text,
        "Price":priceController.text,
        "Image":downloadUrl,
      };
      await DatabaseMethods().addProduct(addProduct, value!).then((value){
          selectedImage=null;
          nameController.text="";
          detailController.text="";
          priceController.text="";
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Product has been uplaoded succesfully",style: TextStyle(fontSize: 20),)));

      });

    }
  }

  String? value;
  final List<String> categoryitem=[
    'Watch','Laptop','TV','Headphones'
  ];

  @override
  Widget build(BuildContext context) {
  return Scaffold(

       
       appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text("Add Product",style: AppWidget.boldTextFeildStyle(),),), 

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0,bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text("Upload product image",style: AppWidget.lightTextFeildStyle(),),
              SizedBox(height: 20.0,),
              selectedImage==null? 
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(20)
                    ),
                    child: Icon(Icons.camera_alt_outlined),
                  ),
                ),
              ):Center(
                child: Material(
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 1.5),borderRadius: BorderRadius.circular(20)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(selectedImage!,fit: BoxFit.cover,)),
                    ),
                
                ),
              ),
            SizedBox(height: 20.0,),
            Text("Product Name",style: AppWidget.lightTextFeildStyle(),),
              SizedBox(height: 20.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xffececf8),borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
             SizedBox(height: 40.0,),
            Text("Product Details",style: AppWidget.lightTextFeildStyle(),),
              SizedBox(height: 20.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xffececf8),borderRadius: BorderRadius.circular(20)),
              child: TextField(
                maxLines: 6,
                controller: detailController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
             SizedBox(height: 40.0,),
            Text("Product price",style: AppWidget.lightTextFeildStyle(),),
              SizedBox(height: 20.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xffececf8),borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
             SizedBox(height: 40.0,),
             Text(
              "Product Category",
              style: AppWidget.lightTextFeildStyle(),
             ),
             SizedBox(height: 20.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xffececf8),borderRadius: BorderRadius.circular(10)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(items: categoryitem
                      .map((item)=> DropdownMenuItem(
                        value: item ,
                        child: Text(item,
                          style: AppWidget.semiboldTextFeildStyle(),)))
                      .toList(),onChanged: (value)=>setState(() {
                    this.value=value;
                }),
                dropdownColor: Colors.white,
                hint: Text("Select category"),
                iconSize: 36,
                          value: value,),
              ),
              
            ),
            SizedBox(height: 30,),
            Center(child: ElevatedButton(onPressed: (){
              uploadItem();
            }, child: Text("Add product",style: TextStyle(fontSize: 22),)))
          ],
        ),),
      ),

    );
  }
}