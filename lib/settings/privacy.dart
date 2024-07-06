import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Your privacy is important to us. It is our policy to respect your privacy regarding any information we may collect from you across our application.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Information We Collect:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              '- Personal Information: We may collect personal information such as your name, email address, etc., when you voluntarily submit it to us.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Usage Data: We may collect non-personal information about how the application is accessed and used, including your device information and actions taken within the application.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'How We Use Your Information:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'We may use the information we collect in the following ways:',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- To personalize user experience',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- To improve our application',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- To send periodic emails regarding your use of the application',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'If you have any questions about this Privacy Policy, please contact us at Healthy@gmail.com.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
