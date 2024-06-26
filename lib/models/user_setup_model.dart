import 'package:flutter/physics.dart';

class UserSetup {
  late String _userName;
  late String _goal;
  late String _gender;
  late DateTime _dateOfBirth;
  late int _height;
  late int _weight;
  late int _targetWeight;
  late String _email;
  late String _age;
  late String _BMI;
  late int _bicepSize;
   bool _isUpdate =false;

  // Getters
  String get userName => _userName;
  String get goal => _goal;
  String get gender => _gender;
  DateTime get dateOfBirth => _dateOfBirth;
  int get height => _height;
  int get weight => _weight;
  int get targetWeight => _targetWeight;
  String get email => _email;
  String get age => _age;
  String get BMI   => _BMI;
  int get bicepSize => _bicepSize;
  bool get isUpdate => _isUpdate;

  // Setters
  set userName(String value) => _userName = value;
  set goal(String value) => _goal = value;
  set gender(String value) => _gender = value;
  set dateOfBirth(DateTime value) => _dateOfBirth = value;
  set height(int value) => _height = value;
  set weight(int value) => _weight = value;
  set targetWeight(int value) => _targetWeight = value;
  set email(String value) => _email = value;
  set age(String value) => _age = value;
  set BMI(String value) => _BMI = value;
  set bicepSize(int value) => _bicepSize = value;
  set isUpdate(bool value) => _isUpdate = value;
}


