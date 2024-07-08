
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healthy/connectivity/refreshing.dart';

import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/firebasecontrol/firestore/retrieveData.dart';
import 'package:healthy/firebasecontrol/notifications/ui/patientNoti.dart';
import 'package:healthy/recommended/getRecommendation.dart';

import 'package:healthy/rendezVous/getforHome.dart';
import 'package:healthy/rendezVous/rendezVous.dart';
import 'package:healthy/screens/category/cardio.dart';
import 'package:healthy/screens/category/dentisty.dart';
import 'package:healthy/screens/category/derma.dart';
import 'package:healthy/screens/category/endocri.dart';
import 'package:healthy/screens/category/general.dart';
import 'package:healthy/screens/category/nephro.dart';
import 'package:healthy/screens/category/neuro.dart';
import 'package:healthy/screens/category/ophta.dart';
import 'package:healthy/screens/category/ortho.dart';
import 'package:healthy/screens/category/pedia.dart';
import 'package:healthy/screens/category/pneu.dart';

import 'package:healthy/screens/users/patient.dart';
import 'package:healthy/search/searchList.dart';
import 'package:healthy/settings/settings.dart';


class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Future<String> getCurrentUserImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        return userDoc['imageLink'] ?? 'Unknown User'; 
      }
    }
    return 'Unknown User';
  }

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    const MyRendezVous(),
    MyPatient(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? AppBar(
        toolbarHeight: 90.0,
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome back', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            FutureBuilder<String>(
              future: Data().getMessage(), 
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  return Text(
                    snapshot.data ?? 'No message retrieved',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300
                    ),
                  );
                }
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyNotiPatient(),
      ),
    );
  },
          ),
        ],
      ) : null,
      body: RefreshIndicator(
       onRefresh: () => Refreshing(context).refreshPageHomeDoc(),
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
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
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
        selectedItemColor: MyColors.primaryColor, 
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final Map<String, IconData> categoryIcons = {
    'General': Icons.local_hospital,
    'Cardiology': Icons.favorite,
    'Dermatology': Icons.face,
    'Neurology': Icons.psychology,
    'Pediatrics': Icons.child_care,
    'Dentist': Icons.local_hospital, 
    'Endocrinology': Icons.healing,
    'Nephrology': Icons.local_hospital,
    'Orthopedy': Icons.accessible,
    'Pneumology': Icons.air,
    'Ophthalmology': Icons.remove_red_eye,
  };

  HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MySearchBar()),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(color:MyColors.primaryColor),
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(11.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search for doctors, clinics, etc.',
                        style: TextStyle(color: MyColors.primaryColor), 
                      ),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Medical Categories',
           
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 90.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categoryIcons.entries.map((entry) {
                  return CategoryCard(entry.key, entry.value);
                }).toList(),
              ),
            ),
            const SizedBox(height: 30.0),
            const MyWidget(),
            const SizedBox(height: 30.0),
          /*   Text(
              'Latest Appointment',style: TextStyle(fontSize: 20.sp),
         
            ),
            const AppointmentCard(),
            const SizedBox(height: 20.0),*/
             Text(
              'Suggested Doctors',style: TextStyle(fontSize: 20.sp),
        
            ),
      
            const DoctorList(),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final IconData categoryIcon;

  const CategoryCard(this.categoryName, this.categoryIcon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
        switch (categoryName) {
          case 'General':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => General()),
            );
            break;
          case 'Cardiology':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cardiolo()),
            );
            break;
          case 'Dermatology':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dermato()),
            );
            break;
          case 'Neurology':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Neurolo()),
            );
            break;
          case 'Pediatrics':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pediatri()),
            );
            break;
          case 'Dentist':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dentiste()),
            );
            break;
          case 'Endocrinology':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Endocrino()),
            );
            break;
          case 'Nephrology':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Nephrolo()),
            );
            break;
          case 'Orthopedy':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Orthope()),
            );
            break;
          case 'Pneumology':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Pneumo()),
            );
            break;
          case 'Ophthalmology':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Ophtalmo()),
            );
            break;
          default:
          
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: MyColors.primaryColor,
              child: Icon(
                categoryIcon,
                color: Colors.white,
                size: 20.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              categoryName,
              // Add styling or other configurations as needed
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.15,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: MyColors.primaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Let's get Medical Service",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h), 
                Text(
                  "for a healthier life",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/images/home/doctor.svg',
            height: size.height * 0.15,
            width: size.width * 0.3,
          ),
        ],
      ),
    );
  }
}


class AppointmentCard extends StatefulWidget {
  const AppointmentCard({Key? key}) : super(key: key);

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];

  Future<void> getDocId() async {
    await FirebaseFirestore.instance
        .collection('appointments')
        .where('user', isEqualTo: user.uid)
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
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: docIDs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: MyAppointHome(documentId: docIDs[index]),
              );
            },
          );
        }
      },
    );
  }
}

class DoctorList extends StatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {

  List<String> docIDs = [];

  Future<void> getDocId() async {
    await FirebaseFirestore.instance
        .collection('doctors')
      
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
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: docIDs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: MyRecomendation(documentId: docIDs[index]),
              );
            },
          );
        }
      },
    );
  }
}