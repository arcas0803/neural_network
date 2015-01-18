// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library InputFunction.WeightCombination;

import 'input_function.dart';
import "../../arquitecture/connection.dart";

class WeightCombination implements InputFunction {

  ///
  /// Linear combination of weights and inputs.
  ///

  double getOutput(List<Connection> inputConnections) {

    double output = 0.0;
    for (Connection temp in inputConnections) {
      output += temp.inputNeuronDestination * temp.weightValue;
    }
    return output;

  }

}