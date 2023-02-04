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

  List<String> _selection = [];
  List<String> get selection => _selection;
  set selection(List<String> value) {
    _selection = value;
    notifyListeners();
  }

  void addSelection(String selection) {
    _selection.add(selection);
    notifyListeners();
  }

  void removeSelection(String selection) {
    _selection.remove(selection);
    notifyListeners();
  }

  void toggleSelection(String selection) {
    if (_selection.contains(selection)) {
      _selection.remove(selection);
    } else {
      _selection.add(selection);
    }
    notifyListeners();
  }
}
