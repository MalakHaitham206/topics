import 'package:flutter/material.dart';

class CounterModel with ChangeNotifier {
  // CounterModel.dart
  // This model manages a simple counter state
  // It provides methods to increment, decrement, and reset the counter value.
  int _counter = 0;
  //to get the current counter value
  get counter => _counter;
  void increment() {
    _counter++;
    //Notifies widgets to rebuild
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }
  void reset(){
    _counter=0;
    notifyListeners();
  }
}
