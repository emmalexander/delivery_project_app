import 'package:delivery_project_app/models/user_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  static const id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Email:    ${widget.user.email}'),
            Text('Token:   ${widget.user.token}'),
            Text('Phone:   ${widget.user.phone}'),
            Text('Name:   ${widget.user.name}'),
            Text('Verified Status:   ${widget.user.verified}'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Text('Logout'),
              label: const Icon(Icons.logout),
              onPressed: () async {
                // final logoutValue = await RegistrationService().logout();
                // if (logoutValue == true) {
                //   if (!mounted) return;
                //   Navigator.of(context).pushReplacementNamed('/login');
                // } else {
                //   if (!mounted) return;
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       duration: Duration(seconds: 3),
                //       content: Text(
                //         'error with your token, have to login again',
                //       ),
                //     ),
                //   );
                //   Navigator.of(context).pushReplacementNamed('/login');
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
