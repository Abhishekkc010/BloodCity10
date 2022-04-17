import 'dart:convert';

import 'package:applicationtwo/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';

import 'Datamodel.dart';
import 'ip/ip_address.dart';
import 'verify.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  static String id = "registration_page";
  static var fullname = TextEditingController();
  static var contactno = TextEditingController();
  static var email = TextEditingController();
  static var City = TextEditingController();
  static var newpassword = TextEditingController();
  static var confirmpassword = TextEditingController();

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  String dropdownValue = 'A+';
  String dropdownValueGender = 'Female';
  String url = "$ip/first/v1/profile";
  final firestore= FirebaseFirestore.instance;

  void validate() {
    if (formKey.currentState!.validate()) {
      register();
    } else {
      const snackBar = SnackBar(content: Text('Please! fill all the field.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  register() async {
    try {
      User? user= (await auth.createUserWithEmailAndPassword(
          email: Registration.email.text,
          password: Registration.confirmpassword.text)) .user;

      if(user!= null){
        user.updateDisplayName(Registration.fullname.value.text);

        await firestore.collection('users').doc(auth.currentUser!.uid).set({
          "userId": auth.currentUser!.uid,
          "email": auth.currentUser!.email,
          "contact": Registration.contactno.value.text,
          "name": Registration.fullname.value.text,
        });

        await Navigator.pushNamed(context, VerifyEmail.id);
      }

    } on FirebaseAuthException catch (e) {
      final snackMessage = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackMessage);
    }
  }

  profile() async {
    String Name = Registration.fullname.value.text;
    String Phone = Registration.contactno.value.text;
    String Email = Registration.email.value.text;
    String BloodType = dropdownValue;
    String Gender = dropdownValueGender;
    String City = Registration.City.value.text;
    String UserId = auth.currentUser!.uid;

    DataModel postProduct = DataModel(
      Name: Name,
      UserEmail: Email,
      Phone: Phone,
      BloodType: BloodType,
      Gender: Gender,
      City: City,
      UserID: UserId,
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
        backgroundColor: const Color(0xFFF3EDED),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 28, horizontal: 43),
                    child: Container(
                      height: 240,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('Images/bloodcity.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: ,),
                  Padding(
                    padding: EdgeInsets.only(right: 165),
                    child: const Text('Register your \nAccount ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,color: Colors.black,
                          fontSize: 35,
                        )),
                  ),
                  SizedBox(height: 25,),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.only(right: 325),
                        //   child: const Text('Name ',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,color: Colors.redAccent,
                        //         fontSize: 25,
                        //       )),
                        // ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                          child: TextFormField(
                            controller: Registration.fullname,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person_outline_outlined),

                              //   InputDecoration(hintText: 'District'),

                            ),
                            validator:
                                RequiredValidator(errorText: 'Required *'),
                            textInputAction: TextInputAction.next ),
                        ),

                        // Padding(
                        //   padding: EdgeInsets.only(right: 325),
                        //   child: const Text('Contact',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,color: Colors.redAccent,
                        //         fontSize: 25,
                        //       )),
                        // ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: Registration.contactno,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textAlign: TextAlign.left,
                            // decoration: InputDecoration(
                            //   // hintStyle: TextStyle(fontWeight: FontWeight.normal),
                            //   hintText: 'Contact no.',
                            // ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone_in_talk_outlined),
                              labelText: 'Contact No',
                              border: OutlineInputBorder(),
                              //   InputDecoration(hintText: 'District'),

                            ),

                            validator:
                                RequiredValidator(errorText: 'Required *'),
                              textInputAction: TextInputAction.next),
                        ),

                        SizedBox(height: 15,),
                       Row(
                         children: [
                           SizedBox(width:20,),
                           Text('BloodType: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                )),

                            DropdownButton<String>(


                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
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
                                  child: Text(value, style: TextStyle(color: Colors.black87, fontSize:20 ),),
                                );
                              }).toList(),
                            ),

                            SizedBox(width: 45,),
                            const Text('Gender: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                )),

                            DropdownButton<String>(


                              value: dropdownValueGender,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.grey),
                              underline: Container(
                                height: 2,
                                color: Colors.redAccent,
                              ),
                              isExpanded: false,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValueGender = newValue!;
                                });
                              },
                              items: <String>['Female', 'Male','Other']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: TextStyle(color: Colors.black87, fontSize:20 ),),
                                );
                              }).toList(),
                            ),
                         ],
                       ),


                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                          child: TextFormField(
                            controller: Registration.email,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              //   InputDecoration(hintText: 'District'),

                            ),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Required *'),
                              EmailValidator(errorText: 'Invalid Email')
                            ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                          child: TextFormField(
                            controller: Registration.City,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_city_outlined),
                              labelText: 'City',
                              border: OutlineInputBorder(),
                              //   InputDecoration(hintText: 'District'),

                            ),
                            validator:
                            RequiredValidator(errorText: 'Required *'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                          child: TextFormField(
                            controller: Registration.newpassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textAlign: TextAlign.left,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_open_outlined),
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              //   InputDecoration(hintText: 'District'),

                            ),
                            validator: MultiValidator(
                              [
                                RequiredValidator(errorText: 'Required *'),
                                MinLengthValidator(6,
                                    errorText: 'Minimum 6 characters'),
                                MaxLengthValidator(15,
                                    errorText: 'Maximum 15 characters'),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                          child: TextFormField(
                            controller: Registration.confirmpassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textAlign: TextAlign.left,
                            obscureText: true,
                            decoration: const InputDecoration(

                              prefixIcon: Icon(Icons.lock_open_outlined),
                              labelText: 'Confirm Password',
                              border: OutlineInputBorder(),
                              //   InputDecoration(hintText: 'District'),

                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Required *';
                              }
                              if (value != Registration.newpassword.text) {
                                return 'password doesnot match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 15, 24, 0),
                    child: SizedBox(
                      width: 200,
                      height: 48,
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          )),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 224, 65, 65),
                          ),
                        ),
                        onPressed: () {
                        profile();
                          validate();
                        },
                        child: const Text(
                          'Sign me up!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(28, 10, 24, 25),
                    // padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        GestureDetector(
                          child: Text("Login",style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                          ),

                          ), onTap: () {
                          Navigator.pushNamed(context, Login.id);
                        },
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
