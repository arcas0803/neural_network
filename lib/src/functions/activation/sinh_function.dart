// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library ActivationFunction.SinHFunction;

import 'activation_function.dart';
import 'dart:math';


class Sinh implements ActivationFunction {

  double getOutput(double value) => (pow(E, value) - pow(E, -1 * value)) / 2;


  double getDerivedOutput(double value) => (pow(E, value) + pow(E, -1 * value)) / 2;


}