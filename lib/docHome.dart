import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:healthy/connectivity/refresh.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/firebasecontrol/firestore/retrieveData.dart';
import 'package:healthy/firebasecontrol/notifications/notification.dart';

import 'package:healthy/rendezVous/getforHome.dart';

import 'package:healthy/screens/users/doctor.dart';

import 'package:healthy/settings/settings.dart';



class MyHomeDoc extends StatefulWidget {
  const MyHomeDoc({super.key});

  @override
  _MyHomeDocState createState() => _MyHomeDocState();
}

class _MyHomeDocState extends State<MyHomeDoc> {
  final Data firestoreService = Data();
  Future<String> getCurrentUserImage() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('doctors').doc(user.uid).get();
    if (userDoc.exists) {
      return userDoc['imageLink'] ?? 'Unknown User'; 
    }
  }
  return 'Unknown User';
}
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    
    MyDocProfile(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _selectedIndex == 0 ? AppBar(
        toolbarHeight: 90.0, 
       
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Dr.',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
                ),
                
                FutureBuilder<String>(
                  future: Data().getMessage4(), 
                  builder: (context, snapshot) {
                    
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }   if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
                 }
                    else {
                      return Text(
                        snapshot.data ?? 'No message retrieved',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0, fontWeight: FontWeight.w300
                        ),
                      );
                    }
                  },
                ),
                SizedBox(width: 8.0),
                FutureBuilder<String>(
                  future: Data().getMessage3(), 
                  builder: (context, snapshot) {
                     if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }   if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(); }
                    else {
                      return Text(
                        snapshot.data ?? 'No message retrieved',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0, fontWeight: FontWeight.w300
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
               showDialog(
      context: context,
      builder: (BuildContext context) => MyNotifications(),
    );
            },
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: FutureBuilder<String>(
                future: getCurrentUserImage(),
                builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(); 
              } else {
                String userImage = snapshot.data ?? 'Unknown User';
              
                if (userImage == 'Unknown User') {
          return Container(); 
                } else {
          return CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          );
                }
              }
                },
              ),
        ),
    
            )
          
       : null, 
      body: RefreshIndicator(
        onRefresh: () => Refresh(context).refreshPageHomeDoc(),
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile Page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:  MyColors.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  

  HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           
             
              SizedBox(height: 30.h),
            Text(
              'Your Appointments',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            
           SizedBox(height: 30.h),
            const AppointmentCard(), 
            SizedBox(height: 20.h),
            
          ],
        ),
      ),
    );
  }
}





class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key});

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('appointments')
        .where('Doctor', isEqualTo: user.uid)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDocId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: docIDs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: MyAppointHom(documentId: docIDs[index]),
              );
            },
          );
        }
      },
    );
  }
}