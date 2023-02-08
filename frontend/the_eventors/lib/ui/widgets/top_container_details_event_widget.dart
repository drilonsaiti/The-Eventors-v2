import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TopOfDetailsEventWidget extends StatelessWidget {
  const TopOfDetailsEventWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        constraints: const BoxConstraints(maxHeight: 310, minHeight: 310),
        child: CachedNetworkImage(
          imageUrl:
              "https://images.unsplash.com/photo-1589894404892-7310b92ea7a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80",
          fit: BoxFit.cover,
        ),
      ),
      Container(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const CircleBorder()),
                          fixedSize:
                              MaterialStateProperty.all(const Size(20, 20)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.white), // <-- Button color
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.blueAccent; // <-- Splash color
                          }),
                        ),
                      )),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.share,
                                color: Colors.black,
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    const CircleBorder()),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(20, 20)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(0)),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.white), // <-- Button color
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors
                                        .blueAccent; // <-- Splash color
                                }),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.report,
                                color: Colors.black,
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    const CircleBorder()),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(20, 20)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(0)),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.white), // <-- Button color
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors
                                        .blueAccent; // <-- Splash color
                                }),
                              ),
                            )),
                      ])
                ],
              ),
            ],
          )),
      Positioned(
        top: 200,
        left: MediaQuery.of(context).size.width - 65,
        child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ElevatedButton(
              onPressed: () {},
              child: const Icon(
                Icons.bookmark_add_outlined,
                color: Colors.black,
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                fixedSize: MaterialStateProperty.all(const Size(20, 20)),
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.white), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.red; // <-- Splash color
                }),
              ),
            )),
      ),
      Positioned(
          top: 271,
          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  child: Column(
                    children: const [],
                  ),
                ),
              ),
            ),
          ))
    ]);
  }
}
