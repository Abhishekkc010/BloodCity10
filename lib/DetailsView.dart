import 'dart:convert';


import 'package:applicationtwo/Datamodel.dart';
import 'package:applicationtwo/NotificationModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'ip/ip_address.dart';

class DetailProduct extends StatefulWidget {
  final int id;
  const DetailProduct({required this.id});
  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  String url = "$ip/first/v1/request";
      // "http://192.168.100.215:8000/first/v1/request";
  String requestUrl = "$ip/first/v1/donor/";

  final auth = FirebaseAuth.instance;
  //
  int? ReqId;
  String? ReqName;
  String? ReqPhone;
  String? ReqBloodType;
  String? ReqCity;
  String? ReqState;
  String? ReqEmail;
  String? PostEmail;
  String? ReqUserID;
  String? PostUserId;
  bool isWaiting = true;
  Future<List<DataModel>> _getSpecificProductList() async {
    isWaiting = false;
    Response response = await get(
      Uri.parse('$url/${widget.id}'),
    );
    var productResponseData = jsonDecode(response.body);
    //print(response.statusCode);
    print(productResponseData);
    List<DataModel> productDetails = [];
    // for (var i in productResponseData) {
    // DataModel products = DataModel(
    //   id: productResponseData['id'],
    //   Name: productResponseData['Name'],
    //   Phone: productResponseData['Phone'],
    //   BloodType: productResponseData['BloodType'],
    //   City: productResponseData['City'],
    //   State: productResponseData['State'],
    //   UserID: productResponseData['UserID'],
    //   Email: productResponseData['Email'],
    // );
    setState(() {
      ReqId = productResponseData['id'];
      ReqName = productResponseData['Name'];
      ReqPhone= productResponseData['Phone'];
      ReqBloodType = productResponseData['BloodType'];
      ReqCity = productResponseData['City'];
      ReqState = productResponseData['State'];
      ReqUserID= productResponseData['UserID'];
      PostEmail = productResponseData['UserEmail'];
      PostUserId= productResponseData['PostUserId'];

    });

    // productDetails.add(products);
    // print(productDetails);
    // }

    return productDetails;
  }



  requestProd() async {
    String? Name = ReqName;
    String? Phone= ReqPhone;
    String? postUserId = ReqUserID;
    String? requestUserId = auth.currentUser!.uid;
    String? postEmail = PostEmail;
    String? requestEmail = auth.currentUser!.email;
    String? BloodType = ReqBloodType;
    String? City = ReqCity;

    NotificationModel donor = NotificationModel(
      id: 0,
      Name: Name,
      Phone: Phone,
      requestUserId:requestUserId,
      postUserId:postUserId,
      requestEmail:requestEmail,
      postEmail:postEmail,
      isAccepted:false,
      BloodType:BloodType,
      City:City,

    );

    var response = await post(Uri.parse(requestUrl),
        body: json.encode(donor),
        headers: {'Content-Type': 'application/json'});
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      const snackBar = SnackBar(content: Text('The Request has been sent!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar =
      SnackBar(content: Text('The Request could not be sent!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

// NotificationModel donor = NotificationModel(
//     id: 0,
//     Name: Name,
//     Phone: Phone,
//     requestUserId:requestUserId,
//     postUserId:postUserId,
//     requestEmail:requestEmail,
//     postEmail:postEmail,
//     isAccepted:false,
//     BloodType:BloodType,
//     City:City,
//
// )


  @override
  void initState() {
    super.initState();
    _getSpecificProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(251, 216, 23, 23),
        title: const Text('Detail View'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 248, 248, 248),
                    Color.fromARGB(255, 246, 246, 246)
                  ]
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //
                //   widget.id.toString(),
                //   style: TextStyle(
                //     fontSize: 40,
                //     foreground: Paint()
                //       ..style = PaintingStyle.fill
                //       ..strokeWidth = 6
                //       ..color = Colors.black87,
                //   ),
                // ),
                SizedBox(height: 10,),

                // Container(
                //   height: 85.0,
                //   width: 85.0,
                //   alignment: Alignment.bottomRight,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage('Images/View.jpg'),  fit: BoxFit.fitHeight),
                //       color: Colors.white,
                //       border: Border.all(
                //         color: Colors.white,
                //         width: 2.0,
                //       ),
                //       // borderRadius: BorderRadius.circular(70.0),
                //       borderRadius: const BorderRadius.all(Radius.circular(100))),
                //  padding: const EdgeInsets.only(left:80.0),
                //       // borderRadius: BorderRadius.circular(70.0),
                // ),

          SizedBox(height: 15),

          // Container(
          //   height: 80.0,
          //   width: 100.0,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     border: Border.all(
          //       color: Colors.white,
          //       width: 2.0,
          //     ),
          //     // borderRadius: BorderRadius.circular(70.0),
          //     borderRadius: const BorderRadius.all(Radius.circular(40))),
                  Text(
                    isWaiting ? '?' : 'BloodGroup: ${ReqBloodType.toString()}',
                    style: TextStyle(
                      fontSize: 45,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                // ),
                Text(
                  isWaiting ? '?' : 'Phone: ${ReqPhone.toString()}',
                  style: TextStyle(
                    fontSize: 45,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  isWaiting ? '?' : 'Name: ${ReqName.toString()}',
                  style: TextStyle(
                    fontSize: 40,
                    foreground: Paint()
                      ..style = PaintingStyle.fill
                      ..strokeWidth = 6
                      ..color = Color.fromARGB(255, 134, 16, 16),
                  ),
                ),
                SizedBox(height: 5,),
          Container(
            height: 250.0,
            width: 370.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Images/View.jpg'),  fit: BoxFit.fitHeight, opacity: 180.0),
                color: Colors.white,
                border: Border.all(
                  color: Colors.redAccent,
                  width: 2.0,
                ),
                 // borderRadius: BorderRadius.circular(70.0),
                 borderRadius: const BorderRadius.all(Radius.circular(40)),
                gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(251, 246, 245, 245)
                      ,Color.fromARGB(251, 255, 255, 255),

                    ]
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey ,
                      blurRadius: 5.0,
                      offset: Offset(-5.0,5.0)
                  )
                ]
            ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [



                Text(
                  isWaiting ? '?' : 'City: ${ReqCity.toString()}',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight:FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.fill
                      ..strokeWidth = 6
                      ..color = Color.fromARGB(255, 7, 0, 0),
                  ),
                ),
                SizedBox(height: 5,),

                Text(
                  isWaiting ? '?' : 'State: ${ReqState.toString()}',
                  style: TextStyle(
                    fontWeight:FontWeight.bold,
                    fontSize: 30,
                    foreground: Paint()
                      ..style = PaintingStyle.fill
                      ..strokeWidth = 6
                      ..color = Color.fromARGB(255, 134, 16, 16),
                  ),
                ),


                      Text(
                        isWaiting ? '?' : 'Email: ${PostEmail.toString()}',
                        style: TextStyle(
                          fontWeight:FontWeight.bold,
                          fontSize: 30,
                          foreground: Paint()
                            ..style = PaintingStyle.fill
                            ..strokeWidth = 6
                            ..color = Color.fromARGB(255, 134, 16, 16),
                        ),
                      ),



                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 233, 56, 56),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 233, 56, 56),
                      ),
                    ),
                    onPressed: () {
                      requestProd();

                    },
                    child: const Text('Request To Donate'))
                // Expanded(
                //     child: Image(
                //         image: NetworkImage(isWaiting
                //             ? 'https://picsum.photos/250?image=9'
                //             : disImage.toString()))),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


