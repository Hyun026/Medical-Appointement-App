import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy/search/resultPage.dart';

class Pediatri extends StatefulWidget {
  const Pediatri({super.key});

  @override
  State<Pediatri> createState() => _PediatriState();
}

class _PediatriState extends State<Pediatri> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _getPediatricians() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('doctors')
        .where('field', isEqualTo: 'Pediatrician')
        .get();

    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pediatricians'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getPediatricians(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Pediatricians found'));
          } else {
            List<Map<String, dynamic>> doctors = snapshot.data!;
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> doctor = doctors[index];
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: doctor['imageLink'] != null
                        ? Image.network(doctor['imageLink'], width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.person, size: 50),
                    title: Text(doctor['name']),
                    subtitle: Text(doctor['field']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyResult(doctorDetails: doctor),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}