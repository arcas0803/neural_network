// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library ActivationFunction.LinealFunction;

import 'activation_function.dart';
import "package:json_object/json_object.dart";

class Lineal extends ActivationFunction {

  double deviation = 1.0;

  double getOutput(double value) => value * deviation;


  double getDerivedOutput(double value) => value;

}