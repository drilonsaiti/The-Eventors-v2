import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/models/Category.dart';
import 'package:the_eventors/providers/CategoryProvider.dart';
import 'package:the_eventors/repository/CategoryRepository.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategoryWidget extends StatefulWidget {
  final ThemeData theme;
  const CategoryWidget({Key? key, required this.theme}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<CategoryProvider>(context, listen: false).getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).categories;
    return Consumer<CategoryProvider>(
        builder: (BuildContext context, CategoryProvider mainProvider, _) {
      return Container(
          height: 60,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return _buildCategory(
                  categories[index], index, widget.theme, categories.length);
            },
          ));
    });
  }
}

Widget _buildCategory(Category category, index, theme, length) {
  return ZoomTapAnimation(
    beginDuration: const Duration(milliseconds: 300),
    endDuration: const Duration(milliseconds: 500),
    child: Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(right: length - 1 == index ? 0 : 8),
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 60,
            child: CachedNetworkImage(
              imageUrl:
                  "https://images.unsplash.com/photo-1589894404892-7310b92ea7a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(110),
              ),
              child: Center(
                child: Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style:
                      theme.textTheme.subtitle1?.copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
