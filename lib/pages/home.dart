import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electroshop/pages/categoryProducts.dart';
import 'package:electroshop/pages/productDetail.dart';
import 'package:electroshop/services/database.dart';
import 'package:electroshop/services/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:electroshop/widget/support_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

bool search=false;

class _HomeState extends State<Home> {
  List categories = [
    "images/headphone_icon.png",
    "images/laptop.png",
    "images/watch.png",
    "images/TV.png"
  ];

  List Categoryname=[
    "Headphones",
    "Laptop",
    "Watch",
    "TV"
  ];


  var queryResultSet=[];
  var tempSearchStore=[];

  initiateSearch(value){
    if(value.length == 0){
      setState(() {
        search=false;
          queryResultSet=[];
           tempSearchStore=[];
      });
  }
  else{
    setState(() {
      search=true;  
    });
  }

    // var capitalizedValue=value.substring(0,1).toUpperCase()+value.substring(1);
    // if(queryResultSet.isEmpty && value.length==1){
    //   DatabaseMethods().search(value).then((QuerySnapshot docs){
    //     for(int i=0;i<docs.docs.length;++i){
    //       queryResultSet.add(docs.docs[i].data());
    //     }
    //   });
    // }
    // else{
    //   tempSearchStore=[];
    //   queryResultSet.forEach((element){
    //     if(element['UpdatedName'].startsWith(capitalizedValue)){
    //       setState(() {
    //         tempSearchStore.add(element);
    //       });
    //     }
    //   });
    // }

  }
   
  String? name,image;
  Stream? ProductStream;

  getthesharedpref()async{

    name=await SharedPreferenceHelper().getUserName();
    image=await SharedPreferenceHelper().getUserImage();
    setState(() {
      
    });
  } 

  ontheload()async{
    await getthesharedpref();
    ProductStream=await DatabaseMethods().getAllProducts();
    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    ontheload();
    super.initState();
  }


  Widget allProducts(){
    return StreamBuilder(stream: ProductStream, builder: (context, AsyncSnapshot snapshot){
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
                      SizedBox(height: 10,),
                      Text(ds["Name"],
                          style: TextStyle(
                                          color: Colors.black54, fontSize: 15.0, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("Rs "+ds["Price"],
                                  style:TextStyle(
                                              color: Color(0xFFfd6f3e),
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),),
                            
                            Spacer(),
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
                        ),
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
      body: name==null? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hey,"+name!, style: AppWidget.boldTextFeildStyle()),
                        Text("Good Morning", style: AppWidget.lightTextFeildStyle()),
                      ],
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "images/boy.jpg",
                          height: 65,
                          width: 65,
                          fit: BoxFit.cover,
                        ))
                  ],
                ),
                SizedBox(height: 30.0),
                Container(
                    // padding: EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      // onChanged: (value){
                      //   search=true;
                      //   print(search);
                      // },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Products",
                          hintStyle: AppWidget.lightTextFeildStyle(),
                          prefixIcon: Icon(Icons.search, color: Colors.black)),
                    )),
                SizedBox(
                  height: 20.0,
                ),
          
                search? ListView(
                    padding: EdgeInsets.only(left: 10.0,right: 10.0),
                ) :  
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "See All",
                        style: TextStyle(
                            color: Color(0xFFfd6f3e),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 130,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFFD6F3E),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        "All",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Expanded(
                      child: Container(
                        height: 130,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return categoryTile(image: categories[index],name: Categoryname[index],);
                            }),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Products",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 230,
                  child:Column(
          children: [
            Expanded(child: allProducts())
          ],
        ),
                )
              ],
            ),
          ),
      ),
    );
  }
}

// ignore: must_be_immutable
class categoryTile extends StatelessWidget {
  String image,name;
  categoryTile({required this.image,required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryProducts(category: name)));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        height: 90,
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            // SizedBox(height: 10,),
            Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}


