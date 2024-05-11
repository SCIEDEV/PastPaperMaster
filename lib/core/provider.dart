import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:past_paper_master/core/global.dart';
import 'package:past_paper_master/pages/browse.dart';

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

  String getItemUrl() {
    final StringBuffer url = StringBuffer("https://papers.gceguide.com/");
    if (path.isEmpty) {
      return url.toString();
    }
    if (path[0] == "IGCSE") {
      url.write("Cambridge%20IGCSE/");
    } else if (path[0] == "A(S) Level") {
      url.write("A%20Levels/");
    } else {
      // Hopefully we won't reach here :(
      throw Exception("Invalid document path: ${path[0]}");
    }
    for (var i = 1; i < path.length; i++) {
      url.write("${path[i]}/");
    }
    url.write(name);
    return url.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CheckoutItem && name == other.name;

  @override
  int get hashCode => name.hashCode ^ path.last.hashCode;
}

class BrowseCN extends ChangeNotifier {
  String getViewingDocumentUrl() {
    final StringBuffer url = StringBuffer("https://papers.gceguide.com/");
    if (_path.isEmpty) {
      return url.toString();
    }
    if (_path[0] == "IGCSE") {
      url.write("Cambridge%20IGCSE/");
    } else if (_path[0] == "A(S) Level") {
      url.write("A%20Levels/");
    } else {
      // Hopefully we won't reach here :(
      throw Exception("Invalid document path: ${_path[0]}");
    }
    for (var i = 1; i < _path.length; i++) {
      url.write("${_path[i]}/");
    }
    url.write(viewingPdfName);
    return url.toString();
  }

  String _viewingPdfName = "";
  String get viewingPdfName => _viewingPdfName;
  set viewingPdfName(String value) {
    _viewingPdfName = value;
    notifyListeners();
  }

  List<String> _path = [];
  List<String> get path => _path;
  set path(List<String> value) {
    _path = value;
    _documentEntries =
        getEntries(_path).where((element) => element.isDocument).toList();
    notifyListeners();
  }

  List<BrowseEntry> _documentEntries = [];

