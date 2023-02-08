/*import 'package:flutter/material.dart';
import 'package:the_eventors/models/Category.dart';
import 'package:the_eventors/services/CategoryService.dart';
import 'package:http/http.dart' as http;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Category>> _newsModel;

  @override
  void initState() {
    super.initState();
    _newsModel = CategoryService().getCategories();
    print("CATEGORIES");
    getEmployees();
    //print(_newsModel);
  }

  Future<List<Category>> getEmployees() async {
    List<Category> categories = [];

    // var data = await http.get(Uri.parse(Strings.category_url));
    //print(data.body);
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("All Employees Details"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _newsModel,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Icon(Icons.error)));
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('First Name' + ' ' + 'Last Name'),
                    subtitle: Text('${snapshot.data[index].name}' +
                        '${snapshot.data[index].description}'),
                  );
                });
          },
        ),
      ),
    );
  }
}*/
