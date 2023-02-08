import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:readmore/readmore.dart';
import 'package:the_eventors/package/gallery_image/galleryimage.dart';
import 'package:the_eventors/utils.dart';

class BodyOfDetailsEventWidget extends StatefulWidget {
  const BodyOfDetailsEventWidget({Key? key}) : super(key: key);

  @override
  State<BodyOfDetailsEventWidget> createState() =>
      _BodyOfDetailsEventWidgetState();
}

class _BodyOfDetailsEventWidgetState extends State<BodyOfDetailsEventWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 18, // Image radius
                        backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1589894404892-7310b92ea7a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2574&q=80",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("admin")
                    ],
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 5),
                    child: const Text(
                      "Carnival Festival",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(children: const [
                      Icon(Icons.date_range),
                      Text("12 January,2018 | 12:00")
                    ]),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(children: const [
                      Icon(Icons.location_on),
                      Text("B/6, New Delhi,India")
                    ]),
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 10, right: 10),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("People are going"),
                                Text("Se all")
                              ],
                            )),
                        SizedBox(
                          height: 45,
                          child: Stack(
                            children: [
                              for (var i = 0; i < [1, 2, 3, 4].length; i++)
                                Positioned(
                                  left: (i * (1 - .4) * 40).toDouble(),
                                  top: 0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.network(
                                        "https://github.com/identicons/guest.png",
                                      ),
                                    ),
                                    radius: 18,
                                  ),
                                ),
                              Positioned(
                                  left: (5 * (1 - .4) * 40).toDouble(),
                                  top: 10,
                                  child: const Text("+40 Going")),
                            ],
                          ),
                        ),
                      ])),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 10, right: 10),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("People are interested"),
                                Text("Se all")
                              ],
                            )),
                        SizedBox(
                          height: 45,
                          child: Stack(
                            children: [
                              for (var i = 0; i < [1, 2, 3, 4].length; i++)
                                Positioned(
                                  left: (i * (1 - .4) * 40).toDouble(),
                                  top: 0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.network(
                                        "https://github.com/identicons/guest.png",
                                      ),
                                    ),
                                    radius: 18,
                                  ),
                                ),
                              Positioned(
                                  left: (5 * (1 - .4) * 40).toDouble(),
                                  top: 10,
                                  child: const Text("+40 Interested")),
                            ],
                          ),
                        ),
                      ])),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 10),
                    child: const ReadMoreText(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                      trimLines: 5,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Show less',
                      moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                      lessStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 2,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 10),
                    child: const Text(
                      "Host",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: Stack(
                      children: [
                        for (var i = 0; i < [1, 2, 3, 4].length; i++)
                          Positioned(
                            left: (i * (1 - .4) * 40).toDouble(),
                            top: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.circular(50)),
                                padding: const EdgeInsets.all(5.0),
                                child: Image.network(
                                  "https://github.com/identicons/guest.png",
                                ),
                              ),
                              radius: 18,
                            ),
                          ),
                        Positioned(
                            left: (5 * (1 - .4) * 40).toDouble(),
                            top: 10,
                            child: const Text("+40 Going")),
                      ],
                    ),
                  ),
                  GalleryImage(
                    imageUrls: [
                      Utils.image1,
                      Utils.image1,
                      Utils.image1,
                      Utils.image1,
                    ],
                    numOfShowImages: 3,
                  ),
                ])),
          ],
        ));
  }
}
