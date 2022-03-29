import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoadingController extends ChangeNotifier {
  static LoadingController of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<LoadingController>(context, listen: listen);

  final _loadersMap = <String, bool>{};

  bool isLoading(String screenId) => _loadersMap[screenId] ?? false;

  void startLoading(String screenId) {
    if (_loadersMap[screenId] != true) {
      _loadersMap[screenId] = true;
      notifyListeners();
    }
  }

  void stopLoading({bool notify = true}) {
    if (_loadersMap.isNotEmpty) {
      _loadersMap.clear();
      if (notify) notifyListeners();
    }
  }
}
