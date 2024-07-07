import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electroshop/pages/productDetail.dart';
import 'package:electroshop/services/database.dart';
import 'package:electroshop/widget/support_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryProducts extends StatefulWidget {
  String category;
  CategoryProducts({required this.category});

  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {

  Stream? CategoryStream;

  getontheload()async{
    CategoryStream=await DatabaseMethods().getProducts(widget.category);
    setState(() {
      
    });
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allProducts(){
    return StreamBuilder(stream: CategoryStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData?GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.6,mainAxisSpacing: 10,crossAxisSpacing: 10.0),itemCount: snapshot.data.docs.length, itemBuilder: (context,index){
          DocumentSnapshot ds=snapshot.data.docs[index];
          return  Container(
                    padding:EdgeInsets.only(bottom: 15,left: 20,right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      SizedBox(height: 20.0,),
                      Image.network(
                        ds["Image"],
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20,),
                      Text(ds["Name"],
                          style: AppWidget.semiboldTextFeildStyle()),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(ds["Price"],
                                style: AppWidget.orangeSemiboldTextFeildStyle()),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(image: ds["Image"], name: ds["Name"], detail: ds["Details"], price: ds["Price"])));
                            },
                            child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Color(0xFFFD6F3E),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      )
                    ]),
                  );
        }):Container();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 222, 222),
      appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 226, 222, 222),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(child: allProducts())
          ],
        ),
      ),
    );
  }
}