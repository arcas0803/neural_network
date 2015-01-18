library ActivationFunction.GaussianFunction;

import 'activation_function.dart';
import 'dart:math';

class Gaussian implements ActivationFunction {
  double sigma = 0.5;

  double getOutput(double value) => exp(-pow(value, 2) / (2 * pow(this.sigma, 2)));

  double getDerivedOutput(double value) {
    return -((value * exp(-((pow(value, 2)) / (2 * pow(this.sigma, 2))))) / (pow(this.sigma, 2)));
  }

}