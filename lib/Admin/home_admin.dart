import 'package:electroshop/Admin/add_product.dart';
import 'package:electroshop/Admin/all_orders.dart';
import 'package:electroshop/widget/support_widget.dart';
import 'package:flutter/material.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 226, 222, 222),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 226, 222, 222),
          title:
              Text("Admin", style: AppWidget.boldTextFeildStyle()),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddProduct()));
                },
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Add Product",
                          style: AppWidget.boldTextFeildStyle(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllOrders()));
                },
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 50,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "All Orders",
                          style: AppWidget.boldTextFeildStyle(),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
