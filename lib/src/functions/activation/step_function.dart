// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library ActivationFunction.StepFunction;

import 'activation_function.dart';

class Step extends ActivationFunction {

  /// Determine the height of the stair.
  /// If for example worth minimum 1 and maximum values ​​-1 the function will return either 1 or -1
  double max = 1.0;
  double min = -1.0;

  double getOutput(double value) {
    if (value >= 0) {
      return this.max;
    } else {
      return this.min;
    }
  }

  /// This function does not have derived.

  double getDerivedOutput(double value){
    return null;
  }

}