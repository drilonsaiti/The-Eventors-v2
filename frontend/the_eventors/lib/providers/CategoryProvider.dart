import 'package:flutter/cupertino.dart';

import '../models/Category.dart';
import '../services/CategoryRepository.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository _categoryRepository = CategoryRepository();
  int selectedCategoryId = 0;
  List<Category> categories = [];
  getCategories() async {
    categories = await _categoryRepository.getCategories();
    notifyListeners();
  }

  void updateCategoryId(int selectedCategoryId) {
    this.selectedCategoryId = selectedCategoryId;
    notifyListeners();
  }
}
