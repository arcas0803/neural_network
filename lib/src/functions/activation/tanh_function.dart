// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library ActivationFunction.TanHFunction;

import 'activation_function.dart';
import 'dart:math';

class Tanh extends ActivationFunction {

  double getOutput(double value) => ((pow(E, value) - pow(E, -1 * value)) / (pow(E, value) + pow(E, -1 * value)));

  double getDerivedOutput(double value) => (2/(pow(E, value) + pow(E, -1 * value)));

}