// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library InputFunction.Max;

import 'dart:math';
import 'input_function.dart';
import "../../arquitecture/connection.dart";
import "package:json_object/json_object.dart";

class Max extends InputFunction {

  ///
  /// Choose the highest value product for every weight their respective input.
  ///

  double getOutput(List<Connection> inputConnections) {

    List<double> output = [];
    for (Connection temp in inputConnections) {
      output.add(temp.inputNeuronDestination * temp.weightValue);
    }
    return output.reduce(max);

  }

}