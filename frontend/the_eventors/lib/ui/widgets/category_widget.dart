import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/CategoryProvider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../models/Category.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  const CategoryWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<CategoryProvider>(context);
    final isSelected = appState.selectedCategoryId == category.id;
    return GestureDetector(
        onTap: () {
          if (!isSelected) {
            appState.updateCategoryId(category.id);
          }
        },
        child: ZoomTapAnimation(
          beginDuration: const Duration(milliseconds: 300),
          endDuration: const Duration(milliseconds: 500),
          child: Container(
            margin: EdgeInsets.only(right: 8),
            padding: EdgeInsets.only(top: 1, bottom: 1, left: 2, right: 0),
            /* clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: isSelected
                  ? Border.all(
                      color: const Color(0xCCEEFBFB).withOpacity(0.5), width: 2)
                  : null,
            ),*/
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 130,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      //clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: isSelected
                            ? Border.all(
                                color: const Color(0xCCEEFBFB).withOpacity(0.5),
                                width: 4)
                            : null,
                      ),
                    )),
                Container(
                  width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected
                        ? Border.all(
                            color: const Color(0xCCEEFBFB).withOpacity(0.5),
                            width: 2)
                        : null,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: category.imageUrl,
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
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.8),
                                  spreadRadius: 2,
                                  blurRadius: 25,
                                  offset: Offset(
                                      -20, -2), // changes position of shadow
                                ),
                              ]
                            : []),
                    child: Center(
                      child: Text(
                        category.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(
                              0xFFEEFBFB,
                            ),
                            fontSize:
                                category.name.contains("Conference") ? 18 : 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
