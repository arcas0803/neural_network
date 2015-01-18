// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library InputFunction.Difference;

import 'dart:math';
import 'input_function.dart';
import "../../arquitecture/connection.dart";
import "package:json_object/json_object.dart";

class Difference extends InputFunction {

  ///
  /// Calculate the Euclidean distance between the vector of weights and inputs the previous layer.
  ///

  double getOutput(List<Connection> inputConnections) {

    double output = 0.0;
    for (Connection temp in inputConnections) {
      output += pow(temp.inputNeuronDestination - temp.weightValue, 2);
    }
    return sqrt(output);

  }


}