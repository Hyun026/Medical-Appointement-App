import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/colors/colors.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// for patient
class MyAppointHome extends StatelessWidget {
  final String documentId;
  const MyAppointHome({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference appoint =
        FirebaseFirestore.instance.collection('appointments');
    Size size = MediaQuery.of(context).size;
     DateTime now = DateTime.now();
    return FutureBuilder<DocumentSnapshot>(
        future: appoint.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.exists) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              String imageLink = data['imageLink'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(imageLink),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['Dname'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data['date'] + ' ' + data['time'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Text('Document does not exist');
            }
          }
          return Text('loading..');
        });
  }
}

//for doctor
class MyAppointHom extends StatefulWidget {
  final String documentId;
  const MyAppointHom({required this.documentId});

  @override
  State<MyAppointHom> createState() => _MyAppointHomState();
}

class _MyAppointHomState extends State<MyAppointHom> {
  //for update
  Future<String> getCurrentUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        return userDoc['name'] ?? 'Unknown User';
      }
    }
    return 'Unknown User';
  }

  Future<String> getCurrentUserLastName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        return userDoc['lastname'] ?? 'Unknown User';
      }
    }
    return 'Unknown User';
  }

  Future<String> getCurrentUserImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        return userDoc['imageLink'] ?? 'Unknown User';
      }
    }
    return 'Unknown User';
  }

  Future<String> getCurrentPatientID() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String userId = user.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('user', isEqualTo: userId)
       
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot appointmentDoc = querySnapshot.docs.first;
      return appointmentDoc['user'] ?? 'Unknown User';
    }
  }
  return 'Unknown User';
}
/*
Future<String> getCurrentPatient()async{

}*/

//for update
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
    _timeController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _dateController.text = selectedDay.toLocal().toString().split(' ')[0];
    });
  }


  Future<void> updateAppointment() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      QuerySnapshot appointmentQuery = await FirebaseFirestore.instance
          .collection('appointments')
          .where('Doctor', isEqualTo: user.uid)
          .get();

      if (appointmentQuery.docs.isNotEmpty) {
        DocumentSnapshot appointmentDoc = appointmentQuery.docs.first;

        await FirebaseFirestore.instance
            .collection('appointments')
            .doc(appointmentDoc.id)
            .update({
          'date': _dateController.text,
          'time': _timeController.text,
        });

        // Refresh UI
        setState(() {});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Appointment updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No appointment found for the doctor'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating appointment: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User not authenticated'),
        backgroundColor: Colors.red,
      ),
    );
  }
}


//for notification
  triggerNotification() async {
    String docName = await getCurrentUserName();
    String docLastName = await getCurrentUserLastName();
    String docImage = await getCurrentUserImage();
    String userID = await getCurrentPatientID();

    // Prepare data to save
    Map<String, dynamic> dataToSave2 = {
      'nameD': docName,
      'lastNameD': docLastName,
      'ImageD': docImage,
      'userID': userID,
      'created_at': FieldValue.serverTimestamp(),
      'message': 'Has  Your Updated Appointment Booking'
    };

    // Save to Firestore
    await FirebaseFirestore.instance
        .collection("notificationsforUser")
        .add(dataToSave2);

    // Trigger the notification
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'Healthy',
        title: 'Appointment Updated',
        body: 'Dr. $docName $docLastName has Updated your appointment booking.',
        bigPicture: docImage,
        notificationLayout: NotificationLayout.BigPicture,
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    CollectionReference appoint =
        FirebaseFirestore.instance.collection('appointments');
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
        future: appoint.doc(widget.documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.exists) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              String imageLink = data['userImage'];
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(imageLink),
                            radius: 30,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data['date'] + ' || ' + data['time'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setModalState) {
                                          return SingleChildScrollView(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: const EdgeInsets.all(
                                                  16.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  const Text(
                                                    'Select Date',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight
                                                                .bold),
                                                  ),
                                                  SizedBox(height: 20.sp),
                                                  TableCalendar(
                                                    calendarStyle: CalendarStyle(
                                                        selectedDecoration:
                                                            BoxDecoration(
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
                                                    headerStyle:
                                                        const HeaderStyle(
                                                      formatButtonVisible:
                                                          false,
                                                      titleCentered: true,
                                                    ),
                                                    focusedDay: _focusedDay,
                                                    onDaySelected:
                                                        (selectedDay,
                                                            focusedDay) {
                                                      setModalState(() {
                                                        _selectedDay =
                                                            selectedDay;
                                                        _focusedDay =
                                                            focusedDay;
                                                        _dateController
                                                            .text = DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(
                                                                selectedDay);
                                                      });
                                                    },
                                                    availableGestures:
                                                        AvailableGestures
                                                            .all,
                                                    selectedDayPredicate:
                                                        (day) => isSameDay(
                                                            _selectedDay,
                                                            day),
                                                    firstDay:
                                                        DateTime.now(),
                                                    lastDay: DateTime(
                                                      DateTime.now().year +
                                                          1,
                                                      DateTime.now().month,
                                                      DateTime.now().day,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.sp),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 70.sp,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .all(8.0),
                                                      child: TextField(
                                                        controller:
                                                            _dateController,
                                                        readOnly: true,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Selected Date',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.sp),
                                                  const Text(
                                                    'Select Time',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight
                                                                .bold),
                                                  ),
                                                  SizedBox(height: 10.sp),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    height: 60.sp,
                                                    child: DecoratedBox(
                                                      decoration:
                                                          BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    16.0),
                                                        child:
                                                            DropdownButton<
                                                                String>(
                                                          hint: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              'Time',
                                                              style:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .grey,
                                                                fontSize:
                                                                    14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          isExpanded: true,
                                                          underline:
                                                              const SizedBox(),
                                                          icon: const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: MyColors
                                                                .primaryColor,
                                                          ),
                                                          value:
                                                              valueChoose,
                                                          onChanged:
                                                              (newValue) {
                                                            setModalState(
                                                                () {
                                                              valueChoose =
                                                                  newValue!;
                                                              _timeController
                                                                      .text =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: listItem.map(
                                                              (valueItem) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value:
                                                                  valueItem,
                                                              child: Text(
                                                                  valueItem),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'Close'),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed:
                                                            () async {
                                                          if (_timeController
                                                                  .text
                                                                  .isEmpty ||
                                                              _dateController
                                                                  .text
                                                                  .isEmpty) {
                                                            ScaffoldMessenger.of(
                                                                    context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                    'All fields are required'),
                                                                backgroundColor:
                                                                    Colors
                                                                        .red,
                                                              ),
                                                            );
                                                          } else {
                                                            await updateAppointment();
                                                            //send new notification to user
                                                            triggerNotification();
                              
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        },
                                                        child: const Text(
                                                            'Book'),
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
                                child: const Text('Update'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Text('Document does not exist');
            }
          }
          return Text('loading..');
        });
  }
}
