// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library InputFunction.Min;

import 'dart:math';
import 'input_function.dart';
import "../../arquitecture/connection.dart";

class Min extends InputFunction {

  ///
  /// Choose the minimum value product for every weight their respective input.
  ///

  double getOutput(List<Connection> inputConnections) {
    List<double> output = [];
    for (Connection temp in inputConnections) {
      output.add(temp.inputNeuronDestination * temp.weightValue);
    }
    return output.reduce(min);
  }
}