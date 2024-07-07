import 'package:flutter/material.dart';
import 'package:electroshop/widget/support_widget.dart';

class ProductDetail extends StatefulWidget {
  String image,name,detail,price;
  ProductDetail({required this.image,required this.name,required this.detail,required this.price});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 222, 222),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children:[ GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(30)),
                  child: 
                    Icon(Icons.arrow_back_ios_new_outlined))),
              
              Center(child: Container(
                height: 300,
                width: 300,
                child: Image.network(widget.image,height: 400,fit: BoxFit.cover,)))
          ]),

          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20,left: 20,right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              ),
              width:MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.name, style: AppWidget.boldTextFeildStyle(),),
                      Text(
                      widget.price,
                      style: TextStyle(
                          color: Color(0xFFfd6f3e),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Text(widget.detail,style: AppWidget.semiboldTextFeildStyle(),),
                  SizedBox(height: 10,),
                  Text(widget.detail),
                  SizedBox(height: 75,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration( color: Color(0xFFfd6f3e),borderRadius: BorderRadius.circular(10) ),
                    width: MediaQuery.of(context).size.width,
                          
                    child: Center(child: Text("Buy Now",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                  )
                ],
              ) ,
              ),
          )
          ],
        ),
      ),
    );
  }
}
