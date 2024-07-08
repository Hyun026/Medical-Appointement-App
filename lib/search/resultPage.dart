
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// here i will make rendez vous
class MyResult extends StatefulWidget {
  final Map<String, dynamic> doctorDetails;

  const MyResult({Key? key, required this.doctorDetails}) : super(key: key);

  @override
  State<MyResult> createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
  String? valueChoose;
  List<String> listItem = [
    "9:00-10:00",
    "10:00-11:00",
    "11:00-12:00",
    "13:00-14:00",
    "14:00-15:00",
    "15:00-16:00",
    "16:00-17:00",
    "17:00-18:00",
    "18:00-18:30"
  ];

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _dateController.text = selectedDay
          .toLocal()
          .toString()
          .split(' ')[0]; 
    });
  }

 Future<String> getCurrentUserName() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (userDoc.exists) {
      return userDoc['name'] ?? 'Unknown User'; 
    }
  }
  return 'Unknown User';
}

Future<String> getCurrentImage() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (userDoc.exists) {
      return userDoc['imageLink'] ?? 'Unknown User'; 
    }
  }
  return 'Unknown User';
}


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage(widget.doctorDetails['imageLink']),
              ),
            ),
            SizedBox(height: 20.sp),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dr.',style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),),
                  SizedBox(width: size.width*0.01,),
                  Text(
                    widget.doctorDetails['name'],
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: size.width*0.03,),
                  Text(
                    widget.doctorDetails['lastname'],
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  
                ],
              ),
            ),
            SizedBox(height: 10.sp),
            Center(
              child: Text(
                widget.doctorDetails['field'],
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            SizedBox(height: 10.sp),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  const Icon(Icons.location_pin,color: MyColors.primaryColor,),
                  Text(
                    widget.doctorDetails['address'] ?? "No address",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
            
           
          ],
        ),
      ),
   bottomNavigationBar:BottomAppBar(
    color: Colors.white,
    child: 
      ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SingleChildScrollView(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Select Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20.sp),
                                  TableCalendar(
                                    calendarStyle: CalendarStyle(
                                                            selectedDecoration:
                                                                const BoxDecoration(
                                                                    color:
                                                                        MyColors
                                                                            .primaryColor,
                                                                    shape:
                                                                        BoxShape
                                                                            .circle),
                                                            todayDecoration: BoxDecoration(
                                                                color: MyColors
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        0.5),
                                                                shape: BoxShape
                                                                    .circle)),
                                    locale: 'en_US',
                                    headerStyle: const HeaderStyle(
                                      formatButtonVisible: false,
                                      titleCentered: true,
                                    ),
                                    focusedDay: _focusedDay,
                                    onDaySelected: (selectedDay, focusedDay) {
                                      setModalState(() {
                                        _selectedDay = selectedDay;
                                        _focusedDay = focusedDay;
                                        _dateController.text =
                                            DateFormat('yyyy-MM-dd').format(
                                                selectedDay); 
                                      });
                                    },
                                    availableGestures: AvailableGestures.all,
                                    selectedDayPredicate: (day) =>
                                        isSameDay(_selectedDay, day),
                                    firstDay: DateTime.now(),
                                    lastDay: DateTime(
                                      DateTime.now().year + 1,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                    ),
                                  ),
                                  SizedBox(height: 20.sp),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 70.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: _dateController,
                                        readOnly: true,
                                        decoration: const InputDecoration(
                                          labelText: 'Selected Date',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.sp),
                                  const Text(
                                    'Select Time',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10.sp),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 60.sp,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: DropdownButton<String>(
                                          hint: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Time',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.blue,
                                          ),
                                          value: valueChoose,
                                          onChanged: (newValue) {
                                            setModalState(() {
                                              valueChoose = newValue!;
                                              _timeController.text = newValue;
                                            });
                                          },
                                          items: listItem.map((valueItem) {
                                            return DropdownMenuItem<String>(
                                              value: valueItem,
                                              child: Text(valueItem),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Close'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async{
                                          if (_timeController.text.isEmpty ||
                                _dateController.text.isEmpty ) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('All fields are required'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }else{
     
                             String userName = await getCurrentUserName();
                             String userImage = await getCurrentImage();
                             // get users im
                               Map<String, dynamic> dataToSave = {
                                'user': user!.uid,
                                'date': _dateController.text,
                                'time': _timeController.text,
                                'name': userName,
                                 'Doctor':widget.doctorDetails['user'],
                                 'Dname':widget.doctorDetails['name'],
                                 'Dlastname':widget.doctorDetails['lastname'],
                                 'Dfield':widget.doctorDetails['field'],
                                 'imageLink':widget.doctorDetails['imageLink'],
                                 'userImage':userImage,
                                 
                              };

                             await FirebaseFirestore.instance.collection("appointments").add(dataToSave);

                           
                               Map<String, dynamic> dataToSave2 = {
                                'user': user!.uid,
                                'name': userName,
                               'created_at': FieldValue.serverTimestamp(),
                                'message': 'has booked an Appointement'
                                 
                              };

                              await FirebaseFirestore.instance.collection("notifications").add(dataToSave2);
 

                            
                                          Navigator.pop(context);
                            }
                                        },
                                        child: const Text('Book'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100.w, 50.h),
                  backgroundColor: MyColors.button1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Book an appointement',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold),
                  ),
                )),
   ),
    
    );
  }
}
