import 'package:delivery_project_app/blocs/bloc_observer.dart';
import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/consts/app_theme.dart';
import 'package:delivery_project_app/pages/home_page.dart';
import 'package:delivery_project_app/pages/otp_page.dart';
import 'package:delivery_project_app/pages/starting_page.dart';
import 'package:delivery_project_app/pages/verification_page.dart';
import 'package:delivery_project_app/services/app_router.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // final observer = MyBlocObserver();
  // Bloc.observer = observer;
  await dotenv.load();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(414, 896),
        builder: (context, index) {
          return RepositoryProvider(
            create: (context) => ApiServices(),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => UserBloc(
                          context: context,
                          apiServices:
                              RepositoryProvider.of<ApiServices>(context),
                        )),
              ],
              child: MaterialApp(
                builder: (context, widget) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: widget!,
                  );
                },
                debugShowCheckedModeBanner: false,
                theme: AppTheme.appTheme,
                home: const Home(),
                onGenerateRoute: AppRouter().onGenerateRoute,
              ),
            ),
          );
        });
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserAddedState) {
          // this state should take you to the home page with the userModel as a state variable
          return const HomePage();
        } else if (state is VerificationState) {
          return const VerificationPage();
        } else if (state is OtpState) {
          print(state.userToken.toString());
          return const OtpPage();
        } else if (state is LoggedInUserState) {
          return const HomePage();
        }
        // else if (state.userToken.isEmpty) {
        //   return const StartingPage();
        // }
        // else if (state.userToken.isNotEmpty) {
        //   print(state.userToken.toString());
        //   return const HomePage();
        // }
        return const StartingPage();
      },
    );
  }
}
