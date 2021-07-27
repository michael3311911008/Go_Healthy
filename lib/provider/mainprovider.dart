import 'package:flutter/cupertino.dart';
import 'package:gohealth/data/model/exercise.dart';
import 'package:gohealth/data/model/history_bmi.dart';
import 'package:gohealth/data/service/network_service.dart';

class MainProvider extends ChangeNotifier {
  MainProvider._internal();
  static final _singleton = MainProvider._internal();
  factory MainProvider() => _singleton;

  final NetworkService networkService = NetworkService();
  List<HistoryBmi> _historyBmi = [];
  List<HistoryBmi> get historyBmi => _historyBmi;
  List<Exercise> _exercises = [];
  List<Exercise> get exercises => _exercises;
  loadAllData() async {
    await loadHistoryBmi();
    await loadExercises();
  }

  loadHistoryBmi() async {
    var result = await networkService.getHistoryBmi();
    result.sort((a, b) => b.id.compareTo(a.id));
    _historyBmi = result;
    notifyListeners();
  }

  loadExercises() async {
    var itemList = await networkService.getExercise();
    _exercises = itemList;
    notifyListeners();
  }

  updateBmi(double? height, double? weight) async {
    try {
      await networkService.updateBmi(height!, weight!);
      loadHistoryBmi();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
