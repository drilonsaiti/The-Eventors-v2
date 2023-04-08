import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:badges/badges.dart' as badges;

import 'package:provider/provider.dart';
import 'package:the_eventors/models/dto/ListingAllEventRepsonseDto.dart';
import 'package:the_eventors/models/dto/ListingEventNearRepsonseDto.dart';
import 'package:the_eventors/models/dto/ListingTopEventRepsonseDto.dart';
import 'package:the_eventors/providers/CategoryProvider.dart';
import 'package:the_eventors/ui/list_events_by_selected.dart';
import 'package:the_eventors/ui/profile_screen.dart';
import 'package:the_eventors/ui/search_screen.dart';
import 'package:the_eventors/ui/widgets/category_widget.dart';
import 'package:the_eventors/ui/widgets/events_card_search.dart';

import '../models/Category.dart';
import '../models/Events.dart';
import '../providers/EventProvider.dart';
import '../providers/MyActivityProvider.dart';
import '../services/EventRepository.dart';
import 'all_near_events_map_screen.dart';
import 'home_screen.dart';
import 'list_allevents_by_selected.dart';
import 'notifications_list_screen.dart';
import 'widgets/titles_in_search_widget.dart';

class SearchEventScreen extends StatefulWidget {
  const SearchEventScreen({Key? key}) : super(key: key);

  @override
  State<SearchEventScreen> createState() => _SearchEventScreenState();
}

class _SearchEventScreenState extends State<SearchEventScreen> {
  bool isLoading = true;
  List<Category> categories = [];
  List<ListingAllEventDto> events = [];
  List<ListingEventNearDto> near = [];
  List<ListingTopEventDto> top = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    //Provider.of<EventProvider>(context, listen: false).getAllNear();

    // TODO: implement initState
    super.initState();

    Provider.of<CategoryProvider>(context, listen: false).getCategories();
    Provider.of<EventProvider>(context, listen: false).getAllEvents(0);
    Provider.of<EventProvider>(context, listen: false).getAllTop();

    /*Provider.of<EventProvider>(context, listen: false).getFourNear();
    Provider.of<EventProvider>(context, listen: false).getFourTop();*/

