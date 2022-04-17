import 'package:applicationtwo/Message.dart';
import 'package:applicationtwo/MyRequest.dart';
import 'package:applicationtwo/Profile.dart';
import 'package:applicationtwo/Rating.dart';
import 'package:applicationtwo/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Login.dart';
import 'Notification.dart';
import 'View.dart';
import 'requestblood.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFC66868),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.book,
                    size: 40,
                    color: Colors.white,
                  ),
                  Text(
                    'Application',
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.add_circle_outlined,
                color: Colors.black,
              ),
              title: const Text(
                'Request Blood',
              ),
              onTap: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.add_circle_outlined,
                color: Colors.black,
              ),
              title: const Text(
                'Message',
              ),
              onTap: () {
                Navigator.pushNamed(context, MessagePage.id);
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.add_circle_outlined,
                color: Colors.black,
              ),
              title: const Text(
                'View Blood Request',
              ),
              onTap: () {
                Navigator.pushNamed(context, View.id);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: const Text(
                'Profile',
              ),
              onTap: () {
                Navigator.pushNamed(context, ProfileApp.id);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.rate_review ,
                color: Colors.black,
              ),
              title: const Text(
                'Rating',
              ),
              onTap: () {
                Navigator.pushNamed(context, Rating.id);
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.rate_review ,
                color: Colors.black,
              ),
              title: const Text(
                'Rating',
              ),
              onTap: () {
                Navigator.pushNamed(context, Myrequest.id);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.mail ,
                color: Colors.black,
              ),
              title: const Text(
                'Message 1-1',
              ),
              onTap: () {
                Navigator.pushNamed(context, Chats.id);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.mail ,
                color: Colors.black,
              ),
              title: const Text(
                'Notifications',
              ),
              onTap: () {
                Navigator.pushNamed(context, Notifications.id);
              },
            ),




            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: const Text(
                'Logout',
              ),
              onTap: ()  {FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false);

                }
              ,


            ),


          ],
        ),
      ),
    );
  }
}
