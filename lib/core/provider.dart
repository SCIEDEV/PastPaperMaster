import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:past_paper_master/core/global.dart';
import 'package:dio/dio.dart';

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

  int _startYear = 2018;
  int get startYear => _startYear;
  set startYear(int value) {
    _startYear = value;
    notifyListeners();
  }

  int _endYear = 2022;
  int get endYear => _endYear;
  set endYear(int value) {
    _endYear = value;
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
  String name;

  /// This path does not contain the filename.
  List<String> path;

  CheckoutItem(this.name, this.path);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CheckoutItem && name == other.name;

  @override
  int get hashCode => name.hashCode ^ path.last.hashCode;
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
    // if (_items.any((element) =>
    //     (element.path == item.path && element.name == item.name))) {
    //   return;
    // }
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

// Here comes the hardest ones...

class DownloadItem {
  String name;
  List<String> path;
  String url;
  double progress = 0;
  bool downloading = false;
  DownloadItem(this.name, this.path, this.url);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadItem && name == other.name && url == other.url;

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}

class DownloadCN extends ChangeNotifier {
  Queue<DownloadItem> _downloadQueue = Queue();
  Queue<DownloadItem> get downloadQueue => _downloadQueue;
  set downloadQueue(Queue<DownloadItem> value) {
    _downloadQueue = value;
    notifyListeners();
  }

  List<DownloadItem> _downloading = [];
  List<DownloadItem> get downloading => _downloading;
  set downloading(List<DownloadItem> value) {
    _downloading = value;
    notifyListeners();
  }

  List<DownloadItem> _completed = [];
  List<DownloadItem> get completed => _completed;
  set completed(List<DownloadItem> value) {
    _completed = value;
    notifyListeners();
  }

  List<DownloadItem> _failed = [];
  List<DownloadItem> get failed => _failed;
  set failed(List<DownloadItem> value) {
    _failed = value;
    notifyListeners();
  }

  String _downloadPath = kDownloadPath;
  String get downloadPath => _downloadPath;
  set downloadPath(String value) {
    _downloadPath = value;
    notifyListeners();
  }

  int _currentThreads = 0;
  int _totalShown = 0;
  int get totalShown => _totalShown;
  set totalShown(int value) {
    _totalShown = value;
    notifyListeners();
  }

  void cancelAll() {
    _downloadQueue.clear();
    _failed.clear();
    _totalShown = downloading.length;
    notifyListeners();
  }

  void retryAllFailed() {
    _downloadQueue.addAll(_failed);
    _failed.clear();
    startDownload();
    notifyListeners();
  }

  bool _completeSnackbarShown = true;

  Future<void> startDownload() async {
    if (_downloadQueue.isEmpty) {
      if (!_completeSnackbarShown) {
        ScaffoldMessenger.of(globalContext).showSnackBar(
          SnackBar(
            content: const Text("All downloads completed."),
            action: SnackBarAction(
              label: "Dismiss",
              onPressed: () {
                ScaffoldMessenger.of(globalContext).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
      _completeSnackbarShown = true;
      return;
    }
    _completeSnackbarShown = false;
    if (_currentThreads >= kMaxThreads) {
      return;
    }
    DownloadItem item = _downloadQueue.removeFirst();
    _currentThreads++;
    if (_downloadQueue.isNotEmpty) {
      startDownload();
    }
    item.downloading = true;
    _downloading.add(item);
    notifyListeners();
    Dio(BaseOptions(connectTimeout: 10000, receiveTimeout: 120000)).download(
      item.url,
      "$_downloadPath/${item.name}",
      onReceiveProgress: (count, total) {
        item.progress = count / total;
        _downloading.firstWhere((element) => element.url == item.url).progress =
            item.progress;
        notifyListeners();
      },
    ).then((value) {
      _currentThreads--;
      item.downloading = false;
      _downloading.removeWhere((element) => element.url == item.url);
      _completed.add(item);
      totalShown--;
      notifyListeners();
      if (_downloadQueue.isNotEmpty) {
        startDownload();
      } else {
        if (!_completeSnackbarShown) {
          ScaffoldMessenger.of(globalContext).showSnackBar(
            SnackBar(
              content: const Text("All downloads completed."),
              action: SnackBarAction(
                label: "Dismiss",
                onPressed: () {
                  ScaffoldMessenger.of(globalContext).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
        _completeSnackbarShown = true;
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      _currentThreads--;
      item.downloading = false;
      _downloading.removeWhere((element) => element.url == item.url);
      _failed.add(item);
      notifyListeners();
      if (_downloadQueue.isNotEmpty) {
        startDownload();
      }
    });
  }

  void addDownloads(Set<CheckoutItem> items) {
    for (var item in items) {
      var newDownload = DownloadItem("", [], "");
      newDownload.name = item.name;
      newDownload.path = item.path;
      newDownload.url = "https://papers.gceguide.com/";
      if (item.path[0] == "IGCSE") {
        newDownload.url += "Cambridge%20IGCSE/";
      } else if (item.path[0] == "A(S) Level") {
        newDownload.url += "A%20Levels/";
      } else {
        // Hopefully we won't reach here :(
        throw Exception("Invalid document path: ${item.path[0]}");
      }
      for (var i = 1; i < item.path.length; i++) {
        newDownload.url += "${item.path[i]}/";
      }
      newDownload.url += item.name;
      _downloadQueue.add(newDownload);
      totalShown++;
    }
    startDownload();
    notifyListeners();
  }
}
