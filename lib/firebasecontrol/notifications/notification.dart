import 'package:flutter/material.dart';
// for the doctor


class MyNotifications extends StatelessWidget {
  const MyNotifications({Key? key}) : super(key: key);

  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    // Retrieve any arguments passed to this route
    final args = ModalRoute.of(context)!.settings.arguments;

    // Example of showing a notification dialog based on some condition
    // Replace this logic with your own notification logic
    if (args != null && args is String && args == 'show_notification') {
      // Show a dialog when the page is navigated to with specific arguments
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Notification'),
              content: Text('This is a small notification dialog.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text('Notification Screen'),
      ),
    );
  }
}
