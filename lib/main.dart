import 'package:delivery_project_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:delivery_project_app/blocs/order_bloc/order_bloc.dart';
import 'package:delivery_project_app/blocs/switch_bloc/switch_bloc.dart';
import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/consts/app_theme.dart';
import 'package:delivery_project_app/pages/start_up/first_loading_page.dart';
import 'package:delivery_project_app/services/app_router.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//import 'package:get_ip_address/get_ip_address.dart';
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

  // var ip = await IpAddress().getIpAddress();
  // print('my ip: $ip');
  // ApiServices().sendIp(ip);

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
                          apiServices:
                              RepositoryProvider.of<ApiServices>(context),
                        )),
                BlocProvider(create: (context) => SwitchBloc()),
                BlocProvider(create: (context) => OrderBloc()),
                BlocProvider(create: (context) => CartBloc()),
              ],
              child: BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return MaterialApp(
                    builder: (context, widget) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.0),
                        child: widget!,
                      );
                    },
                    debugShowCheckedModeBanner: false,
                    theme: state.switchValue
                        ? AppThemes.appThemeData[AppTheme.darkTheme]
                        : AppThemes.appThemeData[AppTheme.lightTheme],
                    home: const Home(),
                    onGenerateRoute: AppRouter().onGenerateRoute,
                  );
                },
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
        return const FirstLoadingPage();
      },
    );
  }
}
