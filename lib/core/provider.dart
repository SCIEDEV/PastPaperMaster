import 'package:flutter/foundation.dart';

class GeneralCN extends ChangeNotifier {
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;
  set selectedTab(int value) {
    _selectedTab = value;
    notifyListeners();
  }

  bool _showAlphaBanner = true;
  bool get showAlphaBanner => _showAlphaBanner;
  set showAlphaBanner(bool value) {
    _showAlphaBanner = value;
    notifyListeners();
  }
}

class FilterCN extends ChangeNotifier {
  String? _subject;
  String? get subject => _subject;
  set subject(String? value) {
    _subject = value;
    notifyListeners();
  }

  String _board = '';
  String get board => _board;
  set board(String value) {
    _board = value;
    notifyListeners();
  }

  String _level = "IGCSE";
  String get level => _level;
  set level(String value) {
    _level = value;
    notifyListeners();
  }

  List<String> _seasons = [];
  List<String> get seasons => _seasons;
  set seasons(List<String> value) {
    _seasons = value;
    notifyListeners();
  }

  void toggleSeason(String season) {
    if (_seasons.contains(season)) {
      _seasons.remove(season);
    } else {
      _seasons.add(season);
    }
    notifyListeners();
  }

  List<String> _paperNumbers = [];
  List<String> get paperNumbers => _paperNumbers;
  set paperNumbers(List<String> value) {
    _paperNumbers = value;
    notifyListeners();
  }

  void togglePaperNumber(String paperNumber) {
    if (_paperNumbers.contains(paperNumber)) {
      _paperNumbers.remove(paperNumber);
    } else {
      _paperNumbers.add(paperNumber);
    }
    notifyListeners();
  }

  List<String> _paperTypes = [];
  List<String> get paperTypes => _paperTypes;
  set paperTypes(List<String> value) {
    _paperTypes = value;
    notifyListeners();
  }

  void togglePaperType(String paperType) {
    if (_paperTypes.contains(paperType)) {
      _paperTypes.remove(paperType);
    } else {
      _paperTypes.add(paperType);
    }
    notifyListeners();
  }
}

class CheckoutItem {
  final String name;
  final List<String> path;
  CheckoutItem(this.name, this.path);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckoutItem && name == other.name && path == other.path;

  @override
  int get hashCode => name.hashCode ^ path.hashCode;
}

class BrowseCN extends ChangeNotifier {
  List<String> _path = [];
  List<String> get path => _path;
  set path(List<String> value) {
    _path = value;
    notifyListeners();
  }

  void addPath(String path) {
    _path.add(path);
    notifyListeners();
  }

  Set<CheckoutItem> _selection = {};
  Set<CheckoutItem> get selection => _selection;
  set selection(Set<CheckoutItem> value) {
    _selection = value;
    notifyListeners();
  }

  void addSelection(CheckoutItem selection) {
    _selection.add(selection);
    notifyListeners();
  }

  void removeSelection(CheckoutItem selection) {
    _selection.remove(selection);
    notifyListeners();
  }

  bool isSelected(String name) {
    return _selection.any((element) => element.name == name);
  }

  void toggleSelection(String name) {
    if (_selection.any((element) => element.name == name)) {
      _selection.removeWhere((element) => element.name == name);
    } else {
      _selection.add(CheckoutItem(name, _path));
    }
    notifyListeners();
  }
}

class CheckoutCN extends ChangeNotifier {
  Set<CheckoutItem> _items = {};
  Set<CheckoutItem> get items => _items;
  set items(Set<CheckoutItem> value) {
    _items = value;
    notifyListeners();
  }

  void addItem(CheckoutItem item) {
    if (_items.any((element) =>
        (element.path == item.path && element.name == item.name))) {
      return;
    }
    _items.add(item);
    notifyListeners();
  }

  void removeItem(CheckoutItem item) {
    _items.remove(item);
    notifyListeners();
  }

  Set<CheckoutItem> _selected = {};
  Set<CheckoutItem> get selected => _selected;
  set selected(Set<CheckoutItem> value) {
    _selected = value;
    notifyListeners();
  }

  void addSelected(CheckoutItem item) {
    _selected.add(item);
    notifyListeners();
  }

  void toggleSelected(CheckoutItem item) {
    if (_selected.contains(item)) {
      _selected.remove(item);
    } else {
      _selected.add(item);
    }
    notifyListeners();
  }

  void selectAll() {
    _selected.addAll(_items);
    notifyListeners();
  }

  void selectNone() {
    _selected.clear();
    notifyListeners();
  }

  void deleteSelection() {
    _items.removeWhere((element) => _selected.contains(element));
    _selected.clear();
    notifyListeners();
  }
}
