// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library ActivationFunction.LogFunction;

import 'activation_function.dart';
import 'dart:math';

class Log extends ActivationFunction {

  double getOutput(double value) => log(value);


  double getDerivedOutput(double value) => 1/value;

}