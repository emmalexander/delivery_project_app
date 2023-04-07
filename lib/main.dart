import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/consts/app_theme.dart';
import 'package:delivery_project_app/pages/error_page.dart';
import 'package:delivery_project_app/pages/login_signup_page.dart';
import 'package:delivery_project_app/pages/register_page.dart';
import 'package:delivery_project_app/pages/sign_in_page.dart';
import 'package:delivery_project_app/pages/starting_page.dart';
import 'package:delivery_project_app/pages/verification_page.dart';
import 'package:delivery_project_app/services/app_router.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
        if (state is AddingUserState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ErrorState) {
          return ErrorPage(error: state.error);
        } else if (state is UserAddedState) {
          return const VerificationPage();
        } else if (state.userToken == '') {
          return const StartingPage();
        }
        return const SignInPage();
      },
    );
  }
}
