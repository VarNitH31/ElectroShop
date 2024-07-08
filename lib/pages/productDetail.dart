import 'dart:convert';

import 'package:electroshop/services/constant.dart';
import 'package:electroshop/services/database.dart';
import 'package:electroshop/services/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:electroshop/widget/support_widget.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  String image, name, detail, price;
  ProductDetail(
      {required this.image,
      required this.name,
      required this.detail,
      required this.price});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  String? name,mail,image;

  getthesharedpref()async{
    name=await SharedPreferenceHelper().getUserName();
    mail=await SharedPreferenceHelper().getUserEmail();
    image=await SharedPreferenceHelper().getUserImage();

    setState(() {
      
    });
  }

  ontheload()async{
    await getthesharedpref();
    setState(() {
      
    });
  }
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ontheload();
  }

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 222, 222),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30)),
                      child: Icon(Icons.arrow_back_ios_new_outlined))),
              Center(
                  child: Container(
                      height: 300,
                      width: 300,
                      child: Image.network(
                        widget.image,
                        height: 400,
                        fit: BoxFit.cover,
                      )))
            ]),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: AppWidget.boldTextFeildStyle(),
                        ),
                        Text(
                          "Rs "+widget.price,
                          style: TextStyle(
                              color: Color(0xFFfd6f3e),
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      widget.detail,
                      style: AppWidget.semiboldTextFeildStyle(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.detail),
                    SizedBox(
                      height: 75,
                    ),
                    GestureDetector(
                      onTap: () {
                        makePayment(widget.price);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Color(0xFFfd6f3e),
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                          "Buy Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent?['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'varnith'))
          .then((value) {});

      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        Map<String,dynamic> orderInfoMap={
          "Product":widget.name,
          "Price":widget.price,
          "username":name,
          "email":mail,
          "user_image":image,
          "product_image":widget.image,
          "Status":"On the way"
        };
        await DatabaseMethods().orderDetails(orderInfoMap);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(mainAxisSize: MainAxisSize.min, children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        Text("Payment Successful")
                      ],
                    )
                  ]),
                ));
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print("Error is:---->$error $stackTrace");
      });
    } on StripeException catch (e) {
      print("error ---> $e");
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled"),
              ));
    } catch (e) {
      print("error ---> $e");
    }
  }

 createPaymentIntent(String amount,String currency)async{
  try {
    Map<String,dynamic> body={
      'amount':calculateAmount(amount),
      'currency':currency,
      'payment_method_types[]':'card'
    };

    var response= await http.post
            (Uri.parse("https://api.Stripe.com/v1/payment_intents"),
            headers:{'Authorization':'Bearer $secretKey','Content-Type':'application/x-www-form-urlencoded'},body: body,);
            return jsonDecode(response.body);
  } catch (e) {
    print("err cahrnging user: ${e.toString()}");
  }
 }

 calculateAmount(String amount){
  final calculatedAmount=(int.parse(amount)*100);
  return calculatedAmount.toString();
 }

}
