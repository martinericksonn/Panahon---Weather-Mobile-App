import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:panahon/src/controllers/recent_search_model.dart';
import 'package:panahon/src/screen/search_screen.dart';

class RecentSearchController with ChangeNotifier {
  final Box searchCache = Hive.box('search-history');
  List searches = [];

  RecentSearchController() {
    List results = searchCache.get('search-history', defaultValue: []);
    for (var result in results) {
      searches.add(result);
    }
  }

  remove(int index) {
    searches.removeAt(index);
    saveDataToCache();
  }

  add(String querry) {
    searches.add(querry);
    saveDataToCache();
  }

  saveDataToCache() {
    List<String> dataToStore = [];
    for (var rsc in searches) {
      dataToStore.add(rsc);
    }

    searchCache.put('search-history', dataToStore);
    notifyListeners();
  }
}
