import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  Future addUserDetails(Map<String,dynamic> userInfoMap,String id)async{
    


    return await FirebaseFirestore.instance.collection("users").doc(id).set(userInfoMap);
  }
  Future addProduct(Map<String,dynamic> userInfoMap,String categoryname)async{
    
    return await FirebaseFirestore.instance
        .collection(categoryname)
        .add(userInfoMap);
  }

  Future addAllProducts(Map<String,dynamic> userInfoMap)async{ 
    return await FirebaseFirestore.instance
        .collection("Products")
        .add(userInfoMap);
  }
  updatestatus(String id)async{
    
    return await FirebaseFirestore.instance
        .collection("Orders").doc(id)
        .update({"Status":"Delivered"});
  }

  Future orderDetails(Map<String,dynamic> userInfoMap)async{
    return await FirebaseFirestore.instance
        .collection("Orders")
        .add(userInfoMap);
  }
  
  Future<Stream<QuerySnapshot>>getProducts(String category)async{

    return await FirebaseFirestore.instance.collection(category).snapshots();
  }

  Future<Stream<QuerySnapshot>>getOrders(String email)async{

    return await FirebaseFirestore.instance.collection("Orders").where("email",isEqualTo: email).snapshots();
  }

  Future<Stream<QuerySnapshot>>getAllOrders()async{
    return await FirebaseFirestore.instance.collection("Orders").where("Status",isEqualTo:"On the way").snapshots();
  }
  Future<QuerySnapshot>search(String UpdatedName)async{
    return await FirebaseFirestore.instance.collection("Products").where("SearchKey",isEqualTo:UpdatedName.substring(0,1).toUpperCase()).get();
  }

}