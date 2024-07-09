import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electroshop/services/database.dart';
import 'package:electroshop/services/shared_preference.dart';
import 'package:electroshop/widget/support_widget.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? email;

  getthesharedpref() async {
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  Stream? orderStream;

  getontheload() async {
    await getthesharedpref();
    orderStream = await DatabaseMethods().getOrders(email!);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getontheload();
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
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
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
                              children: [
                                Image.network(
                                  ds["product_image"],
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                                Spacer(),
                                Padding(

                                  padding: const EdgeInsets.only(right:8.0),
                                  child: Column(
                                                            
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ds["Product"],
                                        style: AppWidget.semiboldTextFeildStyle(),
                                      ),
                                      Text(
                                        "\$" + ds["Price"],
                                        style: TextStyle(
                                            color: Color(0xFFfd6f3e),
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Status:"+ds["Status"],
                                        style: AppWidget.semiboldTextFeildStyle(),
                                      ),                                    
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 222, 222),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 226, 222, 222),
        title:  Text("Your Orders", style: AppWidget.boldTextFeildStyle()),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [Expanded(child: allOrders())],
        ),
      ),
    );
  }
}
