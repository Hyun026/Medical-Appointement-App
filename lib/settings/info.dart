import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Healthly App'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Healthly App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Healthly App is a medical mobile application designed for both doctors and patients.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Features:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              '- Separate accounts for doctors and patients with individual registration and login.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Home pages customized for doctors and patients.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Tools for patients to find doctors and book appointments.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Booking management for doctors, including accepting or updating appointment information.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Access to patient medical files for doctors.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'This app aims to streamline the process of medical appointments and enhance communication between doctors and patients.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'For more information, contact us at supportHealthy@gmail.com.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}