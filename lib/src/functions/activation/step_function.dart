library ActivationFunction.StepFunction;

import 'activation_function.dart';

class Step extends ActivationFunction {

  double max = 1.0;
  double min = -1.0;

  double getOutput(double value) {
    if (value >= 0) {
      return this.max;
    } else {
      return this.min;
    }
  }

  double getDerivedOutput(double value) {
    return null;
  }

}