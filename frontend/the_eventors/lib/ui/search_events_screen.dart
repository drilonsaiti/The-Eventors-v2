import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:the_eventors/ui/home_screen.dart';
import 'package:the_eventors/ui/search_screen.dart';
import 'package:the_eventors/ui/widgets/category_widget.dart';
import 'package:the_eventors/ui/widgets/events_card_search.dart';

import 'widgets/titles_in_search_widget.dart';

class SearchEventScreen extends StatefulWidget {
  const SearchEventScreen({Key? key}) : super(key: key);

  @override
  State<SearchEventScreen> createState() => _SearchEventScreenState();
}

class _SearchEventScreenState extends State<SearchEventScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                body: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: <Widget>[
                  Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SafeArea(
                        child: Column(
                          children: [
                            SizedBox(
                                height: 70,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    child: TextField(
                                      clipBehavior: Clip.hardEdge,
                                      focusNode: FocusNode(),
                                      minLines: 1,
                                      maxLines: null,
                                      keyboardType: TextInputType.none,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              transitionDuration:
                                                  Duration(seconds: 1),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                animation = CurvedAnimation(
                                                    parent: animation,
                                                    curve: Curves.elasticOut);
                                                return ScaleTransition(
                                                  alignment: Alignment.center,
                                                  scale: animation,
                                                  child: child,
                                                );
                                              },
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return const SearchScreen();
                                              },
                                            ));
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        filled: true,
                                        fillColor: Colors.grey.shade200,
                                        hintText: "Search",
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            width: 10,
                                            color: Colors.white,
                                            style: BorderStyle.none,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                      ),
                                    ))),
                            CategoryWidget(theme: theme),
                            TitleSearchWidget(
                              title: 'Near you',
                              theme: theme,
                            ),
                            const EventCardSearch(),
                            TitleSearchWidget(
                              title: 'Top events',
                              theme: theme,
                            ),
                            const EventCardSearch(),
                            TitleSearchWidget(
                              title: 'All events by category',
                              theme: theme,
                            ),
                            const EventCardSearch(),
                          ],
                        ),
                      )),
                ]))));
  }
}
