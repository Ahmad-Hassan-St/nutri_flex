class BodyComposition {
  late double _muscleMass;
  late double _fatMass;
  late double _calories;
  late double _bodyWaterPercentage;
  late double _bodyFatPercentage;
  late double _leanMass;
  late double _questionnaireScore;

  // Constructor
  BodyComposition({
    double muscleMass = 0.0,
    double fatMass = 0.0,
    double calories = 0.0,
    double bodyWaterPercentage = 0.0,
    double bodyFatPercentage = 0.0,
    double leanMass = 0.0,
    double questionnaireScore = 0.0,
  }) {
    _muscleMass = muscleMass;
    _fatMass = fatMass;
    _calories = calories;
    _bodyWaterPercentage = bodyWaterPercentage;
    _bodyFatPercentage = bodyFatPercentage;
    _leanMass = leanMass;
    _questionnaireScore = questionnaireScore;
  }

  // Getters
  double get muscleMass => _muscleMass;
  double get fatMass => _fatMass;
  double get calories => _calories;
  double get bodyWaterPercentage => _bodyWaterPercentage;
  double get bodyFatPercentage => _bodyFatPercentage;
  double get leanMass => _leanMass;
  double get questionnaireScore => _questionnaireScore;

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

  set questionnaireScore(double value) {
    _questionnaireScore = value;
  }
}
