// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library ActivationFunction.SigmoidFunction;

import 'activation_function.dart';
import 'dart:math';


class Sigmoid implements ActivationFunction {

  double getOutput(double value) => (1 / (1 + pow(E, (-1 * value))));

  double getDerivedOutput(double value) => pow(E, (value)) / (pow((pow(E, value) + 1), 2));


}