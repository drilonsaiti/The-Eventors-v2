import 'package:flutter/cupertino.dart';
import 'package:the_eventors/repository/CategoryRepository.dart';

import '../models/Category.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository _categoryRepository = CategoryRepository();
  List<Category> categories = [];
  getCategories() async {
    categories = await _categoryRepository.getCategories();
    notifyListeners();
  }
}
