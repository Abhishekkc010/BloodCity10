import 'dart:convert';

import 'package:applicationtwo/Dashboard.dart';
import 'package:applicationtwo/Login.dart';
import 'package:applicationtwo/View.dart';
import 'package:applicationtwo/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Datamodel.dart';
import 'Drawer.dart';
import 'Notification.dart';
import 'Profile.dart';
import 'ip/District.dart';
import 'ip/ip_address.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);
  static String id = "addproduct_page";
  static var Name = TextEditingController();
  static var Phone = TextEditingController();
  static var BloodType = TextEditingController();
  static var State = TextEditingController();
  static var District = TextEditingController();
  static var City = TextEditingController();
  static var RequiredUnit = TextEditingController();
  static var RequiredDate = TextEditingController();
  static var HospitalName = TextEditingController();
  static var DetailAboutCase = TextEditingController();

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  DateTime _date = DateTime(2022, 04, 11);

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2023, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  final auth = FirebaseAuth.instance;
  String dropdownValue = 'A+';
  String dropdownValueGender = 'Male';
  String dropdownValuetwo = 'Bagmati Province';
  String dropdownValuedistrict = "Kathmandu";
  String url = "$ip/first/v1/request";
  //"http://192.168.100.215:8000/first/v1/request";
  //"http://10.0.2.2:8000/first/v1/request";

  addProduct() async {
    String Name = AddProduct.Name.value.text;
    String Phone = AddProduct.Phone.value.text;
    String BloodType = dropdownValue;
    String? UserEmail= FirebaseAuth.instance.currentUser!.email;
    String Gender = dropdownValueGender;
    String State = dropdownValuetwo;
    String District = dropdownValuedistrict;
    String City = AddProduct.City.value.text;
    String RequiredUnit = AddProduct.RequiredUnit.value.text;
    String RequiredDate = '$_date';
    String HospitalName = AddProduct.HospitalName.value.text;
    String DetailAboutCase = AddProduct.DetailAboutCase.value.text;
    String UserId = auth.currentUser!.uid;

    DataModel postProduct = DataModel(
      Name: Name,
      Phone: Phone,
      BloodType: BloodType,
      State: State,
      District: District,
      City: City,
      RequiredDate: RequiredDate,
      RequiredUnit: RequiredUnit,
      HospitalName: HospitalName,
      DetailAboutCase: DetailAboutCase,
      UserID: UserId,
      UserEmail: UserEmail,
    );

    var response = await post(Uri.parse(url),
        body: json.encode(postProduct),
        headers: {'Content-Type': 'application/json'});
    print(response.statusCode);


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Color(0xFFC62828),
          title: const Text('Request Blood'),
        ),
        drawer: const NavDrawer(),
        body: SingleChildScrollView(
          // padding: EdgeInsets.only(left: 20),
           padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // TextFormField(
              //   controller: AddProduct.Name,
              //   decoration: InputDecoration(hintText: 'Name'),
              //   textInputAction: TextInputAction.next,
              // ),
              Padding(
          padding: EdgeInsets.only(left: 88),
                child: const Text('Please Fill This Form ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,color: Colors.blueGrey,
                      fontSize: 23,
                    )),
              ),

              SizedBox(height: 20,),

              const Text('Blood For: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  )),
              SizedBox(height: 5,),
              TextFormField(
                controller: AddProduct.Name,
                textInputAction: TextInputAction.next,
                style: new TextStyle(fontSize: 22, color: Color(0xfff39da1)),
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black54),
                    borderRadius: new BorderRadius.circular(20.7),),
                )
                // decoration: new InputDecoration(
                //     filled: true,
                //     fillColor: Colors.white,
                //     hintText: 'Enter Your Name',
                //     contentPadding: const EdgeInsets.only(
                //         left: 14.0, bottom: 8.0, top: 8.0),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: new BorderSide(color: Colors.black54),
                //       borderRadius: new BorderRadius.circular(25.7),
                //     ),
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: new BorderSide(color: Colors.white),
                //       borderRadius: new BorderRadius.circular(25.7),
                //     )),

              ),

              SizedBox(
                height: 10,
              ),

              Row(
                children: [
                  const Text('BloodType: ',
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  )),



              DropdownButton<String>(


                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 10,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.redAccent,
                ),
                isExpanded: false,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['A+', 'A-', 'O-', 'O+', 'AB-', 'AB+']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.black87, fontSize:25 ),),
                  );
                }).toList(),
              ),

                  // Text('Gender: ',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 23,
                  //     )),
                  //
                  //
                  //
                  // DropdownButton<String>(
                  //
                  //
                  //   value: dropdownValueGender,
                  //   icon: const Icon(Icons.arrow_downward),
                  //   elevation: 10,
                  //   style: const TextStyle(color: Colors.deepPurple),
                  //   underline: Container(
                  //     height: 2,
                  //     color: Colors.redAccent,
                  //   ),
                  //   isExpanded: false,
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       dropdownValueGender = newValue!;
                  //     });
                  //   },
                  //   items: <String>['Male', 'Female', 'Other',]
                  //       .map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(value, style: TextStyle(color: Colors.black87, fontSize:15),),
                  //     );
                  //   }).toList(),
                  // ),

                ],
              ),

              const SizedBox(height: 10,),

                  const Text('Phone: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      )),


              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: AddProduct.Phone,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                    //   InputDecoration(hintText: 'District'),
                    // textInputAction: TextInputAction.next,
                  ),
                ),
              ),

              // TextFormField(
              //   controller: AddProduct.Phone,
              //   textInputAction: TextInputAction.next,
              //   style: new TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
              //   decoration: new InputDecoration(
              //       filled: true,
              //       fillColor: Colors.white,
              //       hintText: 'Phone Number',
              //       contentPadding: const EdgeInsets.only(
              //           left: 14.0, bottom: 8.0, top: 8.0),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: new BorderSide(color: Colors.black54),
              //         borderRadius: new BorderRadius.circular(25.7),
              //       ),
              //       enabledBorder: UnderlineInputBorder(
              //         borderSide: new BorderSide(color: Colors.white),
              //         borderRadius: new BorderRadius.circular(25.7),
              //       )),
              // ),
              const SizedBox(height: 15,),

              const Text('State: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  )),

              DropdownButton<String>(
                value: dropdownValuetwo,
                icon: const Icon(Icons.arrow_downward),
                elevation: 50,
                style: const TextStyle(color: Colors.black),
                underline: Container(
              height: 2,
              color: Colors.redAccent,
                ), isExpanded: true,
                onChanged: (String? newValue) {
              setState(() {
                dropdownValuetwo = newValue!;
              });
                },
                items: <String>[
              '	Province No. 1',
              'Madhesh Province',
              'Bagmati Province',
              'Gandaki Province',
              'Lumbini Province',
              'Karnali Province',
              'Sudurpashchim Province'
                ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.black87, fontSize:25 ),)
              );
                }).toList(),
              ),

              const SizedBox(height: 15,),
              SizedBox(height: 15,),

              const Text('District: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  )),

              DropdownButton<String>(

                value: dropdownValuedistrict,
                icon: const Icon(Icons.arrow_downward),
                elevation: 50,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.redAccent,
                ), isExpanded: false,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValuedistrict = newValue!;
                  });
                },
                items: <String>[
                  'Bhojpur',
                  'Dhankuta',
                  'Ilam',
                  'Jhapa',
                  'Morang',
                  'Taplejung',
                  'Sunsari',
                  'Solukhumbu',
                  'Udayapur',
                  'Bara',
                  'Saptari',
                  'Rautahat',
                  'Parsa',
                  'Siraha',
                  'Bhaktapur District',
                  'Chitwan',
                  'Kathmandu',
                  'Lalitpur',
                  'Sindhuli',
                  'Kaski',
                  'Lamjung',
                  'Myagdi',
                  'Mustang',
                  'Nawalpur',
                  'Palpa',
                  'Rolpa'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,  style: TextStyle(color: Colors.black87, fontSize:25 ),),
                  );
                }).toList(),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(30.0),
              //   child: TextFormField(
              //     controller: AddProduct.State,
              //     decoration: InputDecoration(hintText: 'State'),
              //     textInputAction: TextInputAction.next,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(30.0),
              //   child: TextFormField(
              //     controller: AddProduct.District,
              //     decoration: InputDecoration(
              //       labelText: 'District',
              //       border: OutlineInputBorder(),
              //       //   InputDecoration(hintText: 'District'),
              //       // textInputAction: TextInputAction.next,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 15,),

              const Text('City: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  )),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: AddProduct.City,
                  decoration: InputDecoration(
                    labelText: '',
                    hintText: 'Kathmandu',
                    border: OutlineInputBorder(),
                    //   InputDecoration(hintText: 'District'),
                    // textInputAction: TextInputAction.next,
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              const Text('Required Blood: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  )),
              Padding(
                 padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: AddProduct.RequiredUnit,
                  decoration: InputDecoration(
                    labelText: 'Units:Eg 2 Pints',
                    // hintText: '2 Pints',
                    border: OutlineInputBorder(),
                    //   InputDecoration(hintText: 'District'),
                    // textInputAction: TextInputAction.next,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(30.0),
              //   child: TextFormField(
              //     controller: AddProduct.City,
              //     decoration: InputDecoration(hintText: 'City'),
              //     textInputAction: TextInputAction.next,
              //   ),
              // ),
              const SizedBox(height: 20,),

              const Text('Choose Date : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  )),
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 210, 131, 80),
                ),),
                onPressed: _selectDate,
                child: Text('SELECT Required DATE '),
              ),
              SizedBox(height: 8),
              Text(
                'Date Selected For: $_date',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 19,
                  )
              ),
              // Padding(
              //   padding: const EdgeInsets.all(30.0),
              //   child: TextFormField(
              //     controller: AddProduct.RequiredUnit,
              //     decoration: InputDecoration(hintText: 'RequiredBloodUnit'),
              //     textInputAction: TextInputAction.next,
              //   ),
              // ),

              // Padding(
              //   padding: const EdgeInsets.all(30.0),
              //   child: TextFormField(
              //     controller: AddProduct.RequiredDate,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'RequiredDate',
              //     ),
              //
              //     textInputAction: TextInputAction.next,
              //     //  InputDecoration(hintText: 'RequiredDate'),
              //   ),
              // ),

              const SizedBox(height: 20,),

              const Text('Hospital Name: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  )),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: AddProduct.HospitalName,
                  decoration: InputDecoration(
                    labelText: '',
                    border: OutlineInputBorder(),
                    //   InputDecoration(hintText: 'District'),
                    // textInputAction: TextInputAction.next,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(30.0),
              //   child: TextFormField(
              //     controller: AddProduct.HospitalName,
              //     decoration: InputDecoration(hintText: 'HospitalName'),
              //     textInputAction: TextInputAction.next,
              //   ),
              // ),
              const SizedBox(height: 20,),

              const Text('Information For Purpose of Blood : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  )),
              Padding(
                // padding: const EdgeInsets.all(25.0),
                 padding: EdgeInsets.only(left: 0),
                child: TextFormField(
                  controller: AddProduct.DetailAboutCase,
                  decoration: InputDecoration(hintText: 'Detail About Case'),
                  textInputAction: TextInputAction.done,
                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.only(left: 125),
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF41AAB9),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        )),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 236, 18, 10),
                        ),
                      ),
                      onPressed: () {
                        addProduct();
                      },
                      child: const Text("Submit")),

                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: Container(
        //   // decoration: ,
        //   height: 67,
        //   child: BottomAppBar(
        //     color: Color.fromARGB(255, 243, 232, 232),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         SizedBox(
        //           width: 75,
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               IconButton(
        //                 onPressed: () {
        //                   Navigator.pushNamed(context, Dashboard.id);
        //                 },
        //                 icon: const Icon(CupertinoIcons.home),
        //                 color: Colors.black,
        //                 padding: EdgeInsets.zero,
        //                 constraints: const BoxConstraints(),
        //               ),
        //               const SizedBox(
        //                 height: 5.0,
        //               ),
        //               const Text("Home")
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 75,
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               IconButton(
        //                 onPressed: () {
        //                   Navigator.pushNamed(context, View.id);
        //                 },
        //                 icon: const Icon(CupertinoIcons.doc_plaintext),
        //                 padding: EdgeInsets.zero,
        //                 constraints: const BoxConstraints(),
        //               ),
        //               const SizedBox(
        //                 height: 5.0,
        //               ),
        //               const Text("View")
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 75,
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               // GestureDetector(onTap: (){}, child: Icon(CupertinoIcons.person),),
        //               Container(
        //                 height: 45,
        //                 width: 45,
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(25),
        //                   color: const Color(0xEAEA5454),
        //                 ),
        //                 child: IconButton(
        //                   onPressed: () {
        //                     Navigator.pushNamed(context, View.id);
        //                   },
        //                   icon: const Icon(
        //                     CupertinoIcons.plus,
        //                     color: Colors.white,
        //                   ),
        //                   padding: EdgeInsets.zero,
        //                   iconSize: 40,
        //                   constraints: const BoxConstraints(),
        //                 ),
        //               ),
        //               const SizedBox(
        //                 height: 5.0,
        //               ),
        //               // const Text("Sell")
        //               // Text("Scan/Pay",)
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 75,
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               IconButton(
        //                 onPressed: () {Navigator.pushNamed(context, Notifications.id);},
        //                 icon: const Icon(CupertinoIcons.bell),
        //                 padding: EdgeInsets.zero,
        //                 constraints: const BoxConstraints(),
        //               ),
        //               const SizedBox(
        //                 height: 5.0,
        //               ),
        //               const Text("Notification")
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 75,
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               IconButton(
        //                 onPressed: () {
        //                   Navigator.pushNamed(context, ProfileApp.id);
        //                 },
        //                 icon: const Icon(CupertinoIcons.person),
        //                 padding: EdgeInsets.zero,
        //                 constraints: const BoxConstraints(),
        //               ),
        //               const SizedBox(
        //                 height: 5.0,
        //               ),
        //               const Text("Account")
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