    Future.delayed(Duration(milliseconds: 1000), () async {
      near = await EventRepository().getAllNearEvents();

      categories.add(Category(
          id: 0,
          imageUrl:
              "https://imgs.search.brave.com/nvxaAfjg7HR53aUcuDQ4Wptq5-Ra3zMsvy7Vf6JlLK4/rs:fit:1200:500:1/g:ce/aHR0cHM6Ly9ibG9n/LnN0b3J5YmxvY2tz/LmNvbS93cC1jb250/ZW50L3VwbG9hZHMv/MjAxOC8wNC9Nb3Rp/b24tQkctTGVhZC5q/cGc",
          name: "All",
          description: "All description"));
      categories.addAll(context.read<CategoryProvider>().categories);
      top = context.read<EventProvider>().allTop;

      events = context.read<EventProvider>().allEvents;

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MyActivityProvider>(context).notificationsStatus();

    final theme = Theme.of(context);
    return isLoading
        ? Scaffold(
            backgroundColor: Color(0xFF203647),
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFF007CC7),
              ),
            ))
        : GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                    backgroundColor: Color(0xFF203647),
                    bottomNavigationBar: BottomAppBar(
                        elevation: 4,
                        color: Color(0xFF203647),
                        child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Color(0x4D007CC7),
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  },
                                  icon: Icon(Icons.home_outlined),
                                  color: Color(0xFFEEFBFB),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Ionicons.search),
                                    color: Color(0xFFEEFBFB)),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AllNearEventsMapScreen(),
                                        ));
                                  },
                                  icon: Icon(Icons.map_outlined),
                                  color: Color(0xFFEEFBFB),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationListScreen(
                                            key: UniqueKey(),
                                          ),
                                        ));
                                  },
                                  icon: Column(children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    if (!context
                                        .read<MyActivityProvider>()
                                        .notifications)
                                      const badges.Badge(
                                        badgeContent: Text(''),
                                        child:
                                            Icon(Icons.notifications_outlined,
                                          color: Color(0xFFEEFBFB),
                                        ),
                                      ),
                                    if (context
                                        .read<MyActivityProvider>()
                                        .notifications)
                                      Icon(Icons.notifications_outlined,
                                        color: Color(0xFFEEFBFB),
                                      )
                                  ]),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProfileScreen(
                                              username: "",
                                            ),
                                          ));
                                    },
                                    icon: Icon(Icons.person_outline),
                                    color: Color(0xFFEEFBFB)),
                              ],
                            ))),
                    body: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: SafeArea(
                                  child: Column(children: [
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
                                                        curve:
                                                            Curves.elasticOut);
                                                    return ScaleTransition(
                                                      alignment:
                                                          Alignment.center,
                                                      scale: animation,
                                                      child: child,
                                                    );
                                                  },
                                                  pageBuilder: (context,
                                                      animation,
                                                      secondaryAnimation) {
                                                    return const SearchScreen();
                                                  },
                                                ));
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 10, left: 10),
                                            filled: true,
                                            fillColor: Color(0xFFEEFBFB),
                                            hintText: "Search",
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                width: 10,
                                                color: Colors.white,
                                                style: BorderStyle.none,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8.0,
                                              ),
                                            ),
                                          ),
                                        ))),
                                ChangeNotifierProvider<CategoryProvider>(
                                    create: (_) => CategoryProvider(),
                                    child: SafeArea(
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 15),
                                            child: Consumer<CategoryProvider>(
                                              builder: (context, appState, _) =>
                                                  SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: <Widget>[
                                                    for (final category
                                                        in categories)
                                                      CategoryWidget(
                                                          category: category)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Consumer<CategoryProvider>(
                                              builder: (context, appState, _) =>
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ListEventScreen(
                                                                          id: appState
                                                                              .selectedCategoryId,
                                                                          isAll:
                                                                              "Near",
                                                                        )));
                                                      },
                                                      child: TitleSearchWidget(
                                                        title: 'Near you',
                                                        theme: theme,
                                                      ))),
                                          Container(
                                              child: Consumer<CategoryProvider>(
                                                  builder: (context, appState,
                                                          _) =>
                                                      appState.selectedCategoryId ==
                                                              0
                                                          ? EventCardSearch(
                                                              events: near)
                                                          : EventCardSearch(
                                                              events: near
                                                                  .where((e) =>
                                                                      e.categoryId ==
                                                                      appState
                                                                          .selectedCategoryId)
                                                                  .toList()))),
                                          Consumer<CategoryProvider>(
                                              builder: (context, appState, _) =>
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ListEventScreen(
                                                                              id: appState.selectedCategoryId,
                                                                              isAll: "Top",
                                                                            )))
                                                            .then((value) =>
                                                                setState(() {
                                                                  isLoading =
                                                                      true;
                                                                  initState();
                                                                }));
                                                        ;
                                                      },
                                                      child: TitleSearchWidget(
                                                        title: 'Top events',
                                                        theme: theme,
                                                      ))),
                                          Container(
                                              child: Consumer<CategoryProvider>(
                                                  builder: (context, appState,
                                                          _) =>
                                                      appState.selectedCategoryId ==
                                                              0
                                                          ? EventCardSearch(
                                                              events: top)
                                                          : EventCardSearch(
                                                              events: top
                                                                  .where((e) =>
                                                                      e.categoryId ==
                                                                      appState
                                                                          .selectedCategoryId)
                                                                  .toList()))),
                                          Consumer<CategoryProvider>(
                                              builder: (context, appState, _) =>
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ListAllEventScreen(
                                                                              id: appState.selectedCategoryId,
                                                                            )))
                                                            .then((value) =>
                                                                setState(() {
                                                                  isLoading =
                                                                      true;
                                                                  initState();
                                                                }));
                                                        ;
                                                      },
                                                      child: TitleSearchWidget(
                                                        title:
                                                            'All events by category',
                                                        theme: theme,
                                                      ))),
                                          Container(
                                              child: Consumer<CategoryProvider>(
                                                  builder: (context, appState,
                                                          _) =>
                                                      appState.selectedCategoryId ==
                                                              0
                                                          ? EventCardSearch(
                                                              events: events)
                                                          : EventCardSearch(
                                                              events: events
                                                                  .where((e) =>
                                                                      e.categoryId ==
                                                                      appState
                                                                          .selectedCategoryId)
                                                                  .toList()))),
                                        ],
                                      ),
                                    )),
                              ])))
                        ]))));
  }
}
