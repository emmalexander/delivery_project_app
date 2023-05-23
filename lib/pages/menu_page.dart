import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_project_app/widgets/back_button_widget.dart';
import 'package:delivery_project_app/widgets/home_page_widgets/home_page_image_loading_widget.dart';
import 'package:delivery_project_app/widgets/home_page_widgets/menu_widgets/menu_title_header.dart';
import 'package:delivery_project_app/widgets/home_page_widgets/menu_widgets/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);
  static const id = 'menu_page';

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  PaletteColor? dyColor;
  @override
  void initState() {
    addColor(
        'https://media-cdn.tripadvisor.com/media/photo-s/1a/99/aa/92/outdoor-seating-area.jpg');
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
              child: const MenuTitleHeader(),
            ),
            backgroundColor: dyColor == null ? Colors.white : dyColor!.color,
            pinned: true,
            expandedHeight: 300.h,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                width: double.maxFinite,
                height: 150.h,
                fit: BoxFit.cover,
                imageUrl:
                    'https://media-cdn.tripadvisor.com/media/photo-s/1a/99/aa/92/outdoor-seating-area.jpg',
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
            childCount: 10,
            (context, index) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: MenuWidget(),
            ),
          ))
        ],
      ),
    );
  }
}
