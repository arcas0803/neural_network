// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library ActivationFunction.GaussianFunction;

import 'activation_function.dart';
import "package:json_object/json_object.dart";
import 'dart:math';

class Gaussian extends ActivationFunction {

  double sigma = 0.5;

  double getOutput(double value) => exp(-pow(value, 2) / (2 * pow(this.sigma, 2)));

  double getDerivedOutput(double value) => -((value * exp(-((pow(value, 2))/(2*pow(this.sigma,2)))))/ (pow(this.sigma,2)));

  JsonObject toJSON(){

    JsonObject activationFunction = new JsonObject();
    activationFunction.type = "Gaussian";
    activationFunction.sigma = this.sigma;
    return activationFunction;

  }

}