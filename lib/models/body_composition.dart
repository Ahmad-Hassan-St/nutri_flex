class BodyComposition {
 late double _muscleMass;
 late double _fatMass;
 late double _calories;
 late double _bodyWaterPercentage;
 late  double _bodyFatPercentage;
 late double _leanMass;

  // Getters
  double get muscleMass => _muscleMass;
  double get fatMass => _fatMass;
  double get calories => _calories;
  double get bodyWaterPercentage => _bodyWaterPercentage;
  double get bodyFatPercentage => _bodyFatPercentage;
  double get leanMass => _leanMass;

  // Setters
  set muscleMass(double value) {
    _muscleMass = value;
  }

  set fatMass(double value) {
    _fatMass = value;
  }

  set calories(double value) {
    _calories = value;
  }

  set bodyWaterPercentage(double value) {
    _bodyWaterPercentage = value;
  }

  set bodyFatPercentage(double value) {
    _bodyFatPercentage = value;
  }

  set leanMass(double value) {
    _leanMass = value;
  }
}
