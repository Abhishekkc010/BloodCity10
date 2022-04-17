import 'dart:convert';
import 'dart:ui';

import 'package:applicationtwo/MyRequest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Datamodel.dart';
import 'Drawer.dart';
import 'ip/ip_address.dart';

void main() => runApp(MaterialApp(
      home: ProfileApp(),
    ));

class ProfileApp extends StatefulWidget {
  const ProfileApp({Key? key}) : super(key: key);
  static String id = "Profile page";

  @override
  State<ProfileApp> createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  String url = "$ip/first/v1/profile";
  Future<List<DataModel>> _getDataList() async {
    Response response = await get(
      Uri.parse(url),
    );
    var responseData = jsonDecode(response.body);
    print(responseData);
    List<DataModel> DataDetails = [];
    for (var i in responseData) {
      DataModel datas = DataModel(
          BloodType: i['BloodType'],
          Name: i['Name'],
          UserEmail: i['UserEmail'],
          Gender: i['Gender'],
          id: i['id'],
          City: i['City'],
          State: i['State'],
          UserID: i['UserID'],
          Phone:i['Phone']);

      DataDetails.add(datas);
      print(DataDetails);
    }

    return DataDetails;
  }

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFE52222),
          title: const Text('MY PROFILE'),
        ),
        drawer: const NavDrawer(),
        body: FutureBuilder(
            future: _getDataList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(
                    child: Text(
                  "No Profile Details Found...",
                  style: TextStyle(color: Colors.black),
                ));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if ('${snapshot.data[index].UserEmail}' ==
                          FirebaseAuth.instance.currentUser!.email) {

                        return Padding(
                          padding: const EdgeInsets.all(10.0),





                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [

                            Container(
                              alignment: Alignment(0.0,2.5,),
                              child: CircleAvatar(
                                backgroundColor: Colors.black12,
                                child:  Icon(
                                  Icons.person,
                                  size: 105,
                                  color: Colors.blueAccent,
                                ),
                                radius: 60.0,
                              ),
                            ),

                                SizedBox(height: 15,),

                                Align(

                                    alignment: Alignment.topLeft,


                                  child: Container(

                                    height: 75,
                                    width: 140,
                                    decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //                 <--- border radius here
                                      ),  color: Color(0xFFF3BE9E),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(

                                        'BloodType\n'
                                            '${snapshot.data[index].BloodType}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          foreground: Paint()
                                            ..style = PaintingStyle.fill
                                          // ..style = PaintingStyle.fill
                                            ..strokeWidth = 6
                                            ..color = Color.fromARGB(
                                                255, 17, 3, 3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 5,),
                                // Align(
                                //
                                //   alignment: Alignment.center,
                                //
                                //
                                //   child: Container(
                                //
                                //     height: 75,
                                //     width: 170,
                                //     decoration:  BoxDecoration(
                                //       borderRadius: BorderRadius.all(
                                //           Radius.circular(5.0) //                 <--- border radius here
                                //       ),  color: Color(0xFFF3AFA3),
                                //     ),
                                //
                                //
                                //   ),
                                // ),



                                SizedBox(height: 15,),


                                 ListTile(
                                  leading: Text(
                                    'Personal Information',
                                    style: TextStyle(
                                      color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w700),
                                  ),

                                 title: IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, Myrequest.id);
                                    },
                                    icon: const Icon(CupertinoIcons.rectangle_stack_person_crop),
                                    iconSize: 28,
                                   color:  Color(0xFFE56C23),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                  subtitle: Text(" My Request",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      foreground: Paint()
                                        ..style = PaintingStyle.fill
                                      // ..style = PaintingStyle.fill
                                        ..strokeWidth = 6
                                        ..color = Color.fromARGB(
                                            255, 17, 3, 3),
                                    ),),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 25.0, top: 5.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: const <Widget>[
                                             Text(
                                              'Name',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 25.0, top: 10.0),
                                  child: Container(
                                    height: 29,
                                    width: 450,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide( //                    <--- top side
                                          color: Colors.deepOrange,
                                          width: 2.0,
                                        ),
                                      ),
                                    //   borderRadius: BorderRadius(
                                    //       Radius.circular(5.0) ,  //      <--- border radius here
                                    //
                                    // ),
                                    ),
                                    child: Text(
                                           ' ${snapshot.data[index].Name}',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        // decoration: TextDecoration.underline,

                                        // backgroundColor: Color(0xFFE37676),
                                          color: Color(0xFF003049),
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400),

                                    ),
                                  ),



                                ),



                                SizedBox(height: 10,),


                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const <Widget>[
                                          Text(
                                            'Email ID',
                                            style: TextStyle(
                                              color: Colors.blue,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 25.0, top: 10.0),
                                  child: Container(
                                    height: 29,
                                    width: 450,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide( //                    <--- top side
                                          color: Colors.deepOrangeAccent,
                                          width: 2.0,
                                        ),
                                      ),
                                      //   borderRadius: BorderRadius(
                                      //       Radius.circular(5.0) ,  //      <--- border radius here
                                      //
                                      // ),
                                    ),
                                    child: Text(
                                      ' ${snapshot.data[index].Email}',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        // decoration: TextDecoration.underline,

                                        // backgroundColor: Color(0xFFE37676),
                                          color: Color(0xFF003049),
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400),

                                    ),
                                  ),



                                ),

                                SizedBox(height: 10,),


                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const <Widget>[
                                          Text(
                                            'Phone Number',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 25.0, top: 10.0),
                                  child: Container(
                                    height: 29,
                                    width: 450,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide( //                    <--- top side
                                          color: Colors.orange,
                                          width: 2.0,
                                        ),
                                      ),
                                      //   borderRadius: BorderRadius(
                                      //       Radius.circular(5.0) ,  //      <--- border radius here
                                      //
                                      // ),
                                    ),
                                    child: Text(
                                      ' ${snapshot.data[index].Phone}',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        // decoration: TextDecoration.underline,

                                        // backgroundColor: Color(0xFFE37676),
                                          color: Color(0xFF003049),
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400),

                                    ),
                                  ),



                                ),


                                SizedBox(height: 10,),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 25.0, top: 25.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const <Widget>[
                                          Text(
                                            'City',
                                            style: TextStyle(
                                              color: Colors.blue,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 25.0, top: 10.0),
                                  child: Container(
                                    height: 29,
                                    width: 450,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide( //                    <--- top side
                                          color: Colors.orange,
                                          width: 2.0,
                                        ),
                                      ),
                                      //   borderRadius: BorderRadius(
                                      //       Radius.circular(5.0) ,  //      <--- border radius here
                                      //
                                      // ),
                                    ),
                                    child: Text(
                                      ' ${snapshot.data[index].City}',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        // decoration: TextDecoration.underline,

                                        // backgroundColor: Color(0xFFE37676),
                                          color: Color(0xFF003049),
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600),

                                    ),
                                  ),



                                ),

                                SizedBox(height: 5,),


                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                           right: 5.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: const <Widget>[
                                              Text(
                                                'Gender :',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                    fontSize: 25.0,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                         left: 2,  top: 25.0),
                                      child: Container(
                                        height: 29,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide( //                    <--- top side
                                              color: Colors.orangeAccent,
                                              width: 2.0,
                                            ),
                                          ),
                                          //   borderRadius: BorderRadius(
                                          //       Radius.circular(5.0) ,  //      <--- border radius here
                                          //
                                          // ),
                                        ),
                                        child: Text(
                                          ' ${snapshot.data[index].Gender}',
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            // decoration: TextDecoration.underline,

                                            // backgroundColor: Color(0xFFE37676),
                                              color: Color(0xFF003049),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),

                                        ),
                                      ),



                                    ),




                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       left: 10.0, right: 25.0, top: 25.0),
                                    //   child: Row(
                                    //     mainAxisSize: MainAxisSize.max,
                                    //     children: <Widget>[
                                    //       Column(
                                    //         mainAxisAlignment: MainAxisAlignment.start,
                                    //         mainAxisSize: MainAxisSize.min,
                                    //         children: const <Widget>[
                                    //           Text(
                                    //             'Name',
                                    //             style: TextStyle(
                                    //                 fontSize: 25.0,
                                    //                 fontWeight: FontWeight.bold),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),

                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       right: 25.0, top: 10.0),
                                    //   child: Container(
                                    //     height: 29,
                                    //     width: 450,
                                    //     decoration: const BoxDecoration(
                                    //       border: Border(
                                    //         bottom: BorderSide( //                    <--- top side
                                    //           color: Colors.black,
                                    //           width: 2.0,
                                    //         ),
                                    //       ),
                                    //       //   borderRadius: BorderRadius(
                                    //       //       Radius.circular(5.0) ,  //      <--- border radius here
                                    //       //
                                    //       // ),
                                    //     ),
                                    //     child: Text(
                                    //       ' ${snapshot.data[index].Name}',
                                    //       textAlign: TextAlign.start,
                                    //       style: const TextStyle(
                                    //         // decoration: TextDecoration.underline,
                                    //
                                    //         // backgroundColor: Color(0xFFE37676),
                                    //           color: Color(0xFF003049),
                                    //           fontSize: 25,
                                    //           fontWeight: FontWeight.w600),
                                    //
                                    //     ),
                                    //   ),
                                    //
                                    //
                                    //
                                    // ),
                                  ],
                                ),

                                SizedBox(height: 10,),







                                // Text(
                                //     'Bloodgroup \n'
                                //     '${snapshot.data[index].BloodType}',
                                //     style: TextStyle(
                                //       fontSize: 25,
                                //       foreground: Paint()
                                //         ..style = PaintingStyle.fill
                                //         // ..style = PaintingStyle.fill
                                //         ..strokeWidth = 6
                                //         ..color = Color.fromARGB(
                                //             255, 134, 16, 16),
                                //     ),
                                //   ),


                                //  Text(
                                // 'Name: '
                                // '${snapshot.data[index].Name}',
                                // style: const TextStyle(
                                //     color: Color(0xFF003049),
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.w600),
                                //   ),
                                //   // trailing: IconButton(
                                //   //     icon: Icon(Icons.delete, color: Colors.red),
                                //   //     onPressed: () {
                                //   //       // deleteId = snapshot.data[index].id;
                                //   //       // deleteProduct();
                                //   //     }),
                                //
                                // Text(
                                // 'City: ${snapshot.data[index].City}',
                                // style: const TextStyle(
                                //     color: Color(0xFF003049),
                                //     fontSize: 18,
                                //     fontWeight: FontWeight.w500),
                                //   ),
                                //
                                // Text(
                                //   'Gender: ${snapshot.data[index].Gender}',
                                //   style: const TextStyle(
                                //       color: Color(0xFF003049),
                                //       fontSize: 18,
                                //       fontWeight: FontWeight.w500),
                                // ),
                              ],
                            ),

                          )
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.all(2),
                      );
                    });
              }
            }),
      ),
    );
  }
}
