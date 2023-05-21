import 'package:flutter/material.dart';

import 'home_page_loading_widget.dart';

class HomePageLoadingList extends StatelessWidget {
  const HomePageLoadingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HomePageLoadingWidget(),
        HomePageLoadingWidget(),
        HomePageLoadingWidget(),
        HomePageLoadingWidget(),
        HomePageLoadingWidget(),
      ],
    );
  }
}
