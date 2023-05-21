import 'package:delivery_project_app/blocs/user_bloc/user_bloc.dart';
import 'package:delivery_project_app/models/restaurant_model.dart';
import 'package:delivery_project_app/pages/location_page.dart';
import 'package:delivery_project_app/pages/login_signup_page.dart';
import 'package:delivery_project_app/pages/menu_page.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:delivery_project_app/widgets/home_page_widgets/error_widget.dart';
import 'package:delivery_project_app/widgets/home_page_widgets/home_app_bar.dart';
import 'package:delivery_project_app/widgets/home_page_widgets/home_page_loading_list.dart';
import 'package:delivery_project_app/widgets/my_drawer.dart';
import 'package:delivery_project_app/widgets/home_page_widgets/restaurant_widget.dart';
import 'package:delivery_project_app/widgets/search_bar.dart';
import 'package:delivery_project_app/widgets/show_custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ApiServices apiServices;

  final _numberOfPostsPerRequest = 10;

  final PagingController<int, RestaurantModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    context.read<UserBloc>().add(GetUserEvent());
    final blocProviderState = BlocProvider.of<UserBloc>(context).state;
    apiServices = ApiServices();
    apiServices.getUser(blocProviderState.userToken).then((value) {
      if (value.location.isEmpty) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => CustomErrorDialog(
                  title: 'No Location',
                  description: 'Please add location',
                  onPressed: () {
                    Navigator.pushNamed(context, LocationPage.id);
                  },
                  isLogout: false,
                ));
      }
    }).onError((error, stackTrace) {
      BlocProvider.of<UserBloc>(context).add(RemoveUserToken());
      Navigator.pushReplacementNamed(context, LogInSignUpPage.id);
    });

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    await apiServices
        .getRestaurants(pageKey, _numberOfPostsPerRequest, _pagingController)
        .then((value) {
      final isLastPage = value.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(value);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(value, nextPageKey);
      }
    });
  }

  String getShortForm(int number) {
    if (number < 1000) {
      return number
          .toString(); // Return the number as is if it's less than 1000
    } else if (number < 1000000) {
      double shortNumber = number / 1000; // Convert to thousands
      return '${shortNumber.toStringAsFixed(0)}K'; // Format to no decimal places and append 'k'
    } else {
      double shortNumber = number / 1000000; // Convert to millions
      return '${shortNumber.toStringAsFixed(0)}M'; // Format to no decimal places and append 'M'
    }
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
                      onRefresh: () =>
                          Future.sync(() => _pagingController.refresh()),
                      child: PagedListView<int, RestaurantModel>(
                        pagingController: _pagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<RestaurantModel>(
                          firstPageProgressIndicatorBuilder: (context) {
                            //show a column arrangement of shimmer effects
                            return const HomePageLoadingList();
                          },
                          newPageProgressIndicatorBuilder: (context) {
                            return Center(
                              child: SizedBox(
                                  height: 17.h,
                                  width: 17.w,
                                  child: CircularProgressIndicator(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .color)),
                            );
                          },
                          firstPageErrorIndicatorBuilder: (context) {
                            return HomePageErrorWidget(
                                onTryAgain:
                                    _pagingController.retryLastFailedRequest);
                          },
                          itemBuilder: (context, item, index) =>
                              RestaurantWidget(
                            onPressed: () {
                              Navigator.pushNamed(context, MenuPage.id,
                                  arguments: item.id);
                            },
                            restaurantName: item.name ?? '',
                            imageUrl: item.photoUrl ?? '',
                          ),
                        ),
                      ),
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
