import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/EventProvider.dart';
import 'package:the_eventors/providers/UserProvider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  late String _searchText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<UserProvider>(context, listen: false)
          .findUserssByQuery(controller.text);
      Provider.of<EventProvider>(context, listen: false)
          .findEventsByQuery(controller.text);
    });
    controller.addListener(() {
      setState(() {
        _searchText = controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SafeArea(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        Row(
                          children: [
                            Flexible(
                                child: SizedBox(
                                    height: 70,
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, top: 16, bottom: 16),
                                        child: TextField(
                                          clipBehavior: Clip.hardEdge,
                                          controller: controller,
                                          onChanged: (value) {
                                            print(value);
                                            Provider.of<EventProvider>(context,
                                                    listen: false)
                                                .findEventsByQuery(value);
                                            Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .findUserssByQuery(value);
                                          },
                                          minLines: 1,
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
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
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8.0,
                                              ),
                                            ),
                                          ),
                                        )))),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 5, top: 20, bottom: 20, right: 16),
                                child: InkWell(
                                  child: Text(
                                    "Cancel",
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: DefaultTabController(
                                    length: 2,
                                    child: Column(
                                      children: [
                                        Material(
                                          elevation: 0,
                                          child: TabBar(
                                            unselectedLabelColor:
                                                Colors.blueAccent,
                                            indicatorSize:
                                                TabBarIndicatorSize.label,
                                            indicator: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.blueAccent),
                                            tabs: [
                                              Tab(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        color:
                                                            Colors.blueAccent,
                                                        width: 1)),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Events"),
                                                ),
                                              )),
                                              Tab(
                                                  child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border: Border.all(
                                                        color:
                                                            Colors.blueAccent,
                                                        width: 1)),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Users"),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: TabBarView(
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              children: [
                                                Consumer<EventProvider>(builder:
                                                    (context, data, child) {
                                                  return ListView.builder(
                                                      shrinkWrap: true,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: data
                                                          .findEvents.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ListTile(
                                                            title: Text(data
                                                                .findEvents[
                                                                    index]
                                                                .title));
                                                      });
                                                }),
                                                Consumer<UserProvider>(builder:
                                                    (context, data, child) {
                                                  return ListView.builder(
                                                      shrinkWrap: true,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: data
                                                          .findUsername.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ListTile(
                                                            title: Text(data
                                                                .findUsername[
                                                                    index]
                                                                .username));
                                                      });
                                                }),
                                              ],
                                            )),
                                      ],
                                    )))),
                      ]))),
            )));
  }
}
