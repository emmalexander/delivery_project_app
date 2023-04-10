import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Email:    ${state.email}'),
                Text('Token:   ${state.userToken}'),
                Text('Phone:   ${state.phone}'),
                Text('Name:   ${state.name}'),
                Text('Verified Status:   ${state.verified}'),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Text('Logout'),
                  label: const Icon(Icons.logout),
                  onPressed: () {
                    context.read<UserBloc>().add(RemoveUserToken());
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
      },
    );
  }
}
