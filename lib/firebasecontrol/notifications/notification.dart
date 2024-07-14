import 'package:flutter/material.dart';
// for the doctor


class MyNotifications extends StatelessWidget {
  const MyNotifications({Key? key}) : super(key: key);

  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
 
    final args = ModalRoute.of(context)!.settings.arguments;

   
    if (args != null && args is String && args == 'show_notification') {
    
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Notification'),
              content: const Text('This is a small notification dialog.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: const Center(
        child: Text('Notification Screen'),
      ),
    );
  }
}