  void addPath(String path) {
    _path.add(path);
    _documentEntries =
        getEntries(_path).where((element) => element.isDocument).toList();
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

  void clearSelection() {
    _selection.clear();
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

  void selectAllOnPage() {
    for (final e in _documentEntries) {
      _selection.add(CheckoutItem(e.name, _path));
    }
    notifyListeners();
  }

  void deselectAllOnPage() {
    for (final e in _documentEntries) {
      if (_selection.any((element) => element.name == e.name)) {
        _selection.removeWhere((element) => element.name == e.name);
      }
    }
    notifyListeners();
  }

  bool hasDocumentOnPage() {
    return _documentEntries.isNotEmpty;
  }

  bool? pageSelectionStatus() {
    int count = 0;
    for (final e in _documentEntries) {
      if (_selection.any((element) => element.name == e.name)) {
        count++;
      }
    }

    if (count == _documentEntries.length) {
      return true;
    } else if (count != 0) {
      return null;
    } else {
      return false;
    }
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

  void cancelItem(DownloadItem item) {
    _downloadQueue.removeWhere((element) => element == item);
    _failed.removeWhere((element) => element == item);
    _totalShown = downloading.length + failed.length + downloadQueue.length;
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
    final DownloadItem item = _downloadQueue.removeFirst();
    _currentThreads++;
    if (_downloadQueue.isNotEmpty) {
      startDownload();
    }
    item.downloading = true;
    _downloading.add(item);
    notifyListeners();
    Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(minutes: 3),
      ),
    ).download(
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
    for (final item in items) {
      final newDownload = DownloadItem("", [], "");
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

class SettingsCN extends ChangeNotifier {
  bool _checkingUpdates = false;
  bool get checkingUpdates => _checkingUpdates;
  set checkingUpdates(bool value) {
    _checkingUpdates = value;
    notifyListeners();
  }

  bool? _updateAvailable;
  bool? get updateAvailable => _updateAvailable;
  set updateAvailable(bool? value) {
    _updateAvailable = value;
    notifyListeners();
  }

  bool _checkUpdatesFailed = false;
  bool get checkUpdatesFailed => _checkUpdatesFailed;
  set checkUpdatesFailed(bool value) {
    _checkUpdatesFailed = value;
    notifyListeners();
  }

  bool _specialTheme = false;
  bool get specialTheme => _specialTheme;
  set specialTheme(bool value) {
    _specialTheme = value;
    notifyListeners();
  }

  int _specialThemeBg = 0;
  int get specialThemeBg => _specialThemeBg;
  set specialThemeBg(int value) {
    _specialThemeBg = value;
    notifyListeners();
  }

  String _latestVersion = "";
  String get latestVersion => _latestVersion;
  set latestVersion(String value) {
    _latestVersion = value;
    notifyListeners();
  }

  String _latestReleaseUrl = "";
  String get latestReleaseUrl => _latestReleaseUrl;
  set latestReleaseUrl(String value) {
    _latestReleaseUrl = value;
    notifyListeners();
  }

  DateTime _latestReleaseDate = DateTime(2023);
  DateTime get latestReleaseDate => _latestReleaseDate;
  set latestReleaseDate(DateTime value) {
    _latestReleaseDate = value;
    notifyListeners();
  }

  Future<void> checkForUpdates() {
    _checkingUpdates = true;
    _checkUpdatesFailed = false;
    notifyListeners();
    return Dio()
        .get(
      "https://api.github.com/repos/SCIEDEV/PastPaperMaster/releases/latest",
    )
        .then((value) {
      _checkingUpdates = false;
      notifyListeners();
      if (value.data["tag_name"] != kVersionTag) {
        _updateAvailable = true;
        _latestVersion = value.data["tag_name"];
        _latestReleaseUrl = value.data["html_url"];
        _latestReleaseDate = DateTime.parse(value.data["published_at"]);
      } else {
        _updateAvailable = false;
      }
      notifyListeners();
    }).catchError((error) {
      _checkingUpdates = false;
      _updateAvailable = null;
      _checkUpdatesFailed = true;
      if (kDebugMode) {
        print(error);
      }
      notifyListeners();
    });
  }

  // TODO: Change this to a sealed interface once upgrade to Dart 3 is complete.
  int? _concurrentDownloads;
  int? get concurrentDownloads => _concurrentDownloads;
  set concurrentDownloads(int? value) {
    _concurrentDownloads = value;
    notifyListeners();
  }

  int defaultConcurrentDownloads = Platform.numberOfProcessors ~/ 4;
}


class QuestionResult {
  String questionNo = '';
  String source = '';
  String sourceQpName = '';
  String sourceMsName = '';
  String sourceQpUrl = '';
  String sourceMsUrl = '';

  String questionContent = '';
  String answerContent = '';
}

class QuestionsCN extends ChangeNotifier {
  bool _isSearching = false;
  bool get isSearching => _isSearching;
  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  String _subject = "All Subjects";
  String get subject => _subject;
  set subject(String value) {
    _subject = value;
    notifyListeners();
  }

  int _level = 0;
  int get level => _level;
  set level(int value) {
    _level = value;
    notifyListeners();
  }

  int _questionCount = 0;
  int get questionCount => _questionCount;
  set questionCount(int value) {
    _questionCount = value;
    notifyListeners();
  }

  List<QuestionResult> _results = [];
  List<QuestionResult> get results => _results;
  set results(List<QuestionResult> value) {
    _results = value;
    notifyListeners();
  }

  void addResult(QuestionResult value) {
    _results.add(value);
    notifyListeners();
  }

  void clearResults() {
    _results.clear();
    notifyListeners();
  }

  String _keywords = '';
  String get keywords => _keywords;
  set keywords(String value) {
    _keywords = value;
    notifyListeners();
  }

  Future<dynamic> search() {
    const Map<int, String> zones = {
      0: "",
      1: "ig",
      2: "a",
    };
    _isSearching = true;
    _results.clear();
    final String url =
        "https://data.caiefinder.com/search/data/?subs=${kSearchSubjects[_subject]}&zone=${zones[_level]}&search=$_keywords";
    notifyListeners();
    return Dio().get(url).then((value) {
      final mainarea = parse(value.data.toString()).querySelector("#mainarea");
      var currentQuestion = QuestionResult();
      for (final child in mainarea!.children) {
        if (child.localName == "center") {
          final h3 = child.querySelector("h3");
          if (h3 != null) {
            if (h3.text.contains(" ↓ FOUND ↓ in ")) {
              currentQuestion.sourceQpName =
                  h3.querySelector('a')!.text.split(" ← ")[0];
              currentQuestion.sourceQpUrl =
                  h3.querySelector('a')!.attributes['href']!.replaceFirst(
                        "../pastpapers/view/",
                        "https://caiefinder.com/pastpapers/pdf/",
                      );
            } else if (h3.text
                .contains("↓ Below is the answer to this question ↓ in ")) {
              currentQuestion.sourceMsName =
                  h3.querySelector('a')!.text.split(" ← ")[0];
              currentQuestion.sourceMsUrl =
                  h3.querySelector('a')!.attributes['href']!.replaceFirst(
                        "../pastpapers/view/",
                        "https://caiefinder.com/pastpapers/pdf/",
                      );
            } else {
              if (currentQuestion.questionNo.isNotEmpty) {
                _results.add(currentQuestion);
                currentQuestion = QuestionResult();
              }
              currentQuestion.source = h3.text.replaceFirst("   ", "\n");
            }
          }
        } else if (child.localName == "div") {
          currentQuestion.questionNo = child.text.split(' —')[0];
          currentQuestion.questionContent =
              child.querySelector('text')?.text.trim() ?? "";
        } else if (child.localName == "pre") {
          if (child.className == "mcq") {
            currentQuestion.answerContent =
                "${child.text[child.text.length - 1]} (MCQ)";
          } else {
            currentQuestion.answerContent = child.text;
          }
        }
      }

      _isSearching = false;
      notifyListeners();
    }).catchError((error) {
      _isSearching = false;
      if (kDebugMode) {
        print(error);
      }
      notifyListeners();
    });
  }
}
