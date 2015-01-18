// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library ErrorFunction.MeanSquareError;

import 'error_function.dart';

class MeanSquareError implements ErrorFunction {

  double error;
  int numberSteps;

  MeanSquareError() {

    this.error = 0.0;
    this.numberSteps = 0;

  }

  double totalError() => this.error / this.numberSteps;

  void addError(List<double>errors) {

    for (double error in errors) {
      this.error += 0.5 * (error * error);
    }
    this.numberSteps ++;

  }

  void reset() {

    this.error = 0.0;
    this.numberSteps = 0;

  }

}