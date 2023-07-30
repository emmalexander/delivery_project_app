import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/consts/global_constants.dart';
import 'package:delivery_project_app/models/restaurant_model.dart';
import 'package:delivery_project_app/pages/login_signup_page.dart';
import 'package:delivery_project_app/pages/menu_page.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:delivery_project_app/widgets/home_page_widgets/home_app_bar.dart';
import 'package:delivery_project_app/widgets/my_drawer.dart';
import 'package:delivery_project_app/widgets/home_page_widgets/restaurant_widget.dart';
import 'package:delivery_project_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ApiServices apiServices;

  List<RestaurantModel> restaurants = [];
  bool hasMore = true;
  final _controller = ScrollController();
  int page = 1;
  bool isLoading = false;

  //final _numberOfPostsPerRequest = 10;

  @override
  void initState() {
    context.read<UserBloc>().add(GetUserEvent());
    final blocProviderState = BlocProvider.of<UserBloc>(context).state;
    apiServices = ApiServices();
    _fetchPage();
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _fetchPage();
      }
    });
    apiServices.getUser(blocProviderState.userToken).then((value) {
      if (value.location.isEmpty) {
        // showDialog(
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (context) => CustomErrorDialog(
        //           title: 'No Location',
        //           description: 'Please add location',
        //           onPressed: () {
        //             Navigator.pushNamed(context, LocationPage.id);
        //           },
        //           isLogout: false,
        //         ));
      }
    }).onError((error, stackTrace) {
      BlocProvider.of<UserBloc>(context).add(RemoveUserToken());
      Navigator.pushReplacementNamed(context, LogInSignUpPage.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchPage() async {
    if (isLoading) return;
    isLoading = true;
    const limit = 10;
    //debugPrint('token $token');
    context
        .read<ApiServices>()
        .getRestaurants(
          page.toString(),
          limit.toString(),
        )
        .then((value) {
      if (value is String) {
        setState(() {
          hasMore = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value)));
      } else {
        setState(() {
          page++;
          isLoading = false;
          if (value.length < limit) {
            hasMore = false;
          }
          restaurants.addAll(value);
        });
      }
    });
  }

  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 0;
      restaurants.clear();
    });
    _fetchPage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: HomeAppBar(
                balance:
                    state.balance == null ? '0' : getShortForm(state.balance!)),
            drawer: const MyDrawer(),
            body: Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Restaurants',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const CustomSearchBar(),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: RefreshIndicator(
                      backgroundColor: Colors.white,
                      onRefresh: () => Future.sync(() => refresh()),
                      child: ListView.builder(
                          controller: _controller,
                          padding: const EdgeInsets.all(8),
                          itemCount: restaurants.length + 1,
                          itemBuilder: (context, index) {
                            if (index < restaurants.length) {
                              return RestaurantWidget(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MenuPage(
                                                restaurantModel:
                                                    restaurants[index],
                                              )));
                                  // Navigator.pushNamed(context, MenuPage.id,
                                  //     arguments: restaurants[index].id);
                                },
                                restaurantName: restaurants[index].name ?? '',
                                imageUrl: restaurants[index].photoUrl ?? '',
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: hasMore
                                      ? CircularProgressIndicator(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .color)
                                      : const Text('No more data to load'),
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
