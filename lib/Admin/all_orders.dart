import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electroshop/services/database.dart';
import 'package:electroshop/widget/support_widget.dart';
import 'package:flutter/material.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({Key? key}) : super(key: key);

  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  Stream? orderStream;

  getontheload() async {
    orderStream = await DatabaseMethods().getAllOrders();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allOrders() {
    return StreamBuilder(
        stream: orderStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20,left: 10,right: 10),
                        // margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                              padding:
                                  EdgeInsets.only(left: 20, top: 10, bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    ds["product_image"],
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 30),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(ds["username"],style: TextStyle(
                                          color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.bold),),
                                          SizedBox(height: 3),
                                        Text(ds["email"],style:TextStyle(
                                          color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.bold),),
                                          SizedBox(height: 3),
                                        Text(
                                          ds["Product"],
                                          style:
                                              TextStyle(
                                          color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "\$" + ds["Price"],
                                          style: TextStyle(
                                              color: Color(0xFFfd6f3e),
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 15,),
                                        GestureDetector(
                                          onTap: ()async {
                                              await DatabaseMethods().updatestatus(ds.id);
                                              setState(() {
                                                
                                              });
                                          },
                                          child: Container(
                                            width:150 ,
                                            padding: EdgeInsets.symmetric(vertical: 7),
                                            decoration: BoxDecoration(color:Color(0xFFfd6f3e),borderRadius:BorderRadius.circular(10) ),
                                            child: Center(child: Text("Done",style: AppWidget.semiboldTextFeildStyle(),)),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 226, 222, 222),
        title:  Text(
          "All Orders",
          style: AppWidget.boldTextFeildStyle(),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 226, 222, 222),
      body: Container(
        // margin: EdgeInsets.only(top: 50,left: 20,right: 20),
        child: Column(
          children: [Expanded(child: allOrders())],
        ),
      ),
    );
  }
}
