import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/pages/home_page.dart';
import 'package:delivery_project_app/pages/login_signup_page.dart';
import 'package:delivery_project_app/widgets/show_custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:socket_io_client/socket_io_client.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);
  static const id = 'verification_page';

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  late Socket socket;

  void _connectToServer() {
    socket.onConnect((data) => print('Connected'));
    socket.onConnectError((data) => print('Connection Error: $data'));
    socket.onDisconnect((data) => print('Socket.IO server disconnected'));

    try {
      // print('here');

      // Connect to websocket
      socket.connect();

      //Handle socket events
      socket.on(
          'connect', (_) => print('connect: ${socket.id} ${_.toString()}'));

      socket.on('verifyCheck', (value) {
        if (value == true) {
          Navigator.pushReplacementNamed(context, HomePage.id);
        }
        print(value.toString());
        // BlocProvider.of<UserBloc>(context).add(VerificationToHomePageEvent());
      });

      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

  sendId(id) {
    socket.emit("verifyCheck", id);
  }

  @override
  void initState() {
    final blocProviderState = BlocProvider.of<UserBloc>(context).state;
    socket = io(
      dotenv.env['SOCKET_URI'],
      OptionBuilder()
          .setTransports(['websocket']).setQuery({'username': 'Reo'}).build(),
    );
    _connectToServer();
    print('ID: ${blocProviderState.id.toString()}');
    sendId(blocProviderState.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showDialog(
              context: context,
              builder: (context) => CustomErrorDialog(
                  title: state.errorTitle,
                  description: state.error,
                  onPressed: () => Navigator.pop(context)));
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: [
                CloseButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, LogInSignUpPage.id);
                  },
                ),
              ],
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/98814-email.json',
                    height: 200.h,
                  ),
                  Text(
                    'Verify email address',
                    style:
                        TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Check email for verification ',
                    style: TextStyle(
                        fontSize: 17.sp,
                        color: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .color!
                            .withOpacity(.5)),
                  ),
                  SizedBox(
                      height: 17.h,
                      width: 17.w,
                      child: const CupertinoActivityIndicator())
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
