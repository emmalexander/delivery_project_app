import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_project_app/models/meal_model.dart';
import 'package:delivery_project_app/models/restaurant_model.dart';
import 'package:delivery_project_app/services/api_services.dart';
import 'package:delivery_project_app/widgets/back_button_widget.dart';
import 'package:delivery_project_app/widgets/home_page_widgets/home_page_image_loading_widget.dart';
import 'package:delivery_project_app/widgets/home_page_widgets/menu_widgets/menu_title_header.dart';
import 'package:delivery_project_app/widgets/home_page_widgets/menu_widgets/menu_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key, required this.restaurantModel}) : super(key: key);
  static const id = 'menu_page';

  final RestaurantModel restaurantModel;
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  PaletteColor? dyColor;
  List<Menu>? menu = <Menu>[];
  @override
  void initState() {
    addColor(widget.restaurantModel.photoUrl);
    context
        .read<ApiServices>()
        .getMenu(restaurantId: widget.restaurantModel.id)
        .then((model) {
      if (model is MealModel) {
        setState(() {
          menu = model.menu;
        });
      }
    });

    super.initState();
  }

  void addColor(String? imageUrl) async {
    final PaletteGenerator pg = await PaletteGenerator.fromImageProvider(
      NetworkImage(imageUrl == null
          ? imageUrl!
          : 'https://media-cdn.tripadvisor.com/media/photo-s/1a/99/aa/92/outdoor-seating-area.jpg'),
      size: const Size(200, 200),
    );
    pg.dominantColor == null
        ? dyColor = PaletteColor(Colors.white, 2)
        : dyColor = pg.dominantColor!;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 100.h,
            automaticallyImplyLeading: false,
            title: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Theme.of(context).highlightColor,
                ),
                child: const BackButtonWidget()),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: MenuTitleHeader(
                  restaurantName: widget.restaurantModel.name!,
                  available: widget.restaurantModel.available!),
            ),
            backgroundColor: dyColor == null ? Colors.white : dyColor!.color,
            pinned: true,
            expandedHeight: 300.h,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                width: double.maxFinite,
                height: 150.h,
                fit: BoxFit.cover,
                imageUrl: widget.restaurantModel.photoUrl!,
                placeholder: (context, url) =>
                    //show a shimmer effect
                    const ImageLoadingWidget(),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.warning_rounded)),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: menu!.length,
            (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: MenuWidget(
                model: menu![index],
                restaurantId: widget.restaurantModel.id!,
              ),
            ),
          ))
        ],
      ),
    );
  }
}
