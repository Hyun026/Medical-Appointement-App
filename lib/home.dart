
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/rendezVous/get.dart';
import 'package:healthy/rendezVous/getforHome.dart';
import 'package:healthy/rendezVous/rendezVous.dart';
import 'package:healthy/screens/login/login.dart';
import 'package:healthy/screens/users/doctor.dart';
import 'package:healthy/screens/users/patient.dart';
import 'package:healthy/search/searchList.dart';
import 'package:healthy/settings/settings.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
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
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _selectedIndex == 0 ? AppBar(
        toolbarHeight: 90.0, 
        leading: const Padding(
          padding: EdgeInsets.all(8.0), 
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.png'), 
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text(
              'Your Name',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ) : null, 
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
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
        selectedItemColor:  MyColors.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final Map<String, IconData> categoryIcons = {
    'Cardiology': Icons.favorite,
    'Dermatology': Icons.face,
    'Neurology': Icons.psychology,
    'Pediatrics': Icons.child_care,
  };

  HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                height: size.height * 0.05,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.primaryColor),
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(11.0),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Search for doctors, clinics, etc.',
                          style: TextStyle(color: MyColors.hintTextColor),
                        ),
                        Icon(Icons.search),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Medical Categories',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 90.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categoryIcons.entries.map((entry) {
                  return CategoryCard(entry.key, entry.value);
                }).toList(),
              ),
            ),
            SizedBox(height: 30.h),
             const MyWidget(),
              SizedBox(height: 30.h),
            Text(
              'Latest Appointment',
              style: Theme.of(context).textTheme.titleLarge,
            ),
           
            const AppointmentCard(), // Database integration here
            SizedBox(height: 20.h),
            Text(
              'Suggested Doctors',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                DoctorCard('Dr. John Doe', 'Cardiologist'),
                DoctorCard('Dr. Jane Smith', 'Dermatologist'),
                DoctorCard('Dr. Mike Johnson', 'Neurologist'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final IconData categoryIcon;

  const CategoryCard(this.categoryName, this.categoryIcon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: MyColors.backgroundColor,
            child: Icon(
              categoryIcon,
              color: Colors.white,
              size: 30.sp,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            categoryName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
//widget
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.15,
      width: size.width*0.8,
      decoration:  BoxDecoration(
        color: MyColors.primaryColor,
       borderRadius: BorderRadius.circular(8.0),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text("Let's get Medical Service",style: TextStyle(color: Colors.white,fontSize: 18.sp, fontWeight: FontWeight.bold),),
                 SizedBox(height: 15.sp),
                 Text("for a healthier life",style: TextStyle(color: Colors.white,fontSize: 18.sp, fontWeight: FontWeight.bold),),
               ],
             ),
           ),
           //svg image
           SvgPicture.asset('assets/images/home/doctor.svg', height: size.height*0.15, width: size.width*0.3,),
        ],
      ),
    );
  }
}


// Use database here and data of the appointment
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
          return const CircularProgressIndicator();
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

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String specialty;

  const DoctorCard(this.doctorName, this.specialty, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/background/back.jpeg'), // Add your doctor's image in assets folder
        ),
        title: Text(doctorName),
        subtitle: Text(specialty),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ),
    );
  }
}